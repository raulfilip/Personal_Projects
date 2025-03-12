import { useNavigate } from "react-router-dom";

const Logout = () => {
    const navigate = useNavigate();

    const handleLogout = () => {
        sessionStorage.removeItem("userRole"); // Clear user role
        navigate("/"); // Redirect to login page
    };

    return <button onClick={handleLogout}>Logout</button>;
};

export default Logout;
