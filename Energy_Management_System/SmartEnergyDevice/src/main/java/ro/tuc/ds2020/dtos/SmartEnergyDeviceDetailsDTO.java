package ro.tuc.ds2020.dtos;

import javax.validation.constraints.NotNull;
import java.util.UUID;

public class SmartEnergyDeviceDetailsDTO {

    private int id;

    @NotNull
    private String description;

    @NotNull
    private String address;

    private double maxHourlyConsumption;
    private UUID userID;

    public SmartEnergyDeviceDetailsDTO() {
    }

    public SmartEnergyDeviceDetailsDTO(String description, String address, double maxHourlyConsumption, UUID userID) {
        this.description = description;
        this.address = address;
        this.maxHourlyConsumption = maxHourlyConsumption;
        this.userID = userID;
    }

    public SmartEnergyDeviceDetailsDTO(int id, String description, String address, double maxHourlyConsumption, UUID userID) {
        this.id = id;
        this.description = description;
        this.address = address;
        this.maxHourlyConsumption = maxHourlyConsumption;
        this.userID = userID;
    }

    public UUID getUserID() {
        return userID;
    }

    public void setUserID(UUID userID) {
        this.userID = userID;
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
}
