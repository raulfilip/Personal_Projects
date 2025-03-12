package ro.tuc.ds2020.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import java.io.Serializable;
import java.util.UUID;

@Entity
public class SmartEnergyDevice implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // Assuming auto-increment for primary key
    private int id;

    @Column(nullable = false)
    private String description;

    @Column(nullable = false)
    private String address;

    @Column(nullable = false)
    private double maxHourlyConsumption; // in kWh (kilowatt-hour)

    @Column() // Foreign key to the User entity
    private UUID userId;

    // Default constructor required by JPA
    public SmartEnergyDevice() {
    }

    // Constructor
    public SmartEnergyDevice(int id, String description, String address, double maxHourlyConsumption, UUID userId) {
        this.id = id;
        this.description = description;
        this.address = address;
        this.maxHourlyConsumption = maxHourlyConsumption;
        this.userId = userId;
    }

    // Getter and Setter for ID
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getter and Setter for Description
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // Getter and Setter for Address
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    // Getter and Setter for Maximum Hourly Consumption
    public double getMaxHourlyConsumption() {
        return maxHourlyConsumption;
    }

    public void setMaxHourlyConsumption(double maxHourlyConsumption) {
        if (maxHourlyConsumption > 0) {
            this.maxHourlyConsumption = maxHourlyConsumption;
        } else {
            throw new IllegalArgumentException("Maximum hourly consumption must be a positive value.");
        }
    }

    // Getter and Setter for UserId
    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

    // toString method for easy printing
    @Override
    public String toString() {
        return "SmartEnergyDevice [ID=" + id + ", Description=" + description +
                ", Address=" + address + ", MaxHourlyConsumption=" + maxHourlyConsumption +
                " kWh, UserId=" + userId + "]";
    }
}
