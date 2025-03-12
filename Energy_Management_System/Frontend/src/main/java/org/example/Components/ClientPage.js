import React, {useState, useEffect, useRef} from "react";
import axios from "axios";
import { stompClient } from "../../../../../index";
import Logout from "./LogOut";

const ClientPage = () => {
    const [devices, setDevices] = useState([]);
    const [error, setError] = useState("");

    const [connectedUsers, setConnectedUsers] = useState([]);
    const stompClientRef = useRef(stompClient);
    useEffect(() => {
        if (stompClientRef.current && stompClientRef.current.connected) {
            const subscription = stompClientRef.current.subscribe("/topic/connected-users", (message) => {
                const updatedUsers = JSON.parse(message.body);
                console.log("Connected users:", updatedUsers);
                setConnectedUsers(updatedUsers);
            });

            return () => subscription.unsubscribe();
        }
    }, [stompClientRef.current]);
    // Fetch devices from the backend
    const fetchDevices = async () => {
        try {
            const response = await axios.get("http://localhost:8080/smartenergydevice", {
                withCredentials: true,
            });
            setDevices(response.data);
        } catch (err) {
            console.error("Error fetching devices:", err);
            setError("An error occurred while fetching devices.");
        }
    };


// Use `connectedUsers` to display online status in the user table

    // Load devices when the component is mounted
    useEffect(() => {
        fetchDevices();
    }, []);

    return (
        <div style={styles.container}>
            <h1>Client Page</h1>
            {error && <p style={{color: "red"}}>{error}</p>}
            <button onClick={() => window.location.href = "/chat"} style={styles.mainButton}>
                Open Chat
            </button>
            <button
                style={styles.mainButton}
                onClick={() => {
                    sessionStorage.removeItem("userRole");
                    window.location.href = "/"; // Redirect to the login page
                }}
            >
                Logout
            </button>


            {/* Display Devices */}
            <table style={styles.table}>
                <thead>
                <tr>
                    <th>Description</th>
                    <th>Address</th>
                    <th>Max Hourly Consumption</th>
                </tr>
                </thead>
                <tbody>
                {devices.map((device) => (
                    <tr key={device.id}>
                        <td>{device.description}</td>
                        <td>{device.address}</td>
                        <td>{device.maxHourlyConsumption}</td>
                    </tr>
                ))}
                </tbody>
            </table>

        </div>
    )
        ;
};

const styles = {
    container: {
        padding: "20px",
        fontFamily: "Arial, sans-serif",
        backgroundColor: "#f4f4f9",
        minHeight: "100vh",
    },
    mainButtons: {
        display: "flex",
        justifyContent: "center",
        marginBottom: "20px",
    },
    mainButton: {
        padding: "10px 20px",
        margin: "0 10px",
        fontSize: "16px",
        cursor: "pointer",
        borderRadius: "5px",
        border: "1px solid #ccc",
        backgroundColor: "#007BFF",
        color: "#fff",
        transition: "background-color 0.3s ease",
    },
    mainButtonHover: {
        backgroundColor: "#0056b3",
    },
    form: {
        margin: "20px auto",
        padding: "20px",
        border: "1px solid #ccc",
        borderRadius: "10px",
        width: "350px",
        backgroundColor: "#fff",
        boxShadow: "0 4px 6px rgba(0, 0, 0, 0.1)",
    },
    input: {
        display: "block",
        width: "100%",
        padding: "10px",
        marginBottom: "10px",
        borderRadius: "5px",
        border: "1px solid #ccc",
        fontSize: "14px",
    },
    submitButton: {
        padding: "10px 15px",
        fontSize: "14px",
        cursor: "pointer",
        borderRadius: "5px",
        border: "1px solid #ccc",
        backgroundColor: "#007BFF",
        color: "#fff",
        transition: "background-color 0.3s ease",
    },
    submitButtonHover: {
        backgroundColor: "#0056b3",
    },
    table: {
        width: "100%",
        borderCollapse: "collapse",
        marginTop: "20px",
        backgroundColor: "#fff",
        boxShadow: "0 4px 6px rgba(0, 0, 0, 0.1)",
    },
    tableHeader: {
        backgroundColor: "#007BFF",
        color: "#fff",
        padding: "10px",
        textAlign: "left",
    },
    tableRow: {
        padding: "10px",
        textAlign: "left",
    },
    smallButton: {
        marginLeft: "5px",
        padding: "5px 10px",
        fontSize: "12px",
        cursor: "pointer",
        borderRadius: "5px",
        border: "1px solid #ccc",
        backgroundColor: "#dc3545",
        color: "#fff",
        transition: "background-color 0.3s ease",
    },
    smallButtonHover: {
        backgroundColor: "#c82333",
    },
    passwordContainer: {
        display: "flex",
        alignItems: "center",
        gap: "10px",
        marginBottom: "10px",
    },
    showPasswordButton: {
        padding: "5px 10px",
        fontSize: "12px",
        cursor: "pointer",
        borderRadius: "5px",
        border: "1px solid #ccc",
        backgroundColor: "#007BFF",
        color: "#fff",
        transition: "background-color 0.3s ease",
    },
    showPasswordButtonHover: {
        backgroundColor: "#0056b3",
    },
    errorMessage: {
        color: "red",
        fontSize: "14px",
        marginBottom: "10px",
        textAlign: "center",
    },
    successMessage: {
        color: "green",
        fontSize: "14px",
        marginBottom: "10px",
        textAlign: "center",
    },
};

export default ClientPage;
