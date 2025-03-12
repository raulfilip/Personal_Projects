package ro.tuc.ds2020.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import org.hibernate.annotations.GenericGenerator;

import java.io.Serializable;
import java.util.UUID;

@Entity
public class UserAccount implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(generator = "uuid2")
    @GenericGenerator(name = "uuid2", strategy = "uuid2")
    @Column(name="id", columnDefinition = "BINARY(16)")
    private UUID id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "role", nullable = false)
    private String role;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "email", nullable = false, unique = true)
    private String email;

    public UserAccount() {
    }

    public UserAccount(String name, String role, String password,String email) {
        this.name = name;
        this.role = role;
        this.password = password;
        this.email = email;
    }

    public String getEmail(){
        return email;
    }

    public void setEmail(String email){
        this.email = email;
    }

    // Getter for ID
    public UUID getId() {
        return id;
    }

    // Setter for ID
    public void setId(UUID id) {
        this.id = id;
    }

    // Getter for Name
    public String getName() {
        return name;
    }

    // Setter for Name
    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // Getter for Role
    public String getRole() {
        return role;
    }

    // Setter for Role with validation (role should be either admin or client)
    public void setRole(String role) {
        if (role.equalsIgnoreCase("admin") || role.equalsIgnoreCase("client")) {
            this.role = role.toLowerCase();
        } else {
            throw new IllegalArgumentException("Role must be either 'admin' or 'client'");
        }
    }

    @Override
    public String toString() {
        return "UserAccount [ID=" + id + ", Name=" + name + ", Role=" + role + "]";
    }
}
