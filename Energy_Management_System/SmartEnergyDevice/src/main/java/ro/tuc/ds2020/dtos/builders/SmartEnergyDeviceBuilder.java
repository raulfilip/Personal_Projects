package ro.tuc.ds2020.dtos.builders;

import ro.tuc.ds2020.dtos.SmartEnergyDeviceDTO;
import ro.tuc.ds2020.dtos.SmartEnergyDeviceDetailsDTO;
import ro.tuc.ds2020.entities.SmartEnergyDevice;

public class SmartEnergyDeviceBuilder {

    private SmartEnergyDeviceBuilder() {
    }

    public static SmartEnergyDeviceDTO toSmartEnergyDeviceDTO(SmartEnergyDevice smartEnergyDevice) {
        return new SmartEnergyDeviceDTO(smartEnergyDevice.getId(), smartEnergyDevice.getDescription(),
                smartEnergyDevice.getAddress(), smartEnergyDevice.getMaxHourlyConsumption(),smartEnergyDevice.getUserId());
    }

    public static SmartEnergyDevice toEntity(SmartEnergyDeviceDetailsDTO smartEnergyDeviceDetailsDTO) {
        return new SmartEnergyDevice(smartEnergyDeviceDetailsDTO.getId(),
                smartEnergyDeviceDetailsDTO.getDescription(),
                smartEnergyDeviceDetailsDTO.getAddress(),
                smartEnergyDeviceDetailsDTO.getMaxHourlyConsumption(),
                smartEnergyDeviceDetailsDTO.getUserID());

    }
}
