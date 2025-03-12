package ro.tuc.ds2020.Consumer;

import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;


import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.web.client.RestTemplate;
import ro.tuc.ds2020.dtos.DeviceInfoDTO;
import ro.tuc.ds2020.dtos.DeviceInfoDetailsDTO;
import ro.tuc.ds2020.dtos.EnergyConsumptionDetailsDTO;
import ro.tuc.ds2020.services.DeviceInfoService;
import ro.tuc.ds2020.services.EnergyConsumptionService;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicBoolean;


@Component
public class EnergyMessageListener {

    @Autowired
    private SimpMessagingTemplate template;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private DeviceInfoService deviceInfoService;

    @Autowired
    private EnergyConsumptionService consumptionService;

    private ObjectMapper mapper = new ObjectMapper();

    @RabbitListener(queues = "energy-queue")
    public void receiveMessage(String message) {
        System.out.println("Received message: " + message);
        try {
            JsonNode rootNode = mapper.readTree(message);
            int deviceId = rootNode.get("device_id").asInt();
            double measurementValue = rootNode.get("measurement_value").asDouble();
            long epochMillis = rootNode.get("timestamp").asLong();
            LocalDateTime timestamp = LocalDateTime.ofInstant(Instant.ofEpochMilli(epochMillis), ZoneId.systemDefault());

            // Check if the device exists
            if (deviceExists(deviceId)) {
                // If exists, process the message
                EnergyConsumptionDetailsDTO dto = new EnergyConsumptionDetailsDTO();
                dto.setDeviceId(deviceId);
                dto.setEnergyConsumed(measurementValue);
                dto.setTimestamp(timestamp);
                // Assume timestamp handling here
                consumptionService.save(dto);
                processAndNotify(message);
                if(!deviceInfoExists(deviceId))
                    addDeviceInfo(deviceId);
                processAndNotify(message);
            } else {
                System.out.println("Device not found: " + deviceId);
            }

        } catch (Exception e) {
            System.err.println("Error processing message: " + e.getMessage());
        }
    }

    private void addDeviceInfo(int deviceId) {
        String url = "http://localhost:8080/smartenergydevice";
        JsonNode devicesNode = restTemplate.getForObject(url, JsonNode.class);
        if (devicesNode.isArray()) {
            for (JsonNode deviceNode : devicesNode) {
                if (deviceNode.get("id").asInt() == deviceId) {
                    DeviceInfoDetailsDTO dto = new DeviceInfoDetailsDTO();
                    dto.setDeviceId(deviceId);
                    dto.setDescription(deviceNode.get("description").asText());
                    if (!deviceNode.get("userId").isNull()) {
                        UUID userId = UUID.fromString(deviceNode.get("userId").asText());
                        dto.setUserId(userId);
                    } else {
                        dto.setUserId(null);
                    }
                    dto.setMaxHourlyConsumption(deviceNode.get("maxHourlyConsumption").asDouble());

                    deviceInfoService.save(dto);
                    System.out.println("Added device info for device ID: " + deviceId);
                    break;
                }
            }
        }
    }

    private boolean deviceInfoExists(int deviceId) {
        Optional<DeviceInfoDetailsDTO> deviceInfo = deviceInfoService.findById(deviceId);
        AtomicBoolean b = new AtomicBoolean(false);
        deviceInfo.ifPresentOrElse(
                dto -> {
                    // Process with the device info DTO
                    b.set(true);
                },
                () -> {
                    // Handle the case where the device is not found

                    b.set(false);
                }
        );
        return b.get();
    }

    private boolean deviceExists(int deviceId) {
        String url = "http://localhost:8080/smartenergydevice";
        String json = restTemplate.getForObject(url, String.class); // Fetch the JSON string
        ObjectMapper mapper = new ObjectMapper();
        try {
            JsonNode devicesNode = mapper.readTree(json);
            if (devicesNode.isArray()) {
                for (JsonNode deviceNode : devicesNode) {
                    if (deviceNode.has("id") && deviceNode.get("id").asInt() == deviceId) {
                        return true; // Device with the specified ID found
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Error checking device existence: " + e.getMessage());
            return false; // In case of an error, consider the device does not exist
        }
        return false; // No device found with the specified ID
    }

    public void processAndNotify(String message) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode rootNode = mapper.readTree(message);
            int deviceId = rootNode.get("device_id").asInt();
            double measurementValue = rootNode.get("measurement_value").asDouble();

            // Retrieve device info from the repository
            Optional<DeviceInfoDetailsDTO> optionalDeviceInfo = deviceInfoService.findById(deviceId);
            if (!optionalDeviceInfo.isPresent()) {
                System.out.println("Device not found with ID: " + deviceId);
                return;
            }

            DeviceInfoDetailsDTO device = optionalDeviceInfo.get();

            // Calculate the sum of all measurements in the last hour for this device
            LocalDateTime oneHourAgo = LocalDateTime.now().minusHours(1);
            double sumMeasurements = consumptionService.sumMeasurementsFromLastHour(deviceId, oneHourAgo);

            if ((sumMeasurements + measurementValue) > device.getMaxHourlyConsumption()) {
                System.out.println("Alert: Total consumption in the last hour for device ID " + deviceId + " exceeds the capacity.");

                // Construct the notification message
                String notification = String.format("Alert: Consumption in the last hour for device ID %d is %.2f kWh which exceeds the capacity of %.2f kWh.",
                        deviceId, sumMeasurements + measurementValue, device.getMaxHourlyConsumption());

                // Log which path the notification will take
                if (device.getUserId() != null) {
                    System.out.println("Sending notification to specific user: " + device.getUserId());
                    template.convertAndSendToUser(device.getUserId().toString(), "/queue/notifications", notification);
                } else {
                    System.out.println("Sending notification to general topic.");
                    template.convertAndSend("/topic/notifications", notification);
                }
            }
        } catch (Exception e) {
            System.err.println("Error processing message: " + e.getMessage());
        }
    }

    }



