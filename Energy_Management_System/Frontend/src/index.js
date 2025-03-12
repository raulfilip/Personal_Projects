import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import { Client } from "@stomp/stompjs";

// WebSocket Client for STOMP protocol
export const stompClient = new Client({
    brokerURL: "ws://localhost:8082/ws-chat", // Pure WebSocket URL
    connectHeaders: {
        // Add headers if needed, e.g., for authentication
    },
    debug: (str) => console.log(str), // Debugging logs
    reconnectDelay: 5000, // Reconnect after 5 seconds if disconnected
    onConnect: () => {
        console.log("WebSocket connected globally");
    },
    onStompError: (frame) => {
        console.error("STOMP error:", frame.headers["message"]);
    },
    onWebSocketClose: (event) => {
        console.warn("WebSocket closed:", event);
    },
});

stompClient.activate();

// Render React App
const rootElement = document.getElementById("root");
const root = ReactDOM.createRoot(rootElement);

root.render(
    <React.StrictMode>
        <App />
    </React.StrictMode>
);
