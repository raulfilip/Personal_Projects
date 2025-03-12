package ro.tuc.ds2020.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import ro.tuc.ds2020.entities.SmartEnergyDevice;

import java.util.List;
import java.util.UUID;

public interface SmartEnergyDeviceRepository extends JpaRepository<SmartEnergyDevice, Integer> {

    /**
     * Example: JPA generate Query by Field (description)
     */
    List<SmartEnergyDevice> findByDescription(String description);

    /**
     * Example: Write Custom Query to find Devices by Address
     */
    @Query(value = "SELECT s " +
            "FROM SmartEnergyDevice s " +
            "WHERE s.address = :address ")
    List<SmartEnergyDevice> findByAddress(@Param("address") String address);

    /**
     * Example: Write Custom Query to find Devices by Maximum Hourly Consumption greater than or equal to a specific value
     */
    @Query(value = "SELECT s " +
            "FROM SmartEnergyDevice s " +
            "WHERE s.maxHourlyConsumption >= :consumption ")
    List<SmartEnergyDevice> findByMaxHourlyConsumptionGreaterThanEqual(@Param("consumption") double consumption);

    /**
     * Check if there are devices associated with a specific user ID
     */
    @Query(value = "SELECT COUNT(s) > 0 " +
            "FROM SmartEnergyDevice s " +
            "WHERE s.userId = :userId")
    boolean existsByUserId(@Param("userId") UUID userId);

    @Query("SELECT COUNT(s) FROM SmartEnergyDevice s WHERE s.userId = :userId")
    long countByUserId(@Param("userId") UUID userId);

    @Query("SELECT d FROM SmartEnergyDevice d WHERE d.userId = :userId")
    List<SmartEnergyDevice> findUsersDevices(@Param("userId") UUID userId);
}
