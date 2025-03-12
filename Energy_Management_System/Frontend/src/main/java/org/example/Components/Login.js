import { useNavigate } from "react-router-dom";
import axios from "axios";
import React, { useState, useEffect } from "react"; // Import useEffect for clearing the role

const Login = () => {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [error, setError] = useState("");
    const navigate = useNavigate();

    // Clear the userRole when the component is mounted
    useEffect(() => {
        sessionStorage.removeItem("userRole");
    }, []); // Empty dependency array ensures this runs only once when the component is mounted

    const handleLogin = async (e) => {
        e.preventDefault();

        try {
            // Make login request to the backend
            const response = await axios.post(
                "http://localhost:8081/useraccount/login",
                { email, password },
                { headers: { "Content-Type": "application/json" }, withCredentials: true }
            );

            const { token, user } = response.data;

            // Store the token, role, and id in sessionStorage
            sessionStorage.setItem("token", token);
            sessionStorage.setItem("userRole", user.role); // Store role
            sessionStorage.setItem("userId", user.id);     // Store user ID

            console.log("Token being sent from log in:", token); // Debug log

            // Redirect based on role
            if (user.role === "admin") {
                navigate("/admin");
            } else if (user.role === "client") {
                navigate("/client");
            }
        } catch (err) {
            console.error("Login failed:", err);
            setError("Invalid email or password.");
        }
    };





    return (
        <div style={styles.container}>
            <form onSubmit={handleLogin} style={styles.form}>
                <h2 style={styles.title}>Login</h2>
                {error && <p style={styles.error}>{error}</p>}
                <input
                    type="email"
                    placeholder="Email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    required
                    style={styles.input}
                />
                <input
                    type="password"
                    placeholder="Password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    required
                    style={styles.input}
                />
                <button type="submit" style={styles.button}>Login</button>
            </form>
        </div>
    );
};

const styles = {
    container: {
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
        height: "100vh",
        backgroundColor: "#f5f5f5",
        fontFamily: "'Arial', sans-serif",
    },
    form: {
        width: "300px",
        padding: "20px",
        borderRadius: "10px",
        backgroundColor: "#fff",
        boxShadow: "0 4px 6px rgba(0, 0, 0, 0.1)",
        textAlign: "center",
    },
    title: {
        fontSize: "24px",
        marginBottom: "20px",
        color: "#333",
    },
    input: {
        width: "100%",
        padding: "10px",
        marginBottom: "15px",
        borderRadius: "5px",
        border: "1px solid #ccc",
        fontSize: "16px",
    },
    button: {
        width: "100%",
        padding: "10px",
        borderRadius: "5px",
        border: "none",
        backgroundColor: "#007BFF",
        color: "#fff",
        fontSize: "16px",
        cursor: "pointer",
        transition: "background-color 0.3s ease",
    },
    buttonHover: {
        backgroundColor: "#0056b3",
    },
    error: {
        color: "red",
        fontSize: "14px",
        marginBottom: "15px",
    },
};

export default Login;