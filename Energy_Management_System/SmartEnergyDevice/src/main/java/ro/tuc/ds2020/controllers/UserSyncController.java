package ro.tuc.ds2020.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ro.tuc.ds2020.entities.UserSync;
import ro.tuc.ds2020.services.UserSyncService;

@RestController
@RequestMapping("/sync/users")
public class UserSyncController {

    private final UserSyncService userSyncService;

    @Autowired
    public UserSyncController(UserSyncService userSyncService) {
        this.userSyncService = userSyncService;
    }

    @PostMapping
    public ResponseEntity<?> syncUser(@RequestBody UserSync userSync) {
        userSyncService.saveOrUpdateUser(userSync);
        return ResponseEntity.ok("User synchronized successfully.");
    }


}
