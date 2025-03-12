package ro.tuc.ds2020.dtos.builders;

import ro.tuc.ds2020.dtos.EnergyConsumptionDTO;
import ro.tuc.ds2020.dtos.EnergyConsumptionDetailsDTO;
import ro.tuc.ds2020.entities.EnergyConsumption;

public class EnergyConsumptionBuilder {

    // Converts an EnergyConsumption entity to an EnergyConsumptionDTO
    public static EnergyConsumptionDTO toEnergyConsumptionDTO(EnergyConsumption energyConsumption) {
        return new EnergyConsumptionDTO(
                energyConsumption.getDeviceId(),
                energyConsumption.getEnergyConsumed()
        );
    }

    // Converts an EnergyConsumption entity to an EnergyConsumptionDetailsDTO
    public static EnergyConsumptionDetailsDTO toEnergyConsumptionDetailsDTO(EnergyConsumption energyConsumption) {
        return new EnergyConsumptionDetailsDTO(
                energyConsumption.getId(),
                energyConsumption.getDeviceId(),
                energyConsumption.getTimestamp(),
                energyConsumption.getEnergyConsumed()
        );
    }

    // Converts an EnergyConsumptionDetailsDTO to an EnergyConsumption entity
    public static EnergyConsumption fromEnergyConsumptionDetailsDTO(EnergyConsumptionDetailsDTO dto) {
        EnergyConsumption energyConsumption = new EnergyConsumption();
        energyConsumption.setId(dto.getId());  // Only set ID if it's an update operation
        energyConsumption.setDeviceId(dto.getDeviceId());
        energyConsumption.setTimestamp(dto.getTimestamp());
        energyConsumption.setEnergyConsumed(dto.getEnergyConsumed());
        return energyConsumption;
    }
}

