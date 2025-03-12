package ro.tuc.ds2020.services;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.jdbc.Sql;
import ro.tuc.ds2020.Ds2020TestConfig;
import ro.tuc.ds2020.dtos.SmartEnergyDeviceDTO;
import ro.tuc.ds2020.dtos.SmartEnergyDeviceDetailsDTO;

import static org.springframework.test.util.AssertionErrors.assertEquals;

import java.util.List;

@Sql(executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD, scripts = "classpath:/test-sql/create.sql")
@Sql(executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD, scripts = "classpath:/test-sql/delete.sql")
public class SmartEnergyDeviceServiceIntegrationTests extends Ds2020TestConfig {

    @Autowired
    SmartEnergyDeviceService smartEnergyDeviceService;

    @Test
    public void testGetCorrect() {
        List<SmartEnergyDeviceDTO> deviceDTOList = smartEnergyDeviceService.findSmartEnergyDevices();
        assertEquals("Test Insert Device", 1, deviceDTOList.size());
    }

    @Test
    public void testInsertCorrectWithGetById() {
        SmartEnergyDeviceDetailsDTO device = new SmartEnergyDeviceDetailsDTO("Smart Device 1", "123 Main St", 10.5);
        int insertedID = smartEnergyDeviceService.insert(device);

        SmartEnergyDeviceDTO insertedDevice = new SmartEnergyDeviceDTO(insertedID, device.getDescription(), device.getAddress(), device.getMaxHourlyConsumption());
        SmartEnergyDeviceDTO fetchedDevice = smartEnergyDeviceService.findSmartEnergyDeviceById(insertedID);

        assertEquals("Test Inserted Device", insertedDevice, fetchedDevice);
    }

    @Test
    public void testInsertCorrectWithGetAll() {
        SmartEnergyDeviceDetailsDTO device = new SmartEnergyDeviceDetailsDTO("Smart Device 2", "456 Another St", 15.0);
        smartEnergyDeviceService.insert(device);

        List<SmartEnergyDeviceDTO> deviceDTOList = smartEnergyDeviceService.findSmartEnergyDevices();
        assertEquals("Test Inserted Devices", 2, deviceDTOList.size());
    }
}
