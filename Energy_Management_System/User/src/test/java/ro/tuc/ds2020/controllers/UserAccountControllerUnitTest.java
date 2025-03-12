package ro.tuc.ds2020.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;
import ro.tuc.ds2020.Ds2020TestConfig;
import ro.tuc.ds2020.dtos.UserAccountDetailsDTO;
import ro.tuc.ds2020.services.UserAccountService;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

public class UserAccountControllerUnitTest extends Ds2020TestConfig {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private UserAccountService userAccountService;

    @Test
    public void insertUserAccountTest() throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();
        UserAccountDetailsDTO userAccountDTO = new UserAccountDetailsDTO("John", "client");

        mockMvc.perform(post("/useraccount")
                        .content(objectMapper.writeValueAsString(userAccountDTO))
                        .contentType("application/json"))
                .andExpect(status().isCreated());
    }

    @Test
    public void insertUserAccountTestFailsDueToInvalidRole() throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();
        UserAccountDetailsDTO userAccountDTO = new UserAccountDetailsDTO("John", "guest");  // Invalid role

        mockMvc.perform(post("/useraccount")
                        .content(objectMapper.writeValueAsString(userAccountDTO))
                        .contentType("application/json"))
                .andExpect(status().isBadRequest());
    }

    @Test
    public void insertUserAccountTestFailsDueToNullName() throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();
        UserAccountDetailsDTO userAccountDTO = new UserAccountDetailsDTO(null, "client");

        mockMvc.perform(post("/useraccount")
                        .content(objectMapper.writeValueAsString(userAccountDTO))
                        .contentType("application/json"))
                .andExpect(status().isBadRequest());
    }
}
