package ro.tuc.ds2020.entities;

import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "energy_consumption_measurement")
public class EnergyConsumption {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;

    @Column(nullable = false)
    private int deviceId;

    @Column(nullable = false)
    private LocalDateTime timestamp;

    @Column(nullable = false)
    private double energyConsumed;

    // Constructors, getters, and setters
    public EnergyConsumption() {}

    public EnergyConsumption(int deviceId, LocalDateTime timestamp, double energyConsumed) {
        this.deviceId = deviceId;
        this.timestamp = timestamp;
        this.energyConsumed = energyConsumed;
    }

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
