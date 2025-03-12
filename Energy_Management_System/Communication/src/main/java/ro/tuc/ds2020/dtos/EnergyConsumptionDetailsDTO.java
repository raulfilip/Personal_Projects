package ro.tuc.ds2020.dtos;

import java.time.LocalDateTime;
import java.util.UUID;

public class EnergyConsumptionDetailsDTO {
    private UUID id;
    private int deviceId;
    private LocalDateTime timestamp;
    private double energyConsumed;

    // Constructors
    public EnergyConsumptionDetailsDTO() {}

    public EnergyConsumptionDetailsDTO(UUID id, int deviceId, LocalDateTime timestamp, double energyConsumed) {
        this.id = id;
        this.deviceId = deviceId;
        this.timestamp = timestamp;
        this.energyConsumed = energyConsumed;
    }

    // Getters and Setters
    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public int getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(int deviceId) {
        this.deviceId = deviceId;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    public double getEnergyConsumed() {
        return energyConsumed;
    }

    public void setEnergyConsumed(double energyConsumed) {
        this.energyConsumed = energyConsumed;
    }
}
