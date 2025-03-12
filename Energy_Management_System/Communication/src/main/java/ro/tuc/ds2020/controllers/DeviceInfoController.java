package ro.tuc.ds2020.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ro.tuc.ds2020.dtos.DeviceInfoDTO;
import ro.tuc.ds2020.dtos.DeviceInfoDetailsDTO;
import ro.tuc.ds2020.services.DeviceInfoService;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/device-info")
public class DeviceInfoController {

    private final DeviceInfoService deviceInfoService;

    @Autowired
    public DeviceInfoController(DeviceInfoService deviceInfoService) {
        this.deviceInfoService = deviceInfoService;
    }

    @GetMapping
    public ResponseEntity<List<DeviceInfoDTO>> getAllDevices() {
        List<DeviceInfoDTO> dtos = deviceInfoService.findAll();
        return ResponseEntity.ok(dtos);
    }

}
