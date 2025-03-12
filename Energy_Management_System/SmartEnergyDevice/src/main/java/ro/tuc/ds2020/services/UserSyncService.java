package ro.tuc.ds2020.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import ro.tuc.ds2020.entities.UserSync;
import ro.tuc.ds2020.repositories.UserSyncRepository;

import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Service
public class UserSyncService {

    private final UserSyncRepository userSyncRepository;
    private final RestTemplate restTemplate;

    @Autowired
    public UserSyncService(UserSyncRepository userSyncRepository, RestTemplate restTemplate) {
        this.userSyncRepository = userSyncRepository;
        this.restTemplate = restTemplate;
    }

    // Save or Update User in UserSync table
    public UserSync saveOrUpdateUser(UserSync userSync) {
        return userSyncRepository.save(userSync);
    }

    // Find User by ID
    public Optional<UserSync> findById(UUID id) {
        return userSyncRepository.findById(id);
    }

    // Delete User by ID
    public void deleteById(UUID id) {
        userSyncRepository.deleteById(id);
    }

    // Check if User exists in Device DB
    public boolean userExistsInDeviceDB(UUID userId) {
        return userSyncRepository.existsById(userId);
    }

    // Synchronize User to Device DB
    public void syncUserToDeviceDB(UUID userId) {
        String userServiceUrl = "http://localhost:8081/useraccount/" + userId;

        try {
            RestTemplate restTemplate = new RestTemplate();
            ResponseEntity<Map<String, Object>> response = restTemplate.exchange(
                    userServiceUrl,
                    HttpMethod.GET,
                    null,
                    new ParameterizedTypeReference<Map<String, Object>>() {}
            );


            if (response.getStatusCode() == HttpStatus.OK) {
                Map<String, Object> user = response.getBody();
                if (user != null) {
                    // Extract necessary fields from the user object
                    UserSync userSync = new UserSync();
                    userSync.setId(UUID.fromString((String) user.get("id")));
                    userSync.setName((String) user.get("name"));
                    userSync.setEmail((String) user.get("email"));
                    userSync.setRole((String) user.get("role"));

                    userSyncRepository.save(userSync);
                }
            } else {
                throw new RuntimeException("Failed to fetch user from User Service");
            }
        } catch (Exception ex) {
            throw new RuntimeException("Error syncing user to device DB: " + ex.getMessage(), ex);
        }
    }

}
