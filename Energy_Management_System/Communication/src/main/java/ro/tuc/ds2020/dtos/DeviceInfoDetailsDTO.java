package ro.tuc.ds2020.dtos;

import java.util.UUID;

public class DeviceInfoDetailsDTO {
    private int deviceId;
    private String description;
    private double maxHourlyConsumption;
    private UUID userId;

    // Constructors
    public DeviceInfoDetailsDTO() {}

    public DeviceInfoDetailsDTO( int deviceId, String description, double maxHourlyConsumption, UUID userId) {
        this.deviceId = deviceId;
        this.description = description;
        this.maxHourlyConsumption = maxHourlyConsumption;
        this.userId = userId;
    }


    public int getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(int deviceId) {
        this.deviceId = deviceId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
}
