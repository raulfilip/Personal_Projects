import { Navigate } from "react-router-dom";

const PrivateRoute = ({ children, allowedRoles }) => {
    const userRole = sessionStorage.getItem("userRole"); // Get role from localStorage

    // Check if the user's role is allowed
    return allowedRoles.includes(userRole) ? children : <Navigate to="/" />;
};

export default PrivateRoute;
