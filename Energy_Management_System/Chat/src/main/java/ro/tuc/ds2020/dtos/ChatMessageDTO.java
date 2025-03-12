package ro.tuc.ds2020.dtos;

import java.time.LocalDateTime;
import java.util.UUID;

public class ChatMessageDTO {

    private int id; // Unique identifier for the message
    private UUID senderId; // User ID of the sender
    private String senderRole; // Role of the sender (e.g., "admin", "client")
    private String messageContent; // Content of the chat message
    private LocalDateTime timestamp; // Time when the message was sent
    private UUID recipientId; // User ID of the recipient (null for admin communication)
    private boolean read; // Indicates whether the message has been read

    // Default constructor
    public ChatMessageDTO() {
    }

    // Parameterized constructor
    public ChatMessageDTO(int id, UUID senderId, String senderRole, String messageContent, LocalDateTime timestamp, UUID recipientId, boolean read) {
        this.id = id;
        this.senderId = senderId;
        this.senderRole = senderRole;
        this.messageContent = messageContent;
        this.timestamp = timestamp;
        this.recipientId = recipientId;
        this.read = read;
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
        return read;
    }

    public void setRead(boolean read) {
        this.read = read;
    }

    @Override
    public String toString() {
        return "ChatMessageDTO{" +
                "id=" + id +
                ", senderId=" + senderId +
                ", senderRole='" + senderRole + '\'' +
                ", messageContent='" + messageContent + '\'' +
                ", timestamp=" + timestamp +
                ", recipientId=" + recipientId +
                ", read=" + read +
                '}';
    }
}
