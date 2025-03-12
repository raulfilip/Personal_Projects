package org.example;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import com.opencsv.CSVReader;
import com.opencsv.CSVReaderBuilder;

import java.io.FileReader;

@Component
public class SmartMeteringDeviceSimulator {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    private final int deviceId;

    public SmartMeteringDeviceSimulator() throws Exception {
        this.deviceId = DeviceUtils.readDeviceId("D:\\raulf\\Documents\\Documente\\Documente\\FACULTATE\\AN 4 SEM 1\\SD\\Tema 2\\Tema2-Proiect\\deviceID.txt");
    }

    @Scheduled(initialDelay = 10000, fixedRate = 10000) // Start after 20 seconds, then every 10 seconds

    public void readSensorAndSend() {
        try (CSVReader reader = new CSVReaderBuilder(new FileReader("D:\\raulf\\Documents\\Documente\\Documente\\FACULTATE\\AN 4 SEM 1\\SD\\Tema 2\\Tema2-Proiect\\sensor.csv")).build()) {
            String[] nextLine;
            while ((nextLine = reader.readNext()) != null) {
                long timestamp = System.currentTimeMillis();
                double measurement = Double.parseDouble(nextLine[0]);
                sendMeasurementData(timestamp, deviceId, measurement);
                Thread.sleep(10000);  // Delay for 10 seconds before sending the next message
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    private void sendMeasurementData(long timestamp, int deviceId, double measurement) {
        String message = String.format("{\"timestamp\":%d, \"device_id\":%d, \"measurement_value\":%f}", timestamp, deviceId, measurement);
        rabbitTemplate.convertAndSend("energy-queue", message);
        System.out.println("Sent message: " + message);  // Log the message that was sent
    }
}
