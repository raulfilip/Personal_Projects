package ro.tuc.ds2020.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ro.tuc.ds2020.controllers.handlers.exceptions.model.ResourceNotFoundException;
import ro.tuc.ds2020.dtos.ChatMessageDTO;
import ro.tuc.ds2020.dtos.ChatMessageDetailsDTO;
import ro.tuc.ds2020.dtos.builders.ChatMessageBuilder;
import ro.tuc.ds2020.entities.ChatMessage;
import ro.tuc.ds2020.repositories.ChatMessageRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class ChatService {

    private final ChatMessageRepository chatMessageRepository;

    @Autowired
    public ChatService(ChatMessageRepository chatMessageRepository) {
        this.chatMessageRepository = chatMessageRepository;
    }

    /**
     * Retrieve all chat messages as DTOs.
     *
     * @return List of ChatMessageDTOs.
     */
    public List<ChatMessageDTO> getAllMessages() {
        return chatMessageRepository.findAll()
                .stream()
                .map(ChatMessageBuilder::toChatMessageDTO)
                .collect(Collectors.toList());
    }

    /**
     * Retrieve all messages exchanged between two users.
     *
     * @param senderId    UUID of the sender.
     * @param recipientId UUID of the recipient.
     * @return List of ChatMessageDTOs.
     */
    public List<ChatMessageDTO> getConversationBetweenUsers(UUID senderId, UUID recipientId) {
        return chatMessageRepository.findConversationBetweenUsers(senderId, recipientId)
                .stream()
                .map(ChatMessageBuilder::toChatMessageDTO)
                .collect(Collectors.toList());
    }

    /**
     * Save a new chat message.
     *
     * @param messageDetails DTO The details of the chat message to save.
     * @return Saved ChatMessageDTO.
     */
    public ChatMessageDTO saveMessage(ChatMessageDetailsDTO messageDetails) {
        ChatMessage chatMessage = new ChatMessage();
        chatMessage.setSenderId(messageDetails.getSenderId());
        chatMessage.setRecipientId(messageDetails.getRecipientId());
        chatMessage.setMessageContent(messageDetails.getMessageContent());
        chatMessage.setTimestamp(messageDetails.getTimestamp());
        chatMessage.setSenderRole(messageDetails.getSenderRole());
        chatMessage.setRead(false); // Mark the message as unread when created

        System.out.println("Saving message to database: " + chatMessage);

        ChatMessage savedMessage = chatMessageRepository.save(chatMessage);

        System.out.println("Message successfully saved: " + savedMessage);

        return new ChatMessageDTO(
                savedMessage.getId(),
                savedMessage.getSenderId(),
                savedMessage.getSenderRole(),
                savedMessage.getMessageContent(),
                savedMessage.getTimestamp(),
                savedMessage.getRecipientId(),
                savedMessage.isRead()
        );
    }

    /**
     * Retrieve all messages sent by a specific user.
     *
     * @param senderId UUID of the sender.
     * @return List of ChatMessageDTOs.
     */
    public List<ChatMessageDTO> getMessagesBySender(UUID senderId) {
        return chatMessageRepository.findBySenderId(senderId)
                .stream()
                .map(ChatMessageBuilder::toChatMessageDTO)
                .collect(Collectors.toList());
    }

    /**
     * Retrieve all messages received by a specific user.
     *
     * @param recipientId UUID of the recipient.
     * @return List of ChatMessageDTOs.
     */
    public List<ChatMessageDTO> getMessagesByRecipient(UUID recipientId) {
        return chatMessageRepository.findByRecipientId(recipientId)
                .stream()
                .map(ChatMessageBuilder::toChatMessageDTO)
                .collect(Collectors.toList());
    }

    /**
     * Mark a chat message as read.
     *
     * @param messageId ID of the message to mark as read.
     */
    @Transactional
    public void markMessageAsRead(int messageId) {
        ChatMessage chatMessage = chatMessageRepository.findById(messageId)
                .orElseThrow(() -> new ResourceNotFoundException("ChatMessage with id " + messageId + " not found."));
        chatMessage.setRead(true);
        chatMessageRepository.save(chatMessage);
        System.out.println("Message marked as read: " + chatMessage);
    }

    /**
     * Retrieve all unread messages for a specific recipient.
     *
     * @param recipientId UUID of the recipient.
     * @return List of ChatMessageDTOs.
     */
    public List<ChatMessageDTO> getUnreadMessagesByRecipient(UUID recipientId) {
        return chatMessageRepository.findByRecipientIdAndIsReadFalse(recipientId)
                .stream()
                .map(ChatMessageBuilder::toChatMessageDTO)
                .collect(Collectors.toList());
    }

    /**
     * Delete a chat message by its ID.
     *
     * @param id ID of the chat message.
     */
    @Transactional
    public void deleteMessage(int id) {
        if (!chatMessageRepository.existsById(id)) {
            throw new ResourceNotFoundException("ChatMessage with id " + id + " not found.");
        }
        chatMessageRepository.deleteById(id);
    }
    @Transactional
    public void markAllMessagesAsRead(UUID senderId, UUID recipientId) {
        // Fetch all unread messages sent by the sender to the recipient
        List<ChatMessage> unreadMessages = chatMessageRepository.findBySenderIdAndRecipientIdAndIsReadFalse(senderId, recipientId);

        // Update the "read" status for each message
        for (ChatMessage message : unreadMessages) {
            message.setRead(true);
            chatMessageRepository.save(message);
        }
    }


}
