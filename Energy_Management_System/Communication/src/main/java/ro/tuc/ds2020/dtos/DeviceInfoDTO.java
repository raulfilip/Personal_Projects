package ro.tuc.ds2020.dtos;

import java.util.UUID;

public class DeviceInfoDTO {
    private int deviceId;
    private String description;

    // Constructors
    public DeviceInfoDTO() {}

    public DeviceInfoDTO(int deviceId, String description) {
        this.deviceId = deviceId;
        this.description = description;
    }

    // Getters and setters
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
}
