package ro.tuc.ds2020.dtos;

import java.util.Objects;
import java.util.UUID;

public class SmartEnergyDeviceDTO {
    private int id;
    private String description;
    private String address;
    private double maxHourlyConsumption;
    private UUID userId;

    public SmartEnergyDeviceDTO() {
    }

    public SmartEnergyDeviceDTO(int id, String description, String address, double maxHourlyConsumption, UUID userId) {
        this.id = id;
        this.description = description;
        this.address = address;
        this.maxHourlyConsumption = maxHourlyConsumption;
        this.userId = userId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SmartEnergyDeviceDTO that = (SmartEnergyDeviceDTO) o;
        return Double.compare(that.maxHourlyConsumption, maxHourlyConsumption) == 0 &&
                Objects.equals(description, that.description) &&
                Objects.equals(address, that.address) && Objects.equals(userId, that.userId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(description, address, maxHourlyConsumption,userId);
    }
}
