package ro.tuc.ds2020.services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import ro.tuc.ds2020.controllers.handlers.exceptions.model.ResourceNotFoundException;
import ro.tuc.ds2020.dtos.UserAccountDTO;
import ro.tuc.ds2020.dtos.UserAccountDetailsDTO;
import ro.tuc.ds2020.dtos.builders.UserAccountBuilder;
import ro.tuc.ds2020.entities.UserAccount;
import ro.tuc.ds2020.entities.UserSync;
import ro.tuc.ds2020.repositories.UserAccountRepository;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;


@Service
public class UserAccountService {

    private static final Logger LOGGER = LoggerFactory.getLogger(UserAccountService.class);
    private final UserAccountRepository userAccountRepository;
    private final RestTemplate restTemplate;

    @Autowired
    public UserAccountService(UserAccountRepository userAccountRepository, RestTemplate restTemplate) {
        this.userAccountRepository = userAccountRepository;
        this.restTemplate = restTemplate;
    }

    /**
     * Find all user accounts and map them to DTOs.
     */
    public List<UserAccountDTO> findUserAccounts() {
        List<UserAccount> userAccountList = userAccountRepository.findAll();
        return userAccountList.stream()
                .map(UserAccountBuilder::toUserAccountDTO)
                .collect(Collectors.toList());
    }

    /**
     * Find a user account by its ID.
     */
    public UserAccountDTO findUserAccountById(UUID id) {
        Optional<UserAccount> userAccountOptional = userAccountRepository.findById(id);
        if (!userAccountOptional.isPresent()) {
            LOGGER.error("UserAccount with id {} was not found in db", id);
            throw new ResourceNotFoundException(UserAccount.class.getSimpleName() + " with id: " + id);
        }
        return UserAccountBuilder.toUserAccountDTO(userAccountOptional.get());
    }

    /**
     * Insert a new user account.
     */
    public UUID insert(UserAccountDetailsDTO userDTO) {
        // Check if email already exists
        if (userAccountRepository.findByEmail(userDTO.getEmail()) != null) {
            return null; // Indicate that the email is already in use
        }

        UserAccount userAccount = new UserAccount(
                userDTO.getName(),
                userDTO.getRole(),
                userDTO.getPassword(),
                userDTO.getEmail()
        );
        userAccount = userAccountRepository.save(userAccount);
        return userAccount.getId();
    }

    public UserAccountDTO login(String email, String password) {
        UserAccount user = userAccountRepository.findByEmail(email);

        if (user == null) {
            System.out.println("User not found for email: " + email);
        } else {
            System.out.println("User retrieved: " + user.getEmail() + " | Password: " + user.getPassword());
        }

        if (user != null && user.getPassword().equals(password)) {
            return UserAccountBuilder.toUserAccountDTO(user);
        }

        return null;
    }


    public void updateUser(UUID id, UserAccountDetailsDTO userDTO) {
        // Logging input for debugging
        System.out.println("Updating user with ID: " + id + ", Data: " + userDTO);

        // Find the existing user
        UserAccount existingUser = userAccountRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with id: " + id));

        // Check email uniqueness
        UserAccount userWithEmail = userAccountRepository.findByEmail(userDTO.getEmail());
        if (userWithEmail != null && !userWithEmail.getId().equals(id)) {
            throw new IllegalArgumentException("Email already exists for another user: " + userDTO.getEmail());
        }

        // Update details
        existingUser.setName(userDTO.getName());
        existingUser.setEmail(userDTO.getEmail());
        existingUser.setPassword(userDTO.getPassword());
        existingUser.setRole(userDTO.getRole());
        userAccountRepository.save(existingUser);

        // Synchronize with the device database
        try {
            updateUserInDeviceDatabase(id, userDTO);
        } catch (Exception e) {
            // Log the error for debugging purposes
            System.err.println("Failed to update user in device database: " + e.getMessage());
            e.printStackTrace();
        }
    }
    private static final String DEVICE_SERVICE_URL = "http://localhost:8080/smartenergydevice"; // Ensure this is correct

    private void updateUserInDeviceDatabase(UUID userId, UserAccountDetailsDTO userDTO) {
        // Create HTTP headers for the request
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // Wrap the request in an HttpEntity
        HttpEntity<String> entity = new HttpEntity<>(headers);

        try {
            // Call the getSmartEnergyDevices endpoint to fetch all devices
            System.out.println("Fetching devices from smart energy service...");

            ResponseEntity<List<Map<String, Object>>> response = restTemplate.exchange(
                    DEVICE_SERVICE_URL,
                    HttpMethod.GET,
                    entity,
                    new ParameterizedTypeReference<List<Map<String, Object>>>() {}
            );

            // Extract the list of devices from the response
            List<Map<String, Object>> devices = response.getBody();

            // Print the list of devices to debug
            System.out.println("Fetched devices: " + devices);

            // Check if any device is associated with the given userId
            boolean isUserAssociated = devices.stream()
                    .anyMatch(device -> userId.toString().equals(device.get("userId"))); // Check if the userId matches

            // Print whether the user is associated with any device
            if (isUserAssociated) {
                System.out.println("User with ID " + userId + " is associated with a device.");
            } else {
                System.out.println("User with ID " + userId + " is not associated with any device.");
            }

            // If the user is not associated with any device, skip syncing
            if (!isUserAssociated) {
                System.out.println("Skipping sync with device database as user is not associated with any device.");
                return;  // Skip updating the device database
            }

            // Proceed with syncing the user if they are associated with at least one device
            UserSync updatedUserSync = new UserSync(userId, userDTO.getName(), userDTO.getEmail(), userDTO.getRole());

            // Print the details of the user to be synced
            System.out.println("Preparing to sync user: " + updatedUserSync);

            // Make the POST request to sync the user with the device database
            HttpEntity<UserSync> requestEntity = new HttpEntity<>(updatedUserSync, headers);
            ResponseEntity<String> syncResponse = restTemplate.exchange(
                    "http://localhost:8080/sync/users",  // API endpoint for syncing user to the device DB
                    HttpMethod.POST,  // POST or PUT depending on your backend
                    requestEntity,
                    String.class
            );

            // Check if the update was successful
            if (syncResponse.getStatusCode() == HttpStatus.OK) {
                System.out.println("User successfully updated in the device database.");
            } else {
                System.err.println("Failed to update user in device database. Status code: " + syncResponse.getStatusCode());
            }

        } catch (Exception e) {
            System.err.println("Error updating user in device database: " + e.getMessage());
        }
    }






    public void deleteUser(UUID id) {
        // Check if the user exists
        Optional<UserAccount> userAccount = userAccountRepository.findById(id);
        if (userAccount.isEmpty()) {
            throw new ResourceNotFoundException("User not found with id: " + id);
        }

        // Fetch all devices associated with this user
        List<Map<String, Object>> devices = getDevices();

        // Find if there are any devices associated with this user
        boolean isUserAssociated = devices.stream()
                .anyMatch(device -> id.toString().equals(device.get("userId")));

        if (isUserAssociated) {
            System.out.println("User is associated with a device, unassociating before deletion...");
            unassociateUserFromDevices(id);  // Call to unassociate user from devices
        } else {
            System.out.println("User is not associated with any device. Proceeding with deletion...");
        }

        // Delete the user from the user database
        userAccountRepository.deleteById(id);
        System.out.println("User with ID " + id + " has been deleted.");
    }

    private List<Map<String, Object>> getDevices() {
        // Call to get all devices
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<List<Map<String, Object>>> response = restTemplate.exchange(
                "http://localhost:8080/smartenergydevice", // Fetching all devices
                HttpMethod.GET,
                entity,
                new ParameterizedTypeReference<List<Map<String, Object>>>() {}
        );

        return response.getBody();
    }

    private void unassociateUserFromDevices(UUID userId) {
        // Fetch all devices associated with the user
        List<Map<String, Object>> devices = getDevices();

        // Filter devices that belong to the user and unassociate them
        devices.stream()
                .filter(device -> userId.toString().equals(device.get("userId")))
                .forEach(device -> {
                    int deviceId = (int) device.get("id");
                    System.out.println("Unassociating device with ID: " + deviceId);
                    unassociateDeviceFromUser(deviceId, userId);  // Call to unassociate the device
                });
    }

    private void unassociateDeviceFromUser(int deviceId, UUID userId) {
        // Prepare the unassociation request payload
        Map<String, Object> unassociationRequest = Map.of(
                "deviceId", deviceId,
                "userId", userId.toString()  // User ID as string
        );

        // Make the unassociation API call
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(unassociationRequest, headers);

        ResponseEntity<String> response = restTemplate.exchange(
                "http://localhost:8080/smartenergydevice/unassociate",  // Endpoint for unassociation
                HttpMethod.POST,
                entity,
                String.class
        );

        if (response.getStatusCode() == HttpStatus.OK) {
            System.out.println("Device successfully unassociated from user.");
        } else {
            System.err.println("Failed to unassociate device. Status code: " + response.getStatusCode());
        }
    }

    // Additional methods for updating or deleting UserAccounts could be added as needed.
}
