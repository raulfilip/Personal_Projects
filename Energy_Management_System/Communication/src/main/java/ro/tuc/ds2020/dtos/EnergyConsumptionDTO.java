package ro.tuc.ds2020.dtos;

import ro.tuc.ds2020.dtos.validators.annotation.AgeLimit;

import javax.validation.constraints.NotNull;
import java.util.UUID;
import java.util.UUID;

public class EnergyConsumptionDTO {
    private int deviceId;
    private double energyConsumed;

    // Constructors
    public EnergyConsumptionDTO() {}

    public EnergyConsumptionDTO(int deviceId, double energyConsumed) {
        this.deviceId = deviceId;
        this.energyConsumed = energyConsumed;
    }

    // Getters and Setters
    public int getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(int deviceId) {
        this.deviceId = deviceId;
    }

    public double getEnergyConsumed() {
        return energyConsumed;
    }

    public void setEnergyConsumed(double energyConsumed) {
        this.energyConsumed = energyConsumed;
    }
}

