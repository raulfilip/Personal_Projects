import React, {useState, useEffect, useRef} from "react";
import axios from "axios";
import { stompClient } from "../../../../../index";

const AdminPage = () => {
    const [users, setUsers] = useState([]);
    const [activeOperation, setActiveOperation] = useState(""); // Tracks the active operation
    const [userForm, setUserForm] = useState({
        name: "",
        email: "",
        password: "",
        role: "client",
    });
    const [editingUser, setEditingUser] = useState(null);
    const [error, setError] = useState("");
    const [devices, setDevices] = useState([]);
    const [selectedDeviceId, setSelectedDeviceId] = useState("");  // to track the selected device ID
    const [selectedUserId, setSelectedUserId] = useState("");      // to track the selected user ID
    const [deviceForm, setDeviceForm] = useState({
        description: "",
        address: "",
        maxHourlyConsumption: "",
    });
    const [editingDevice, setEditingDevice] = useState(null);

    // Fetch users from the backend
    const token = sessionStorage.getItem("token");

    const fetchUsers = async () => {
        const token = sessionStorage.getItem("token"); // Ensure the token exists
        console.log(token+" sent from admin page")
        try {
            const response = await axios.get("http://localhost:8081/useraccount/all", {
                headers: {
                    "Content-Type": "application/json",
                },
            });
            console.log(response.data); // Display the user data
            setUsers(response.data)
        } catch (error) {
            console.error("Error fetching users:", error);
        }
    };






    const [associationForm, setAssociationForm] = useState({
        deviceId: "",
        userId: "",
    });

    const handleAssociationSubmit = async (e) => {
        e.preventDefault();

        // Ensure that the deviceId and userId are correct before sending the request
        if (!selectedDeviceId || !selectedUserId) {
            setError("Please select both a device and a user.");
            return;
        }

        const associationRequest = {
            deviceId: parseInt(selectedDeviceId, 10),  // Ensure deviceId is an integer
            userId: selectedUserId,                   // userId should already be a valid UUID string
        };

        try {
            const response = await axios.post(
                "http://localhost:8080/smartenergydevice/associate",
                associationRequest,
                { withCredentials: true }
            );

            // Optionally, refresh the devices list or show a success message
            fetchDevices();
            setSelectedDeviceId("");  // Clear selected device
            setSelectedUserId("");    // Clear selected user

            console.log("Device successfully associated with user", response.data);
        } catch (err) {
            console.error("Error associating device with user", err);
            setError("An error occurred while associating the device with the user.");
        }
    };



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

    // Load users when the component is mounted
    useEffect(() => {
        fetchUsers();
        fetchDevices()
    }, []);

    const handleDeviceSubmit = async (e) => {
        e.preventDefault();
        try {
            if (editingDevice) {
                await axios.put(
                    `http://localhost:8080/smartenergydevice/${editingDevice.id}`,
                    deviceForm,
                    { withCredentials: true }
                );
                setEditingDevice(null);
            } else {
                await axios.post("http://localhost:8080/smartenergydevice", deviceForm, {
                    withCredentials: true,
                });
            }
            fetchDevices();
            setDeviceForm({ description: "", address: "", maxHourlyConsumption: "" });
            setActiveOperation(""); // Reset operation after successful submission
        } catch (err) {
            console.error("Error submitting device:", err);
            setError("An error occurred while creating or updating the device.");
        }
    };

    const handleDeleteDevice = async (id) => {
        try {
            await axios.delete(`http://localhost:8080/smartenergydevice/${id}`, {
                withCredentials: true,
            });
            fetchDevices();
        } catch (err) {
            console.error("Error deleting device:", err);
            setError("An error occurred while deleting the device.");
        }
    };


    const handleEditDevice = (device) => {
        setEditingDevice(device);
        setDeviceForm({
            description: device.description,
            address: device.address,
            maxHourlyConsumption: device.maxHourlyConsumption,
        });
        setActiveOperation("editDevice"); // Show the Edit Device form
    };


    // Handle form submit for creating or updating users
    const handleUserSubmit = async (e) => {
        e.preventDefault();
        try {
            // Ensure the role is set correctly, even if it's empty
            if (!userForm.role) {
                setError("Role is required");
                return;
            }

            if (editingUser) {
                const updatePayload = { ...userForm };
                if (userForm.password === "") {
                    delete updatePayload.password; // Remove password if it's not being updated
                }
                // Update user in the user database only (no syncing with device)
                await axios.put(
                    `http://localhost:8081/useraccount/${editingUser.id}`,
                    updatePayload,
                    { withCredentials: true }
                );
                // After successful update, refresh the list of users
                fetchUsers();  // Fetch updated users list
                setEditingUser(null);  // Reset the editing state
                setActiveOperation("");  // Reset active operation (optional)
            } else {
                await axios.post("http://localhost:8081/useraccount", userForm, {
                    withCredentials: true,
                });
                // After creating a new user, refresh the list of users
                fetchUsers();
            }
            setUserForm({ name: "", email: "", password: "", role: "client" });  // Reset form
            setActiveOperation(""); // Reset operation after successful submission
        } catch (err) {
            console.error("Error submitting user:", err);
            setError("An error occurred while creating or updating the user.");
        }
    };






    // Handle editing a user
    const [showPassword, setShowPassword] = useState(false); // State to toggle password visibility

    const handleEditUser = (user) => {
        setEditingUser(user);
        setUserForm({
            name: user.name,
            email: user.email,
            password: user.password || "", // Ensure password is prefilled if available
            role: user.role,
        });
        setActiveOperation("edit");
    };

    const handleRemoveAssociation = (deviceId, userId) => {
        // Call the backend API to remove the association
        axios
            .post("http://localhost:8080/smartenergydevice/unassociate", {
                deviceId: deviceId,
                userId: userId,
            })
            .then(() => {
                // Update the device list by setting userId to null and filter out the devices with no associated user
                setDevices((prevDevices) =>
                    prevDevices
                        .map((device) =>
                            device.id === deviceId ? { ...device, userId: null } : device
                        )
                        .filter((device) => device.userId !== null) // Remove devices with no userId
                );
                console.log(`Association removed for device with ID ${deviceId}`);
            })
            .catch((error) => {
                console.error("Error removing association:", error);
            });
    };




// Use `connectedUsers` to display online status in the user table

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

    // Handle deleting a user
    const handleDeleteUser = async (id) => {
        const token = sessionStorage.getItem("token"); // Retrieve the token from storage
        console.log(token)
        try {
            await axios.delete(`http://localhost:8081/useraccount/${id}`, {
                headers: {
                    Authorization: `Bearer ${token}`,
                },
                withCredentials: true,
            });
            fetchUsers();
        } catch (err) {
            console.error("Error deleting user:", err);
            setError("An error occurred while deleting the user.");
        }
    };



    return (
        <div style={styles.container}>
            <h1>Admin Page</h1>
            {error && <p style={{color: "red"}}>{error}</p>}

            {/* Operation Buttons */}
            <div style={styles.mainButtons}>
                <button
                    style={styles.mainButton}
                    onClick={() => {
                        setActiveOperation("create");
                        setEditingUser(null);
                        setUserForm({name: "", email: "", password: "", role: "client"});
                    }}
                >
                    Create User
                </button>
                <button
                    style={styles.mainButton}
                    onClick={() => {
                        fetchUsers();
                        setActiveOperation("view");
                    }}
                >
                    View Users
                </button>
                <button
                    style={styles.mainButton}
                    onClick={() => {
                        setActiveOperation("createDevice");
                        setEditingDevice(null);
                        setDeviceForm({description: "", address: "", maxHourlyConsumption: ""});
                    }}
                >
                    Create Device
                </button>
                <button
                    style={styles.mainButton}
                    onClick={() => {
                        fetchDevices();
                        setActiveOperation("viewDevices");
                    }}
                >
                    View Devices
                </button>
                <button
                    style={styles.mainButton}
                    onClick={() => {
                        fetchDevices();
                        setActiveOperation("associateDevice");
                    }}
                >
                    Associate Device to User
                </button>
                <button
                    style={styles.mainButton}
                    onClick={() => {
                        fetchDevices();
                        setActiveOperation("viewAssociations");
                    }}
                >
                    View All Associations
                </button>
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

            </div>


            {/* Render Forms or Table Based on Active Operation */}
            {activeOperation === "createDevice" && (
                <form onSubmit={handleDeviceSubmit} style={styles.form}>
                <h3>Create Device</h3>
                    <input
                        type="text"
                        placeholder="Description"
                        value={deviceForm.description}
                        onChange={(e) => setDeviceForm({...deviceForm, description: e.target.value})}
                        required
                        style={styles.input}
                    />
                    <input
                        type="text"
                        placeholder="Address"
                        value={deviceForm.address}
                        onChange={(e) => setDeviceForm({...deviceForm, address: e.target.value})}
                        required
                        style={styles.input}
                    />
                    <input
                        type="number"
                        placeholder="Max Hourly Consumption"
                        value={deviceForm.maxHourlyConsumption}
                        onChange={(e) =>
                            setDeviceForm({...deviceForm, maxHourlyConsumption: e.target.value})
                        }
                        required
                        style={styles.input}
                    />
                    <button type="submit" style={styles.submitButton}>
                        Create Device
                    </button>
                </form>
            )}

            {activeOperation === "editDevice" && (
                <form onSubmit={handleDeviceSubmit} style={styles.form}>
                    <h3>Edit Device</h3>
                    <input
                        type="text"
                        placeholder="Description"
                        value={deviceForm.description}
                        onChange={(e) => setDeviceForm({...deviceForm, description: e.target.value})}
                        required
                        style={styles.input}
                    />
                    <input
                        type="text"
                        placeholder="Address"
                        value={deviceForm.address}
                        onChange={(e) => setDeviceForm({...deviceForm, address: e.target.value})}
                        required
                        style={styles.input}
                    />
                    <input
                        type="number"
                        placeholder="Max Hourly Consumption"
                        value={deviceForm.maxHourlyConsumption}
                        onChange={(e) =>
                            setDeviceForm({...deviceForm, maxHourlyConsumption: e.target.value})
                        }
                        required
                        style={styles.input}
                    />
                    <button type="submit" style={styles.submitButton}>
                        Update Device
                    </button>
                </form>
            )}

            {activeOperation === "viewDevices" && (
                <table style={styles.table}>
                    <thead>
                    <tr>
                        <th>Description</th>
                        <th>Address</th>
                        <th>Max Hourly Consumption</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    {devices.map((device) => (
                        <tr key={device.id}>
                            <td>{device.description}</td>
                            <td>{device.address}</td>
                            <td>{device.maxHourlyConsumption}</td>
                            <td>
                                <button
                                    onClick={() => handleEditDevice(device)}
                                    style={styles.smallButton}
                                >
                                    Edit
                                </button>
                                <button
                                    onClick={() => handleDeleteDevice(device.id)}
                                    style={styles.smallButton}
                                >
                                    Delete
                                </button>
                            </td>
                        </tr>
                    ))}
                    </tbody>
                </table>
            )}


            {activeOperation === "create" && (
                <form onSubmit={handleUserSubmit} style={styles.form}>
                    <h3>Create User</h3>
                    <input
                        type="text"
                        placeholder="Name"
                        value={userForm.name}
                        onChange={(e) => setUserForm({...userForm, name: e.target.value})}
                        required
                        style={styles.input}
                    />
                    <input
                        type="email"
                        placeholder="Email"
                        value={userForm.email}
                        onChange={(e) => setUserForm({...userForm, email: e.target.value})}
                        required
                        style={styles.input}
                    />
                    <div style={styles.passwordContainer}>
                        <input
                            type={showPassword ? "text" : "password"}
                            placeholder="Password"
                            value={userForm.password}
                            onChange={(e) => setUserForm({...userForm, password: e.target.value})}
                            required
                            style={styles.input}
                        />
                        <button
                            type="button"
                            onClick={() => setShowPassword(!showPassword)}
                            style={styles.showPasswordButton}
                        >
                            {showPassword ? "Hide" : "Show"}
                        </button>


                    </div>
                    <select
                        value={userForm.role}
                        onChange={(e) => setUserForm({...userForm, role: e.target.value})}
                        required
                        style={styles.input}
                    >
                        <option value="client">Client</option>
                        <option value="admin">Admin</option>
                    </select>
                    <button type="submit" style={styles.submitButton}>
                        Create User
                    </button>
                </form>

            )}
            {activeOperation === "view" && (
                <div>
                    {users.length === 0 ? (
                        <p>No users available</p>
                    ) : (
                        <table style={styles.table}>
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Password</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            {users.map((user) => (
                                <tr key={user.id}>
                                    <td>{user.name}</td>
                                    <td>{user.email}</td>
                                    <td>{user.password}</td>
                                    <td>{user.role}</td>
                                    <td>
                                        <button
                                            onClick={() => handleEditUser(user)}
                                            style={styles.smallButton}
                                        >
                                            Edit
                                        </button>
                                        <button
                                            onClick={() => handleDeleteUser(user.id)}
                                            style={styles.smallButton}
                                        >
                                            Delete
                                        </button>
                                    </td>
                                </tr>
                            ))}
                            </tbody>
                        </table>
                    )}
                </div>
            )}


            {activeOperation === "associateDevice" && (
                <form onSubmit={handleAssociationSubmit} style={styles.form}>
                    <h3>Associate Device to User</h3>

                    {/* ComboBox for selecting a device */}
                    <select
                        value={selectedDeviceId}
                        onChange={(e) => setSelectedDeviceId(e.target.value)}  // Updates selectedDeviceId on change
                        style={styles.input}
                    >
                        <option value="">Select a Device</option>
                        {devices.filter(device => device.userId === null).map(device => (
                            <option key={device.id} value={device.id}>
                                {device.description} - {device.address}
                            </option>
                        ))}
                    </select>

                    {/* ComboBox for selecting a user */}
                    <select
                        value={selectedUserId}
                        onChange={(e) => setSelectedUserId(e.target.value)}   // Updates selectedUserId on change
                        style={styles.input}
                    >
                        <option value="">Select a User</option>
                        {users.map(user => (
                            <option key={user.id} value={user.id}>
                                {user.name} ({user.email})
                            </option>
                        ))}
                    </select>


                    <button type="submit" style={styles.submitButton}>
                        Associate Device to User
                    </button>
                </form>
            )}

            {activeOperation === "viewAssociations" && (
                <table style={styles.table}>
                    <thead>
                    <tr>
                        <th>Device Description</th>
                        <th>Device Address</th>
                        <th>User Name</th>
                        <th>User Email</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    {devices
                        .map((device) => {
                            const associatedUser = users.find((user) => user.id === device.userId);
                            return (
                                device.userId && (  // Only render the device if it has a user associated
                                    <tr key={device.id}>
                                        <td>{device.description}</td>
                                        <td>{device.address}</td>
                                        <td>{associatedUser?.name || "Unknown"}</td>
                                        <td>{associatedUser?.email || "Unknown"}</td>
                                        <td>
                                            <button
                                                onClick={() =>
                                                    handleRemoveAssociation(device.id, device.userId)
                                                }
                                                style={styles.smallButton}
                                            >
                                                Remove Association
                                            </button>
                                        </td>
                                    </tr>
                                )
                            );
                        })}
                    </tbody>
                </table>
            )}



            {activeOperation === "edit" && (
                <form onSubmit={handleUserSubmit} style={styles.form}>
                    <h3>Edit User</h3>
                    <input
                        type="text"
                        placeholder="Name"
                        value={userForm.name}
                        onChange={(e) => setUserForm({...userForm, name: e.target.value})}
                        required
                        style={styles.input}
                    />
                    <input
                        type="email"
                        placeholder="Email"
                        value={userForm.email}
                        onChange={(e) => setUserForm({...userForm, email: e.target.value})}
                        required
                        style={styles.input}
                    />
                    <div style={styles.passwordContainer}>
                        <input
                            type={showPassword ? "text" : "password"}
                            placeholder="Password (leave blank to keep unchanged)"
                            value={userForm.password}
                            onChange={(e) => setUserForm({...userForm, password: e.target.value})}
                            style={styles.input}
                        />
                        <button
                            type="button"
                            onClick={() => setShowPassword(!showPassword)}
                            style={styles.showPasswordButton}
                        >
                            {showPassword ? "Hide" : "Show"}
                        </button>

                    </div>
                    <select
                        value={userForm.role}
                        onChange={(e) => setUserForm({...userForm, role: e.target.value})}
                        required
                        style={styles.input}
                    >
                        <option value="client">Client</option>
                        <option value="admin">Admin</option>
                    </select>
                    <button type="submit" style={styles.submitButton}>
                        Update User
                    </button>
                </form>
            )}

        </div>
    );
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


export default AdminPage;
