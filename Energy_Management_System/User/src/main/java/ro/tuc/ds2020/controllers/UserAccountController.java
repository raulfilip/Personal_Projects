package ro.tuc.ds2020.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ro.tuc.ds2020.controllers.handlers.exceptions.model.ResourceNotFoundException;
import ro.tuc.ds2020.dtos.UserAccountDTO;
import ro.tuc.ds2020.dtos.UserAccountDetailsDTO;
import ro.tuc.ds2020.services.UserAccountService;

import javax.validation.Valid;
import java.util.List;
import java.util.UUID;

@RestController

@RequestMapping(value = "/useraccount")
@CrossOrigin(origins = "http://localhost:3000", allowCredentials = "true")
public class UserAccountController {

    private final UserAccountService userAccountService;

    @Autowired
    public UserAccountController(UserAccountService userAccountService) {
        this.userAccountService = userAccountService;
    }

    @GetMapping()
    public ResponseEntity<List<UserAccountDTO>> getUserAccounts() {
        List<UserAccountDTO> dtos = userAccountService.findUserAccounts();
        return new ResponseEntity<>(dtos, HttpStatus.OK);
    }

    @PostMapping()
    public ResponseEntity<?> insertUserAccount(@Valid @RequestBody UserAccountDetailsDTO userAccountDTO) {
        UUID userAccountID = userAccountService.insert(userAccountDTO);
        if (userAccountID == null) {
            return new ResponseEntity<>("Email already exists. Please use a different email.", HttpStatus.CONFLICT);
        }
        return new ResponseEntity<>(userAccountID, HttpStatus.CREATED);
    }

    @GetMapping(value = "/{id}")
    public ResponseEntity<UserAccountDTO> getUserAccount(@PathVariable("id") UUID userAccountId) {
        UserAccountDTO dto = userAccountService.findUserAccountById(userAccountId);
        return new ResponseEntity<>(dto, HttpStatus.OK);
    }


    @PostMapping(value = "/login")
    public ResponseEntity<?> login(@RequestBody UserAccountDetailsDTO loginRequest) {
        String email = loginRequest.getEmail();
        String password = loginRequest.getPassword();
        System.out.println(email);
        System.out.println(password);
        // Call the service to validate the user
        UserAccountDTO user = userAccountService.login(email, password);

        if (user != null) {
            return new ResponseEntity<>(user, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("Invalid email or password", HttpStatus.UNAUTHORIZED);
        }
    }
    // Create User
    @PostMapping("/create")
    public ResponseEntity<UUID> createUser(@Valid @RequestBody UserAccountDetailsDTO userDTO) {
        UUID userId = userAccountService.insert(userDTO);
        return new ResponseEntity<>(userId, HttpStatus.CREATED);
    }

    // Read All Users
    @GetMapping("/all")
    public ResponseEntity<List<UserAccountDTO>> getAllUsers() {
        List<UserAccountDTO> users = userAccountService.findUserAccounts();
        return new ResponseEntity<>(users, HttpStatus.OK);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateUser(@PathVariable UUID id, @Valid @RequestBody UserAccountDetailsDTO userDTO) {
        try {
            userAccountService.updateUser(id, userDTO);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (IllegalArgumentException ex) {
            return new ResponseEntity<>(ex.getMessage(), HttpStatus.CONFLICT);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteUser(@PathVariable UUID id) {
        try {
            userAccountService.deleteUser(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (ResourceNotFoundException ex) {
            return new ResponseEntity<>(ex.getMessage(), HttpStatus.NOT_FOUND);
        }
    }
    //TODO: UPDATE, DELETE per resource

}
