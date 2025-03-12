import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Login from "./main/java/org/example/Components/Login";
import AdminPage from "./main/java/org/example/Components/AdminPage";
import ClientPage from "./main/java/org/example/Components/ClientPage";
import ChatPage from "./main/java/org/example/Components/ChatPage";
import PrivateRoute from "./PrivateRoute";
import Unauthorized from "./main/java/org/example/Components/Unauthorized";

const App = () => {
    return (
        <Router>
            <Routes>
                <Route path="/" element={<Login />} />
                <Route
                    path="/admin"
                    element={
                        <PrivateRoute allowedRoles={["admin"]}>
                            <AdminPage />
                        </PrivateRoute>
                    }
                />
                <Route
                    path="/client"
                    element={
                        <PrivateRoute allowedRoles={["client"]}>
                            <ClientPage />
                        </PrivateRoute>
                    }
                />
                <Route
                    path="/unauthorized"
                    element={<h2>You are not authorized to view this page</h2>}
                />
                <Route path="/unauthorized" element={<Unauthorized />} />
                <Route
                    path="/chat"
                    element={<ChatPage userId={sessionStorage.getItem("userId")} userRole={sessionStorage.getItem("userRole")} />}
                />


            </Routes>
        </Router>
    );
};

export default App;
