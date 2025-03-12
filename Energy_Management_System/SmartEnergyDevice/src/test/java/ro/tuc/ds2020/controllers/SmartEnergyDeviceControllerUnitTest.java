package ro.tuc.ds2020.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;
import ro.tuc.ds2020.Ds2020TestConfig;
import ro.tuc.ds2020.dtos.SmartEnergyDeviceDetailsDTO;
import ro.tuc.ds2020.services.SmartEnergyDeviceService;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

public class SmartEnergyDeviceControllerUnitTest extends Ds2020TestConfig {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private SmartEnergyDeviceService service;

    @Test
    public void insertSmartEnergyDeviceTest() throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();
        SmartEnergyDeviceDetailsDTO deviceDTO = new SmartEnergyDeviceDetailsDTO("Smart Device 1", "123 Main St", 10.5);

        mockMvc.perform(post("/smartenergydevice")
                        .content(objectMapper.writeValueAsString(deviceDTO))
                        .contentType("application/json"))
                .andExpect(status().isCreated());
    }

    @Test
    public void insertSmartEnergyDeviceTestFailsDueToNegativeConsumption() throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();
        SmartEnergyDeviceDetailsDTO deviceDTO = new SmartEnergyDeviceDetailsDTO("Smart Device 2", "456 Another St", -5.0);

        mockMvc.perform(post("/smartenergydevice")
                        .content(objectMapper.writeValueAsString(deviceDTO))
                        .contentType("application/json"))
                .andExpect(status().isBadRequest());
    }

    @Test
    public void insertSmartEnergyDeviceTestFailsDueToNullAddress() throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();
        SmartEnergyDeviceDetailsDTO deviceDTO = new SmartEnergyDeviceDetailsDTO("Smart Device 3", null, 15.0);

        mockMvc.perform(post("/smartenergydevice")
                        .content(objectMapper.writeValueAsString(deviceDTO))
                        .contentType("application/json"))
                .andExpect(status().isBadRequest());
    }
}
