package ro.tuc.ds2020.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ro.tuc.ds2020.entities.DeviceInfo;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface DeviceInfoRepository extends JpaRepository<DeviceInfo, Integer> {
    // Find a device info by the unique device ID
    Optional<DeviceInfo> findByDeviceId(int deviceId);
    void deleteByDeviceId(Integer deviceId);
    List<DeviceInfo> findByUserId(UUID userId);
}
