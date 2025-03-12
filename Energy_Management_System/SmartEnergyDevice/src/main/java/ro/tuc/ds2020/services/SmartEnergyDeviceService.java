package ro.tuc.ds2020.services;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ro.tuc.ds2020.controllers.handlers.exceptions.model.ResourceNotFoundException;
import ro.tuc.ds2020.dtos.SmartEnergyDeviceDTO;
import ro.tuc.ds2020.dtos.SmartEnergyDeviceDetailsDTO;
import ro.tuc.ds2020.dtos.builders.SmartEnergyDeviceBuilder;
import ro.tuc.ds2020.entities.SmartEnergyDevice;
import ro.tuc.ds2020.repositories.SmartEnergyDeviceRepository;
import ro.tuc.ds2020.repositories.UserSyncRepository;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class SmartEnergyDeviceService {

    private static final Logger LOGGER = LoggerFactory.getLogger(SmartEnergyDeviceService.class);
    private final SmartEnergyDeviceRepository smartEnergyDeviceRepository;
    private final UserSyncService userSyncService;
    private final UserSyncRepository userSyncRepository;

    @Autowired
    private RabbitTemplate rabbitTemplate;

    private ObjectMapper objectMapper = new ObjectMapper();

    @Autowired
    public SmartEnergyDeviceService(SmartEnergyDeviceRepository smartEnergyDeviceRepository, UserSyncService userSyncService, UserSyncRepository syncRepository) {
        this.smartEnergyDeviceRepository = smartEnergyDeviceRepository;
        this.userSyncService = userSyncService;
        this.userSyncRepository = syncRepository;
    }

    /**
     * Associate a device with a user.
     * Synchronize the user to the device database if not already present.
     */
    public void associateDeviceToUser(int deviceId, UUID userId) {
        SmartEnergyDevice device = smartEnergyDeviceRepository.findById(deviceId)
                .orElseThrow(() -> new ResourceNotFoundException("Device not found"));

        device.setUserId(userId);
        try {
            String jsonMessage = objectMapper.writeValueAsString(device);
            rabbitTemplate.convertAndSend("device.change.exchange", "device.update", jsonMessage);
        } catch (JsonProcessingException e) {
            System.err.println("Error serializing device to JSON: " + e.getMessage());
        }
        smartEnergyDeviceRepository.save(device);

        if (!userSyncService.userExistsInDeviceDB(userId)) {
            userSyncService.syncUserToDeviceDB(userId);
        }

        LOGGER.info("Device with ID {} associated with User ID {}", deviceId, userId);
    }

    public void unassociateDeviceFromUser(int deviceId, UUID userId) {
        SmartEnergyDevice device = smartEnergyDeviceRepository.findById(deviceId)
                .orElseThrow(() -> new ResourceNotFoundException("Device not found"));

        if (!userId.equals(device.getUserId())) {
            throw new IllegalArgumentException("This device is not associated with the specified user.");
        }

        // Remove association
        device.setUserId(null);
        try {
            String jsonMessage = objectMapper.writeValueAsString(device);
            rabbitTemplate.convertAndSend("device.change.exchange", "device.update", jsonMessage);
        } catch (JsonProcessingException e) {
            System.err.println("Error serializing device to JSON: " + e.getMessage());
        }
        smartEnergyDeviceRepository.save(device);

        // Check if the user is associated with any other device
        long associatedDevicesCount = smartEnergyDeviceRepository.countByUserId(userId);
        if (associatedDevicesCount == 0) {
            userSyncRepository.deleteById(userId);
        }
    }


    /**
     * Retrieve all Smart Energy Devices as DTOs.
     */

    public List<SmartEnergyDeviceDTO> findUsersSmartEnergyDevices(UUID userId) {
        List<SmartEnergyDevice> smartEnergyDeviceList = smartEnergyDeviceRepository.findUsersDevices(userId);
        return smartEnergyDeviceList.stream()
                .map(SmartEnergyDeviceBuilder::toSmartEnergyDeviceDTO)
                .collect(Collectors.toList());
    }

    public List<SmartEnergyDeviceDTO> findSmartEnergyDevices() {
        List<SmartEnergyDevice> smartEnergyDeviceList = smartEnergyDeviceRepository.findAll();
        return smartEnergyDeviceList.stream()
                .map(SmartEnergyDeviceBuilder::toSmartEnergyDeviceDTO)
                .collect(Collectors.toList());
    }

    /**
     * Retrieve a specific Smart Energy Device by its ID.
     */
    public SmartEnergyDeviceDTO findSmartEnergyDeviceById(int id) {
        SmartEnergyDevice device = smartEnergyDeviceRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException(SmartEnergyDevice.class.getSimpleName() + " with id: " + id));
        return SmartEnergyDeviceBuilder.toSmartEnergyDeviceDTO(device);
    }

    /**
     * Insert a new Smart Energy Device and return its ID.
     */
    public int insert(SmartEnergyDeviceDetailsDTO smartEnergyDeviceDTO) {
        SmartEnergyDevice smartEnergyDevice = SmartEnergyDeviceBuilder.toEntity(smartEnergyDeviceDTO);
        smartEnergyDevice = smartEnergyDeviceRepository.save(smartEnergyDevice);
        LOGGER.debug("SmartEnergyDevice with id {} was inserted in db", smartEnergyDevice.getId());
        return smartEnergyDevice.getId();
    }

    /**
     * Update an existing Smart Energy Device by its ID.
     */
    public void update(int id, SmartEnergyDeviceDetailsDTO smartEnergyDeviceDTO) {
        SmartEnergyDevice device = smartEnergyDeviceRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException(SmartEnergyDevice.class.getSimpleName() + " with id: " + id));

        device.setDescription(smartEnergyDeviceDTO.getDescription());
        device.setAddress(smartEnergyDeviceDTO.getAddress());
        device.setMaxHourlyConsumption(smartEnergyDeviceDTO.getMaxHourlyConsumption());

        smartEnergyDeviceRepository.save(device);
        try {
            String jsonMessage = objectMapper.writeValueAsString(device);
            rabbitTemplate.convertAndSend("device.change.exchange", "device.update", jsonMessage);
        } catch (JsonProcessingException e) {
            System.err.println("Error serializing device to JSON: " + e.getMessage());
        }
        LOGGER.info("SmartEnergyDevice with ID {} updated successfully", id);
    }

    /**
     * Delete a Smart Energy Device by its ID.
     */
    public void delete(int id) {
        SmartEnergyDevice device = smartEnergyDeviceRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException(SmartEnergyDevice.class.getSimpleName() + " with id: " + id));

        UUID userId = device.getUserId(); // Get the associated user ID, if any

        // If the device is associated with a user, unassociate it first
        if (userId != null) {
            device.setUserId(null); // Remove association
            smartEnergyDeviceRepository.save(device);

            // Check if the user is associated with any other devices
            long associatedDevicesCount = smartEnergyDeviceRepository.countByUserId(userId);
            if (associatedDevicesCount == 0) {
                // If the user has no other associated devices, remove the user from the sync table
                userSyncRepository.deleteById(userId);

            }
        }

        // Proceed to delete the device
        smartEnergyDeviceRepository.deleteById(id);
        rabbitTemplate.convertAndSend("device.change.exchange", "device.delete", id);
        LOGGER.info("SmartEnergyDevice with ID {} deleted successfully", id);
    }


    public void removeDeviceUserAssociation(int deviceId) {
        SmartEnergyDevice device = smartEnergyDeviceRepository.findById(deviceId)
                .orElseThrow(() -> new ResourceNotFoundException("Device not found"));

        UUID userId = device.getUserId();

        if (userId == null) {
            LOGGER.info("Device with ID {} is not associated with any user.", deviceId);
            return;
        }

        // Remove user association from the device
        device.setUserId(null);
        smartEnergyDeviceRepository.save(device);
        LOGGER.info("User association removed from device with ID {}", deviceId);

        // Check if the user has any other associated devices
        boolean userHasOtherDevices = smartEnergyDeviceRepository.existsByUserId(userId);

        if (!userHasOtherDevices) {
            // Remove the user from the sync table if they have no associated devices
            userSyncService.deleteById(userId);
            LOGGER.info("User with ID {} removed from the sync table as they have no more associated devices.", userId);
        }
    }
}
