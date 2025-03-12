package ro.tuc.ds2020.controllers;

import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.stereotype.Controller;
import ro.tuc.ds2020.dtos.ChatMessageDTO;
import ro.tuc.ds2020.dtos.ChatMessageDetailsDTO;
import ro.tuc.ds2020.services.ChatService;

@Controller
public class ChatWebSocketController {

    private final ChatService chatService;
    private final SimpMessagingTemplate messagingTemplate;

    public ChatWebSocketController(ChatService chatService, SimpMessagingTemplate messagingTemplate) {
        this.chatService = chatService;
        this.messagingTemplate = messagingTemplate;
    }

    @MessageMapping("/chat")
    public void handleMessage(ChatMessageDetailsDTO messageDetails) {
        ChatMessageDTO savedMessage = chatService.saveMessage(messageDetails);

        // Broadcast the message to the recipient's topic
        messagingTemplate.convertAndSend("/topic/chat/" + savedMessage.getRecipientId(), savedMessage);
    }
}
