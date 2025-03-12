package ro.tuc.ds2020.dtos.builders;

import ro.tuc.ds2020.dtos.DeviceInfoDTO;
import ro.tuc.ds2020.dtos.DeviceInfoDetailsDTO;
import ro.tuc.ds2020.entities.DeviceInfo;

public class DeviceInfoBuilder {

    // Convert Entity to DeviceInfoDTO
    public static DeviceInfoDTO toDeviceInfoDTO(DeviceInfo deviceInfo) {
        return new DeviceInfoDTO(
                deviceInfo.getDeviceId(),
                deviceInfo.getDescription()
        );
    }

    // Convert Entity to DeviceInfoDetailsDTO
    public static DeviceInfoDetailsDTO toDeviceInfoDetailsDTO(DeviceInfo deviceInfo) {
        return new DeviceInfoDetailsDTO(
                deviceInfo.getDeviceId(),
                deviceInfo.getDescription(),
                deviceInfo.getMaxHourlyConsumption(),
                deviceInfo.getUserId()
        );
    }

    // Convert DeviceInfoDetailsDTO to Entity
    public static DeviceInfo fromDeviceInfoDetailsDTO(DeviceInfoDetailsDTO dto) {
        DeviceInfo deviceInfo = new DeviceInfo();
        deviceInfo.setDeviceId(dto.getDeviceId());
        deviceInfo.setDescription(dto.getDescription());
        deviceInfo.setMaxHourlyConsumption(dto.getMaxHourlyConsumption());
        deviceInfo.setUserId(dto.getUserId());
        return deviceInfo;
    }
}
