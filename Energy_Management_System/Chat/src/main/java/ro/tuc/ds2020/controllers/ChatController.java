package ro.tuc.ds2020.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ro.tuc.ds2020.dtos.ChatMessageDTO;
import ro.tuc.ds2020.dtos.ChatMessageDetailsDTO;
import ro.tuc.ds2020.services.ChatService;

import javax.validation.Valid;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping(value = "/chat")
@CrossOrigin(origins = "http://localhost:3000", allowCredentials = "true")
public class ChatController {

    private final ChatService chatService;

    @Autowired
    public ChatController(ChatService chatService) {
        this.chatService = chatService;
    }

    /**
     * Get all chat messages.
     *
     * @return List of ChatMessageDTOs.
     */
    @GetMapping
    public ResponseEntity<List<ChatMessageDTO>> getAllMessages() {
        List<ChatMessageDTO> messages = chatService.getAllMessages();
        return new ResponseEntity<>(messages, HttpStatus.OK);
    }

    /**
     * Get all messages exchanged between two users.
     *
     * @param senderId    UUID of the sender.
     * @param recipientId UUID of the recipient.
     * @return List of ChatMessageDTOs.
     */
    @GetMapping("/conversation")
    public ResponseEntity<List<ChatMessageDTO>> getConversationBetweenUsers(
            @RequestParam UUID senderId,
            @RequestParam UUID recipientId) {
        List<ChatMessageDTO> messages = chatService.getConversationBetweenUsers(senderId, recipientId);
        return new ResponseEntity<>(messages, HttpStatus.OK);
    }

    /**
     * Save a new chat message.
     *
     * @param chatMessageDetailsDTO Details of the chat message.
     * @return The saved ChatMessageDTO.
     */
    @PostMapping
    public ResponseEntity<ChatMessageDTO> saveMessage(@Valid @RequestBody ChatMessageDetailsDTO chatMessageDetailsDTO) {
        ChatMessageDTO savedMessage = chatService.saveMessage(chatMessageDetailsDTO);
        return new ResponseEntity<>(savedMessage, HttpStatus.CREATED);
    }

    /**
     * Get all messages sent by a specific user.
     *
     * @param senderId UUID of the sender.
     * @return List of ChatMessageDTOs.
     */
    @GetMapping("/sender/{senderId}")
    public ResponseEntity<List<ChatMessageDTO>> getMessagesBySender(@PathVariable UUID senderId) {
        List<ChatMessageDTO> messages = chatService.getMessagesBySender(senderId);
        return new ResponseEntity<>(messages, HttpStatus.OK);
    }

    /**
     * Get all messages received by a specific user.
     *
     * @param recipientId UUID of the recipient.
     * @return List of ChatMessageDTOs.
     */
    @GetMapping("/recipient/{recipientId}")
    public ResponseEntity<List<ChatMessageDTO>> getMessagesByRecipient(@PathVariable UUID recipientId) {
        List<ChatMessageDTO> messages = chatService.getMessagesByRecipient(recipientId);
        return new ResponseEntity<>(messages, HttpStatus.OK);
    }

    /**
     * Delete a chat message by its ID.
     *
     * @param id ID of the chat message.
     * @return ResponseEntity with status NO_CONTENT.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMessage(@PathVariable int id) {
        chatService.deleteMessage(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    /**
     * Mark a specific message as read by its ID.
     *
     * @param messageId ID of the chat message to mark as read.
     * @return ResponseEntity with status OK.
     */
    @PutMapping("/{messageId}/read")
    public ResponseEntity<Void> markMessageAsRead(@PathVariable int messageId) {
        chatService.markMessageAsRead(messageId);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    /**
     * Mark all messages as read for a specific recipient.
     *
     * @param recipientId UUID of the recipient whose messages are to be marked as read.
     * @return ResponseEntity with status OK.
     */
    @PutMapping("/mark-all-read")
    public ResponseEntity<Void> markAllMessagesAsRead(
            @RequestParam UUID senderId,
            @RequestParam UUID recipientId) {
        chatService.markAllMessagesAsRead(senderId, recipientId);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
