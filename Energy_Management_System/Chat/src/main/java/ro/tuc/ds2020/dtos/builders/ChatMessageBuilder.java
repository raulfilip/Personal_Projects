package ro.tuc.ds2020.dtos.builders;

import ro.tuc.ds2020.dtos.ChatMessageDTO;
import ro.tuc.ds2020.dtos.ChatMessageDetailsDTO;
import ro.tuc.ds2020.entities.ChatMessage;

public class ChatMessageBuilder {

    private ChatMessageBuilder() {
        // Private constructor to prevent instantiation
    }

    /**
     * Converts a ChatMessage entity to a ChatMessageDTO.
     *
     * @param chatMessage The ChatMessage entity.
     * @return The corresponding ChatMessageDTO.
     */
    public static ChatMessageDTO toChatMessageDTO(ChatMessage chatMessage) {
        if (chatMessage == null) {
            return null;
        }

        return new ChatMessageDTO(
                chatMessage.getId(),
                chatMessage.getSenderId(),
                chatMessage.getSenderRole(),
                chatMessage.getMessageContent(),
                chatMessage.getTimestamp(),
                chatMessage.getRecipientId(),
                chatMessage.isRead() // Include the 'read' field
        );
    }

    /**
     * Converts a ChatMessageDetailsDTO to a ChatMessage entity.
     *
     * @param chatMessageDetailsDTO The ChatMessageDetailsDTO.
     * @return The corresponding ChatMessage entity.
     */
    public static ChatMessage toEntity(ChatMessageDetailsDTO chatMessageDetailsDTO) {
        if (chatMessageDetailsDTO == null) {
            return null;
        }

        return new ChatMessage(
                chatMessageDetailsDTO.getSenderId(),
                chatMessageDetailsDTO.getSenderRole(),
                chatMessageDetailsDTO.getMessageContent(),
                chatMessageDetailsDTO.getTimestamp(),
                chatMessageDetailsDTO.getRecipientId(),
                chatMessageDetailsDTO.isRead() // Include the 'read' field
        );
    }
}
