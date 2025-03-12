package ro.tuc.ds2020.entities;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "chat_messages")
public class ChatMessage implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // Auto-increment for the primary key
    private int id;

    @Column(nullable = false)
    private UUID senderId;  // User ID of the sender

    @Column(nullable = false)
    private String senderRole; // Role of the sender (e.g., "admin", "client")

    @Column(nullable = false)
    private String messageContent; // Content of the chat message

    @Column(nullable = false)
    private LocalDateTime timestamp; // Time when the message was sent

    @Column(nullable = false)
    private UUID recipientId; // User ID of the recipient (null for messages to/from admin)

    @Column(name = "is_read", nullable = false)
    private boolean isRead;


    // Default constructor required by JPA
    public ChatMessage() {
    }

    // Constructor
    public ChatMessage(UUID senderId, String senderRole, String messageContent, LocalDateTime timestamp, UUID recipientId, boolean isRead) {
        this.senderId = senderId;
        this.senderRole = senderRole;
        this.messageContent = messageContent;
        this.timestamp = timestamp;
        this.recipientId = recipientId;
        this.isRead = isRead;
    }

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public UUID getSenderId() {
        return senderId;
    }

    public void setSenderId(UUID senderId) {
        this.senderId = senderId;
    }

    public String getSenderRole() {
        return senderRole;
    }

    public void setSenderRole(String senderRole) {
        this.senderRole = senderRole;
    }

    public String getMessageContent() {
        return messageContent;
    }

    public void setMessageContent(String messageContent) {
        this.messageContent = messageContent;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    public UUID getRecipientId() {
        return recipientId;
    }

    public void setRecipientId(UUID recipientId) {
        this.recipientId = recipientId;
    }

    public boolean isRead() {
        return isRead;
    }

    public void setRead(boolean read) {
        isRead = read;
    }

    @Override
    public String toString() {
        return "ChatMessage{" +
                "id=" + id +
                ", senderId=" + senderId +
                ", senderRole='" + senderRole + '\'' +
                ", messageContent='" + messageContent + '\'' +
                ", timestamp=" + timestamp +
                ", recipientId=" + recipientId +
                ", isRead=" + isRead +
                '}';
    }
}
