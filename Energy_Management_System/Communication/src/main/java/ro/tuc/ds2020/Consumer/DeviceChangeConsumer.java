package ro.tuc.ds2020.Consumer;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.rabbit.annotation.Queue;
import org.springframework.amqp.rabbit.annotation.QueueBinding;
import org.springframework.amqp.rabbit.annotation.Exchange;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import ro.tuc.ds2020.dtos.DeviceInfoDTO;
import ro.tuc.ds2020.dtos.DeviceInfoDetailsDTO;
import ro.tuc.ds2020.services.DeviceInfoService;
import ro.tuc.ds2020.services.EnergyConsumptionService;

import java.io.IOException;
import java.util.UUID;

@Component
public class DeviceChangeConsumer {

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Autowired
    private DeviceInfoService deviceInfoService;
    @Autowired
    private EnergyConsumptionService energyConsumptionService;

    @RabbitListener(bindings = @QueueBinding(
            value = @Queue(value = "device.update.queue", durable = "true"),
            exchange = @Exchange(value = "device.change.exchange", type = "topic"),
            key = "device.update"
    ))
    public void receiveUpdate(String message) {
        try {
            JsonNode deviceNode = objectMapper.readTree(message);
            System.out.println("Received update for device: " + deviceNode);

            DeviceInfoDetailsDTO dto = new DeviceInfoDetailsDTO(
                    deviceNode.get("id").asInt(),
                    deviceNode.get("description").asText(),
                    deviceNode.get("maxHourlyConsumption").asDouble(),
                    deviceNode.has("userId") && !deviceNode.get("userId").isNull() ? UUID.fromString(deviceNode.get("userId").asText()) : null
            );

            deviceInfoService.updateDeviceInfo(dto);
        } catch (IOException e) {
            System.err.println("Error processing update message: " + e.getMessage());
        }
    }

    @RabbitListener(bindings = @QueueBinding(
            value = @Queue(value = "device.delete.queue", durable = "true"),
            exchange = @Exchange(value = "device.change.exchange", type = "topic"),
            key = "device.delete"
    ))
    public void receiveDelete(Integer deviceId) {
        // Print the device ID that is to be deleted
        System.out.println("Received delete request for device ID: " + deviceId);
        deviceInfoService.delete(deviceId);
        energyConsumptionService.deleteAllMeasurementsByDeviceID(deviceId);
        System.out.println("Device deleted");
        // Here you can add the logic to handle device deletion
    }
}
