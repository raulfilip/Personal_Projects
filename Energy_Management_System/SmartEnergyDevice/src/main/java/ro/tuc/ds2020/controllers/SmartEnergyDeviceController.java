package ro.tuc.ds2020.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ro.tuc.ds2020.dtos.SmartEnergyDeviceDTO;
import ro.tuc.ds2020.dtos.SmartEnergyDeviceDetailsDTO;
import ro.tuc.ds2020.services.SmartEnergyDeviceService;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping(value = "/smartenergydevice")
@CrossOrigin(origins = "http://localhost:3000",allowCredentials = "true")
public class SmartEnergyDeviceController {

    private final SmartEnergyDeviceService smartEnergyDeviceService;

    @Autowired
    public SmartEnergyDeviceController(SmartEnergyDeviceService smartEnergyDeviceService) {
        this.smartEnergyDeviceService = smartEnergyDeviceService;
    }

    @GetMapping()
    public ResponseEntity<List<SmartEnergyDeviceDTO>> getSmartEnergyDevices() {
        List<SmartEnergyDeviceDTO> dtos = smartEnergyDeviceService.findSmartEnergyDevices();
        return new ResponseEntity<>(dtos, HttpStatus.OK);
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<SmartEnergyDeviceDTO>> getDevicesByUser(@PathVariable("userId") UUID userId) {
        try {
            List<SmartEnergyDeviceDTO> devices = smartEnergyDeviceService.findUsersSmartEnergyDevices(userId);
            if (devices.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT); // Return 204 if no devices are found
            }
            return new ResponseEntity<>(devices, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @PostMapping()
    public ResponseEntity<Integer> insertSmartEnergyDevice(@Valid @RequestBody SmartEnergyDeviceDetailsDTO smartEnergyDeviceDTO) {
        int deviceId = smartEnergyDeviceService.insert(smartEnergyDeviceDTO);
        return new ResponseEntity<>(deviceId, HttpStatus.CREATED);
    }


    @PostMapping("/associate")
    public ResponseEntity<?> associateDeviceToUser(@RequestBody Map<String, Object> associationRequest) {
        int deviceId = (int) associationRequest.get("deviceId");
        UUID userId = UUID.fromString((String) associationRequest.get("userId"));

        smartEnergyDeviceService.associateDeviceToUser(deviceId, userId);
        return new ResponseEntity<>("Device successfully associated with user.", HttpStatus.OK);
    }

    @PostMapping("/unassociate")
    public ResponseEntity<?> unassociateDeviceFromUser(@RequestBody Map<String, Object> unassociationRequest) {
        int deviceId = (int) unassociationRequest.get("deviceId");
        UUID userId = UUID.fromString((String) unassociationRequest.get("userId"));

        smartEnergyDeviceService.unassociateDeviceFromUser(deviceId, userId);
        return new ResponseEntity<>("Device successfully unassociated from user.", HttpStatus.OK);
    }


    @GetMapping(value = "/{id}")
    public ResponseEntity<SmartEnergyDeviceDTO> getSmartEnergyDevice(@PathVariable("id") int deviceId) {
        SmartEnergyDeviceDTO dto = smartEnergyDeviceService.findSmartEnergyDeviceById(deviceId);
        return new ResponseEntity<>(dto, HttpStatus.OK);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Void> updateSmartEnergyDevice(@PathVariable("id") int deviceId,
                                                        @Valid @RequestBody SmartEnergyDeviceDetailsDTO smartEnergyDeviceDTO) {
        smartEnergyDeviceService.update(deviceId, smartEnergyDeviceDTO);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSmartEnergyDevice(@PathVariable("id") int deviceId) {
        smartEnergyDeviceService.delete(deviceId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
