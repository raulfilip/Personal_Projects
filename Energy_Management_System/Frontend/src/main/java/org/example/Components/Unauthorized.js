const Unauthorized = () => {
    return (
        <div style={{ textAlign: "center", marginTop: "50px" }}>
            <h1>403 - Unauthorized</h1>
            <p>You are not authorized to view this page.</p>
            <a href="/">Go to Login</a>
        </div>
    );
};

export default Unauthorized;
