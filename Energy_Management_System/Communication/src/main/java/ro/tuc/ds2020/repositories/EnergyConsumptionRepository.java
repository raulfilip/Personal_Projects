package ro.tuc.ds2020.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ro.tuc.ds2020.entities.EnergyConsumption;

import java.util.List;
import java.util.UUID;

@Repository
public interface EnergyConsumptionRepository extends JpaRepository<EnergyConsumption, UUID> {
    // Custom query to find energy consumption records by device ID
    List<EnergyConsumption> findByDeviceId(int deviceId);
    void deleteByDeviceId(Integer deviceId);
    @Query("SELECT SUM(e.energyConsumed) FROM EnergyConsumption e WHERE e.deviceId = :deviceId AND e.timestamp BETWEEN :start AND :end")
    Double findSumByDeviceIdAndTimestampBetween(@Param("deviceId") int deviceId, @Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Query("SELECT e FROM EnergyConsumption e WHERE e.deviceId IN :deviceIds AND e.timestamp BETWEEN :startDate AND :endDate")
    List<EnergyConsumption> findByDeviceIdsAndDateRange(@Param("deviceIds") List<Integer> deviceIds, @Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);

    @Query("SELECT e FROM EnergyConsumption e WHERE e.deviceId IN :deviceIds AND e.timestamp BETWEEN :startDate AND :endDate")
    List<EnergyConsumption> findByDeviceIdsAndDateRange(
            @Param("deviceIds") List<Integer> deviceIds,
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate);
}



