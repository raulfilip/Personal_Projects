package ro.tuc.ds2020.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import ro.tuc.ds2020.entities.SmartEnergyDevice;
import ro.tuc.ds2020.entities.UserSync;

import java.util.List;
import java.util.UUID;

public interface UserSyncRepository extends JpaRepository<UserSync, UUID> {

    /**
     * Example: JPA-generated query by field (email)
     */
    List<UserSync> findByEmail(String email);

    /**
     * Custom query to check if a user exists by email
     */
    @Query(value = "SELECT COUNT(u) > 0 " +
            "FROM UserSync u " +
            "WHERE u.email = :email")
    boolean existsByEmail(@Param("email") String email);

    /**
     * Custom query to find users by role
     */
    @Query(value = "SELECT u " +
            "FROM UserSync u " +
            "WHERE u.role = :role")
    List<UserSync> findByRole(@Param("role") String role);

    /**
     * Custom query to find a user by name
     */
    @Query(value = "SELECT u " +
            "FROM UserSync u " +
            "WHERE u.name = :name")
    List<UserSync> findByName(@Param("name") String name);


    /**
     * Find all devices by user ID.
     * @param userId the user ID to search for devices.
     * @return a list of devices associated with the given user ID.
     */

}
