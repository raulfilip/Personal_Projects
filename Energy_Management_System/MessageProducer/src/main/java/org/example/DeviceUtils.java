package org.example;

import java.nio.file.Files;
import java.nio.file.Paths;

public class DeviceUtils {
    // Method to read device ID as an integer from a file
    public static int readDeviceId(String filePath) throws Exception {
        String id = new String(Files.readAllBytes(Paths.get(filePath))).trim();
        return Integer.parseInt(id);
    }
}
