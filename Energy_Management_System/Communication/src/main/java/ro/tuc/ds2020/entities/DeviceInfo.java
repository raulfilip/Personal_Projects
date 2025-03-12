package ro.tuc.ds2020.entities;

import java.util.UUID;

import jakarta.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "device_info")
public class DeviceInfo {

    @Id
    @Column(nullable = false, unique = true) // Ensuring that deviceId is unique
    private int deviceId;

    @Column(nullable = false)
    private double maxHourlyConsumption;

    @Column(nullable = true)
    private UUID userId;

    @Column(nullable = false)
    private String description;

    // Default constructor
    public DeviceInfo() {}

    // Constructor with fields
    public DeviceInfo(int deviceId, double maxHourlyConsumption, UUID userId, String description) {
        this.deviceId = deviceId;
        this.maxHourlyConsumption = maxHourlyConsumption;
        this.userId = userId;
        this.description = description;
    }

    // Getters and setters


    public int getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(int deviceId) {
        this.deviceId = deviceId;
    }

    public double getMaxHourlyConsumption() {
        return maxHourlyConsumption;
    }

    public void setMaxHourlyConsumption(double maxHourlyConsumption) {
        this.maxHourlyConsumption = maxHourlyConsumption;
    }

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}

