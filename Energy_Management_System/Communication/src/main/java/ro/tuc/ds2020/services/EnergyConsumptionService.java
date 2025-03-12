package ro.tuc.ds2020.services;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import ro.tuc.ds2020.dtos.EnergyConsumptionDTO;
import ro.tuc.ds2020.dtos.EnergyConsumptionDetailsDTO;
import ro.tuc.ds2020.dtos.builders.EnergyConsumptionBuilder;
import ro.tuc.ds2020.entities.EnergyConsumption;
import ro.tuc.ds2020.repositories.DeviceInfoRepository;
import ro.tuc.ds2020.repositories.EnergyConsumptionRepository;
import ro.tuc.ds2020.entities.DeviceInfo;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import java.util.stream.Collectors;



@Service
public class EnergyConsumptionService {

    private final EnergyConsumptionRepository energyConsumptionRepository;

    @Autowired
    private DeviceInfoRepository deviceInfoRepository;


    @Autowired
    public EnergyConsumptionService(EnergyConsumptionRepository energyConsumptionRepository) {
        this.energyConsumptionRepository = energyConsumptionRepository;
    }

    public List<EnergyConsumptionDTO> findAll() {
        return energyConsumptionRepository.findAll().stream()
                .map(EnergyConsumptionBuilder::toEnergyConsumptionDTO)
                .collect(Collectors.toList());
    }

    public EnergyConsumptionDTO findById(UUID id) {
        return energyConsumptionRepository.findById(id)
                .map(EnergyConsumptionBuilder::toEnergyConsumptionDTO)
                .orElseThrow(() -> new RuntimeException("Energy consumption not found"));
    }

    public List<EnergyConsumptionDTO> findByDeviceId(int deviceId) {
        List<EnergyConsumption> consumptions = energyConsumptionRepository.findByDeviceId(deviceId);
        return consumptions.stream()
                .map(EnergyConsumptionBuilder::toEnergyConsumptionDTO)
                .collect(Collectors.toList());
    }

    public EnergyConsumptionDTO save(EnergyConsumptionDetailsDTO dto) {
        EnergyConsumption energyConsumption = EnergyConsumptionBuilder.fromEnergyConsumptionDetailsDTO(dto);
        energyConsumption = energyConsumptionRepository.save(energyConsumption);
        return EnergyConsumptionBuilder.toEnergyConsumptionDTO(energyConsumption);
    }

    public void delete(UUID id) {
        energyConsumptionRepository.deleteById(id);
    }

    @Transactional
    public void deleteAllMeasurementsByDeviceID(Integer deviceId) {
        // First, delete all related measurements
        energyConsumptionRepository.deleteByDeviceId(deviceId);

        // Then, delete the device info
    }

    public double sumMeasurementsFromLastHour(int deviceId, LocalDateTime startTime) {
        // This method should query the repository to find all measurements for the given device from `startTime` to now
        // and sum them up.
        return energyConsumptionRepository.findSumByDeviceIdAndTimestampBetween(deviceId, startTime, LocalDateTime.now());
    }


    public List<EnergyConsumptionDetailsDTO> findByUserIdAndDate(UUID userId, LocalDate date) {
        List<Integer> deviceIds = deviceInfoRepository.findByUserId(userId).stream()
                .map(DeviceInfo::getDeviceId)
                .collect(Collectors.toList());
        return energyConsumptionRepository.findByDeviceIdsAndDateRange(deviceIds, date.atStartOfDay(), date.plusDays(1).atStartOfDay())
                .stream()
                .map(EnergyConsumptionBuilder::toEnergyConsumptionDetailsDTO)
                .collect(Collectors.toList());
    }

}


