package ro.tuc.ds2020.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import ro.tuc.ds2020.entities.UserAccount;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface UserAccountRepository extends JpaRepository<UserAccount, UUID> {



    @Query("SELECT u FROM UserAccount u WHERE u.email = :email")
    UserAccount findByEmail(@Param("email") String email);

    /**
     * Example: JPA generate Query by Field
     */
    List<UserAccount> findByName(String name);

    /**
     * Example: Write Custom Query to find Users by Role
     */
    @Query(value = "SELECT u " +
            "FROM UserAccount u " +
            "WHERE u.role = :role ")
    List<UserAccount> findByRole(@Param("role") String role);

    /**
     * Example: Write Custom Query to find Admins by Name
     */
    @Query(value = "SELECT u " +
            "FROM UserAccount u " +
            "WHERE u.name = :name " +
            "AND u.role = 'admin' ")
    Optional<UserAccount> findAdminByName(@Param("name") String name);

}
