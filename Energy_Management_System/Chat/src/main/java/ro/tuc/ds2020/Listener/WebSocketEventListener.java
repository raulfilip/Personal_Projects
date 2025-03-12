package ro.tuc.ds2020.Listener;

import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.simp.user.SimpUserRegistry;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;
import ro.tuc.ds2020.entities.ConnectedUsersTracker;

@Component
public class WebSocketEventListener {

    private final ConnectedUsersTracker tracker;
    private final SimpUserRegistry simpUserRegistry;

    public WebSocketEventListener(ConnectedUsersTracker tracker, SimpUserRegistry simpUserRegistry) {
        this.tracker = tracker;
        this.simpUserRegistry = simpUserRegistry;
    }

    @EventListener
    public void handleWebSocketConnectListener(SessionConnectEvent event) {
        StompHeaderAccessor accessor = StompHeaderAccessor.wrap(event.getMessage());
        String sessionId = accessor.getSessionId();
        String userId = accessor.getUser() != null ? accessor.getUser().getName() : null;

        if (userId != null) {
            tracker.handleConnect(sessionId, userId);
            System.out.println("User connected: " + userId);

            // Optionally broadcast the updated list of connected users
            tracker.broadcastActiveUsers();
        }
    }

    @EventListener
    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        String sessionId = event.getSessionId();
        tracker.handleDisconnect(sessionId);

        // Optionally broadcast the updated list of connected users
        tracker.broadcastActiveUsers();
    }
}
