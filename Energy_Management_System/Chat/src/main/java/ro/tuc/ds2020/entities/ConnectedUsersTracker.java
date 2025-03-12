package ro.tuc.ds2020.entities;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

@Component
public class ConnectedUsersTracker {
    @Autowired
    private SimpMessagingTemplate messagingTemplate;


    private static final ConcurrentMap<String, String> connectedUsers = new ConcurrentHashMap<>();

    public void handleConnect(String userId, String email) {
        System.out.println(userId+" "+email);
        System.out.println("Connected to user " + userId + " with email " + email);
        if (userId != null && email != null) {
            connectedUsers.put(userId, email);
        } else {
            // Log the issue or handle it appropriately
            System.err.println("UserId or UserEmail is null. Cannot add to connectedUsersMap.");
        }

        broadcastActiveUsers(); // Immediately notify all clients
    }


    public void handleDisconnect(String userId) {
        connectedUsers.remove(userId); // Remove user when disconnected
        broadcastActiveUsers(); // Broadcast updated active users
    }

    public void broadcastActiveUsers() {
        messagingTemplate.convertAndSend("/topic/connected-users", connectedUsers.values());
    }
    public static ConcurrentMap<String, String> getConnectedUsers() {
        return connectedUsers;
    }
}
