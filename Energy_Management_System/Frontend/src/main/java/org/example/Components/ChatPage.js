import React, { useState, useEffect, useRef } from "react";
import { Client } from "@stomp/stompjs";
import { useNavigate } from "react-router-dom";
import axios from "axios";

const ChatPage = ({ userId, userRole }) => {
    const [messages, setMessages] = useState([]);
    const [newMessage, setNewMessage] = useState("");
    const [recipientId, setRecipientId] = useState("");
    const [users, setUsers] = useState([]);
    const [chatStarted, setChatStarted] = useState(false);
    const [connectionStatus, setConnectionStatus] = useState("Disconnected");
    const stompClientRef = useRef(null);
    const navigate = useNavigate();

    const USERS_URL = "http://localhost:8081/useraccount/all";
    const WEBSOCKET_URL = "ws://localhost:8082/ws-chat";

    // Connect to WebSocket
    const connectWebSocket = () => {
        const stompClient = new Client({
            brokerURL: WEBSOCKET_URL,
            debug: (str) => console.log(str),
            reconnectDelay: 5000,
            onConnect: () => {
                console.log("WebSocket connected");
                setConnectionStatus("Connected");
                stompClientRef.current = stompClient;
            },
            onStompError: (frame) => {
                console.error("STOMP error:", frame.headers["message"]);
                setConnectionStatus("Error");
                alert("WebSocket error: " + frame.headers["message"]);
            },
            onDisconnect: () => {
                console.log("WebSocket disconnected");
                setConnectionStatus("Disconnected");
                stompClientRef.current = null;
            },
        });

        stompClient.activate();
    };

    // Send a message via WebSocket
    const sendMessage = async () => {
        if (!newMessage.trim()) {
            alert("Message cannot be empty.");
            return;
        }

        const messagePayload = {
            senderId: userId,
            senderRole: userRole,
            messageContent: newMessage,
            timestamp: new Date().toISOString(),
            recipientId,
        };

        try {
            stompClientRef.current.publish({
                destination: `/app/chat`,
                body: JSON.stringify(messagePayload),
            });

            // Add message optimistically after publishing
            setMessages((prevMessages) => [...prevMessages, messagePayload]);
            setNewMessage("");
        } catch (error) {
            console.error("Error sending message:", error);
            alert("Failed to send message. Please try again.");
        }
    };

    // Fetch users based on role
    const fetchUsers = async () => {
        try {
            const response = await fetch(USERS_URL);
            const data = await response.json();

            const filteredUsers = data.filter((user) =>
                userRole === "client" ? user.role === "admin" : user.role === "client"
            );

            setUsers(filteredUsers);
        } catch (error) {
            console.error("Error fetching users:", error);
        }
    };

    const markMessagesAsRead = async () => {
        if (!recipientId) return; // Ensure a recipient is selected

        try {
            await axios.put(
                `http://localhost:8082/chat/mark-all-read`,
                null, // No body required
                {
                    params: {
                        senderId: recipientId, // The sender (admin or client)
                        recipientId: userId, // The recipient (current user)
                    },
                }
            );
            console.log("Messages marked as read");
        } catch (error) {
            console.error("Failed to mark messages as read:", error);
        }
    };




    // Load message history for selected recipient
    const fetchMessages = async () => {
        if (!recipientId) return;

        try {
            const response = await fetch(
                `http://localhost:8082/chat/conversation?senderId=${userId}&recipientId=${recipientId}`
            );

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();
            setMessages(data);

            // Mark messages as read
            await markMessagesAsRead();
        } catch (error) {
            console.error("Error fetching messages:", error);
        }
    };

    const [connectedUsers, setConnectedUsers] = useState([]);

    useEffect(() => {
        if (stompClientRef.current && stompClientRef.current.connected) {
            const subscription = stompClientRef.current.subscribe("/topic/connected-users", (message) => {
                const updatedUsers = JSON.parse(message.body);
                console.log("Connected users:", updatedUsers);
                setConnectedUsers(updatedUsers); // Update the state with the list of connected users
            });

            return () => subscription.unsubscribe();
        }
    }, [stompClientRef.current]);

    useEffect(() => {
        const subscribeToConnectedUsers = () => {
            if (stompClientRef.current && stompClientRef.current.connected) {
                const subscription = stompClientRef.current.subscribe(
                    "/topic/connected-users",
                    (message) => {
                        const updatedUsers = JSON.parse(message.body);
                        console.log("Connected users:", updatedUsers);
                        setConnectedUsers(updatedUsers);
                    }
                );
                console.log("Subscription to connected users successful.");
                return subscription;
            } else {
                console.warn("WebSocket client is not connected. Retrying...");
                setTimeout(subscribeToConnectedUsers, 500); // Retry after 500ms
            }
        };

        const subscription = subscribeToConnectedUsers();

        return () => {
            if (subscription) subscription.unsubscribe();
        };
    }, []);
    useEffect(() => {
        if (chatStarted) {
            connectWebSocket(); // Establish WebSocket connection
        }

        return () => {
            if (stompClientRef.current) {
                stompClientRef.current.deactivate(); // Properly close the connection
            }
        };
    }, [chatStarted]);
    // Start polling for new messages
    useEffect(() => {
        let intervalId;

        if (chatStarted && recipientId) {
            fetchMessages(); // Fetch initial messages
            intervalId = setInterval(fetchMessages, 1000); // Poll every second
        }

        return () => {
            if (intervalId) clearInterval(intervalId); // Clear polling on cleanup
        };
    }, [chatStarted, recipientId]);

    // Fetch users on component load
    useEffect(() => {
        fetchUsers();
    }, []);
    // Subscribe and unsubscribe to WebSocket topic
    useEffect(() => {
        let subscription = null;

        if (chatStarted && recipientId) {
            fetchMessages(); // Load past messages

            // Ensure WebSocket is connected before subscribing
            if (stompClientRef.current && stompClientRef.current.connected) {
                subscription = stompClientRef.current.subscribe(`/topic/chat/${recipientId}`, (message) => {
                    const receivedMessage = JSON.parse(message.body);
                    setMessages((prevMessages) => [...prevMessages, receivedMessage]);
                });
            } else {
                console.warn("WebSocket client is not connected. Subscription skipped.");
            }
        }

        return () => {
            if (subscription) subscription.unsubscribe();
        };
    }, [recipientId, chatStarted]);


    // Connect WebSocket when chat is started
    useEffect(() => {
        if (chatStarted) {
            fetchMessages(); // Load past messages
            connectWebSocket(); // Establish WebSocket connection
        }

        return () => {
            if (stompClientRef.current) {
                stompClientRef.current.deactivate();
            }
        };
    }, [chatStarted]);
    useEffect(() => {
        if (chatStarted && recipientId) {
            fetchMessages(); // Fetch initial messages
            markMessagesAsRead(); // Mark messages as read
        }
    }, [chatStarted, recipientId]);

    // Fetch users on component load
    useEffect(() => {
        fetchUsers();
    }, []);

    return (
        <div>
            <h1>Chat</h1>
            <p>Connection Status: {connectionStatus}</p>
            {!chatStarted ? (
                <div>
                    <button
                        onClick={() => navigate(userRole === "admin" ? "/admin" : "/client")}
                        style={{ padding: "10px 20px", marginTop: "10px", backgroundColor: "#007BFF", color: "#fff", cursor: "pointer" }}
                    >
                        Back
                    </button>
                    <h3>Select a {userRole === "client" ? "Admin" : "Client"} to Chat With</h3>
                    <select
                        value={recipientId}
                        onChange={(e) => setRecipientId(e.target.value)}
                        style={{ width: "100%", padding: "10px", marginBottom: "20px" }}
                    >
                        <option value="">Select a User</option>
                        {users.map((user) => (
                            <option key={user.id} value={user.id}>
                                {user.name} ({user.email})
                            </option>
                        ))}
                    </select>
                    <button
                        onClick={() => {
                            if (recipientId) setChatStarted(true);
                        }}
                        style={{ padding: "10px 20px", backgroundColor: "#007BFF", color: "#fff", cursor: "pointer" }}
                    >
                        Start Chat
                    </button>
                </div>
            ) : (
                <div>
                    <div style={{ border: "1px solid black", padding: "10px", height: "300px", overflowY: "scroll" }}>
                        {messages.length > 0 ? (
                            messages.map((msg, index) => (
                                <div key={index} style={{textAlign: msg.senderId === userId ? "right" : "left"}}>
                                    <strong>{msg.senderRole}:</strong> {msg.messageContent}
                                    {msg.senderId === userId && (
                                        <span style={{
                                            marginLeft: "10px",
                                            fontSize: "12px",
                                            color: msg.read ? "green" : "gray"
                                        }}>
                    {msg.read ? "✓ Read" : "✓ Sent"}
                </span>
                                    )}
                                </div>


                            ))
                        ) : (
                            <p>No messages yet. Start the conversation!</p>
                        )}
                    </div>
                    <textarea
                        value={newMessage}
                        onChange={(e) => setNewMessage(e.target.value)}
                        placeholder="Type your message..."
                        style={{width: "100%", height: "50px", marginTop: "10px" }}
                    />
                    <button
                        onClick={sendMessage}
                        style={{ padding: "10px 20px", marginTop: "10px", backgroundColor: "#007BFF", color: "#fff", cursor: "pointer" }}
                    >
                        Send
                    </button>
                </div>
            )}
        </div>
    );
};

export default ChatPage;
