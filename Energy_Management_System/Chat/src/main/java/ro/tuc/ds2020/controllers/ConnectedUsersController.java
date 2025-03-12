package ro.tuc.ds2020.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ro.tuc.ds2020.entities.ConnectedUserRequest;
import ro.tuc.ds2020.entities.ConnectedUsersTracker;

@RestController
@RequestMapping("/connected-users")
public class ConnectedUsersController {

    private final ConnectedUsersTracker connectedUsersTracker;

    @Autowired
    public ConnectedUsersController(ConnectedUsersTracker connectedUsersTracker) {
        this.connectedUsersTracker = connectedUsersTracker;
    }

    @PostMapping
    public ResponseEntity<?> addConnectedUser(@RequestBody ConnectedUserRequest userRequest) {
        System.out.println(userRequest.getId()+" "+userRequest.getEmail()+ " -the call");
        connectedUsersTracker.handleConnect(userRequest.getId(), userRequest.getEmail()); // Add user to tracker
        System.out.println("User added to active users: " + userRequest.getEmail());
        System.out.println(ConnectedUsersTracker.getConnectedUsers());
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
