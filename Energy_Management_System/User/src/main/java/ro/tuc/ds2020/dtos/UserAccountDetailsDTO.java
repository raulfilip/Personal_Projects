package ro.tuc.ds2020.dtos;

import javax.validation.constraints.NotNull;
import java.util.UUID;

public class UserAccountDetailsDTO {

    private UUID id;

    @NotNull
    private String name;

    @NotNull
    private String role;

    private String password;

    private String email;

    public UserAccountDetailsDTO() {
    }

    public UserAccountDetailsDTO(String name, String role, String password, String email ) {
        this.name = name;
        this.role = role;
        this.password = password;
        this.email = email;
    }

    public UserAccountDetailsDTO(UUID id, String name, String role, String password, String email) {
        this.id = id;
        this.name = name;
        this.role = role;
        this.password = password;
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getEmail() {
        return this.email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
}
