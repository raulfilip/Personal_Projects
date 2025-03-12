package ro.tuc.ds2020.controllers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ro.tuc.ds2020.dtos.EnergyConsumptionDTO;
import ro.tuc.ds2020.dtos.EnergyConsumptionDetailsDTO;
import ro.tuc.ds2020.services.EnergyConsumptionService;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/energy-consumption")
public class EnergyConsumptionController {

    private final EnergyConsumptionService energyConsumptionService;

    @Autowired
    public EnergyConsumptionController(EnergyConsumptionService energyConsumptionService) {
        this.energyConsumptionService = energyConsumptionService;
    }

    @GetMapping
    public ResponseEntity<List<EnergyConsumptionDTO>> getAllEnergyConsumptions() {
        List<EnergyConsumptionDTO> dtos = energyConsumptionService.findAll();
        return ResponseEntity.ok(dtos);
    }

    @GetMapping("/{id}")
    public ResponseEntity<EnergyConsumptionDTO> getEnergyConsumption(@PathVariable UUID id) {
        try {
            EnergyConsumptionDTO dto = energyConsumptionService.findById(id);
            return ResponseEntity.ok(dto);
        } catch (RuntimeException ex) {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public ResponseEntity<EnergyConsumptionDTO> addEnergyConsumption(@RequestBody EnergyConsumptionDetailsDTO dto) {
        EnergyConsumptionDTO createdDto = energyConsumptionService.save(dto);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdDto);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateEnergyConsumption(@PathVariable UUID id, @RequestBody EnergyConsumptionDetailsDTO dto) {
        try {
            dto.setId(id);
            EnergyConsumptionDTO updatedDto = energyConsumptionService.save(dto);
            return ResponseEntity.ok(updatedDto);
        } catch (RuntimeException ex) {
            return ResponseEntity.badRequest().body("Failed to update: " + ex.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteEnergyConsumption(@PathVariable UUID id) {
        try {
            energyConsumptionService.delete(id);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    @GetMapping("/user/{userId}/date/{date}")
    public ResponseEntity<List<EnergyConsumptionDetailsDTO>> getConsumptionForUserOnDate(
            @PathVariable UUID userId,
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {

        List<EnergyConsumptionDetailsDTO> consumptions = energyConsumptionService.findByUserIdAndDate(userId, date);
        return ResponseEntity.ok(consumptions);
    }
}

