package ro.tuc.ds2020.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ro.tuc.ds2020.dtos.DeviceInfoDTO;
import ro.tuc.ds2020.dtos.DeviceInfoDetailsDTO;
import ro.tuc.ds2020.dtos.builders.DeviceInfoBuilder;
import ro.tuc.ds2020.entities.DeviceInfo;
import ro.tuc.ds2020.repositories.DeviceInfoRepository;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class DeviceInfoService {

    private final DeviceInfoRepository deviceInfoRepository;

    @Autowired
    public DeviceInfoService(DeviceInfoRepository deviceInfoRepository) {
        this.deviceInfoRepository = deviceInfoRepository;
    }

    public List<DeviceInfoDTO> findAll() {
        return deviceInfoRepository.findAll().stream()
                .map(DeviceInfoBuilder::toDeviceInfoDTO)
                .collect(Collectors.toList());
    }
    public Optional<DeviceInfoDetailsDTO> findById(int id) {
        return deviceInfoRepository.findById(id)
                .map(DeviceInfoBuilder::toDeviceInfoDetailsDTO);
    }


    public DeviceInfoDetailsDTO save(DeviceInfoDetailsDTO dto) {
        DeviceInfo deviceInfo = DeviceInfoBuilder.fromDeviceInfoDetailsDTO(dto);
        deviceInfo = deviceInfoRepository.save(deviceInfo);
        return DeviceInfoBuilder.toDeviceInfoDetailsDTO(deviceInfo);
    }

    @Transactional
    public void delete(int deviceId) {
        deviceInfoRepository.deleteByDeviceId(deviceId);
    }

    @Transactional
    public void updateDeviceInfo(DeviceInfoDetailsDTO dto) {
        Optional<DeviceInfo> optionalDeviceInfo = deviceInfoRepository.findById(dto.getDeviceId());

        if (optionalDeviceInfo.isPresent()) {
            DeviceInfo deviceInfo = optionalDeviceInfo.get();

            deviceInfo.setMaxHourlyConsumption(dto.getMaxHourlyConsumption());
            deviceInfo.setUserId(dto.getUserId());
            deviceInfo.setDescription(dto.getDescription());

            deviceInfoRepository.save(deviceInfo);
        } else {
            // Optionally log that no update was performed because the device was not found
            System.out.println("No update performed: Device not found with ID: " + dto.getDeviceId());
        }
    }

}
