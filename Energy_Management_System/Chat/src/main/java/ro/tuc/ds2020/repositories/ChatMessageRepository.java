package ro.tuc.ds2020.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import ro.tuc.ds2020.entities.ChatMessage;

import java.util.List;
import java.util.UUID;

public interface ChatMessageRepository extends JpaRepository<ChatMessage, Integer> {

    /**
     * Find all messages sent by a specific user.
     *
     * @param senderId UUID of the sender.
     * @return List of chat messages.
     */
    List<ChatMessage> findBySenderId(UUID senderId);

    /**
     * Find all messages received by a specific user.
     *
     * @param recipientId UUID of the recipient.
     * @return List of chat messages.
     */
    List<ChatMessage> findByRecipientId(UUID recipientId);

    /**
     * Find all messages exchanged between two users.
     *
     * @param senderId    UUID of the sender.
     * @param recipientId UUID of the recipient.
     * @return List of chat messages.
     */
    @Query("SELECT m FROM ChatMessage m WHERE (m.senderId = :senderId AND m.recipientId = :recipientId) " +
            "OR (m.senderId = :recipientId AND m.recipientId = :senderId) ORDER BY m.timestamp ASC")
    List<ChatMessage> findConversationBetweenUsers(@Param("senderId") UUID senderId, @Param("recipientId") UUID recipientId);

    /**
     * Find all messages in a chronological order for a specific user role.
     *
     * @param senderRole Role of the sender (e.g., "admin", "client").
     * @return List of chat messages.
     */
    List<ChatMessage> findBySenderRoleOrderByTimestampAsc(String senderRole);

    /**
     * Find all unread messages for a specific recipient.
     *
     * @param recipientId UUID of the recipient.
     * @return List of unread chat messages.
     */
    List<ChatMessage> findByRecipientIdAndIsReadFalse(UUID recipientId); // Corrected method
    List<ChatMessage> findBySenderIdAndRecipientIdAndIsReadFalse(UUID senderId, UUID recipientId);


}
