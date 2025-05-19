<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Jewllery.login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jewellery Login/Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
    background-color: #1b2a41; /* Dark Blue Background */
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}
.login-container {
    width: 70%;
    background: white;
    display: flex;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
}
.login-image {
    width: 50%;
    background: url('images/login-bg.jpg') no-repeat center center;
}
.login-form {
    width: 50%;
    padding: 40px;
    display: flex;
    flex-direction: column;
    justify-content: center;
}
        .container {
            width: 350px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.2);
            background: #fff;
        }
        .btn-primary, .btn-success {
            width: 100%;
        }
        .toggle-link {
            margin-top: 10px;
            display: block;
            cursor: pointer;
            color: blue;
            text-decoration: underline;
        }
    </style>
    <script>
        function toggleForms(showRegister) {
            document.getElementById('loginForm').style.display = showRegister ? 'none' : 'block';
            document.getElementById('registerForm').style.display = showRegister ? 'block' : 'none';
        }
    </script>
</head>
<body>
    <div class="container-fluid vh-100 d-flex align-items-center justify-content-center">
        <div class="row w-75 shadow-lg" style="max-width: 900px; background: #1a2a41;">
            <!-- Left Side: Image -->
            <div class="col-md-6 p-0">
                <img src="images/login background.jpg" class="img-fluid h-100 w-100" style="object-fit: cover;">
            </div>

            <!-- Right Side: Login Form -->
            <div class="col-md-6 bg-white p-4 d-flex flex-column justify-content-center">
    <form id="form1" runat="server">
        <!-- Login Form -->
        <div id="loginForm">
            <h2 class="text-center mb-3">Login</h2>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control mb-3" placeholder="Username"></asp:TextBox>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control mb-3" placeholder="Password" TextMode="Password"></asp:TextBox>
            <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary w-100" Text="Login" OnClick="btnLogin_Click" />
            <a class="toggle-link text-center mt-2 d-block" onclick="toggleForms(true)">New user? Register here</a>
        </div>

        <!-- Registration Form -->
        <div id="registerForm" style="display: none;">
            <h2 class="text-center mb-3">Register</h2>
            <asp:TextBox ID="txtRegName" runat="server" CssClass="form-control mb-3" placeholder="Full Name"></asp:TextBox>
            <asp:TextBox ID="txtRegEmail" runat="server" CssClass="form-control mb-3" placeholder="Email"></asp:TextBox>
            <asp:TextBox ID="txtRegPassword" runat="server" CssClass="form-control mb-3" placeholder="Password" TextMode="Password"></asp:TextBox>
            <asp:TextBox ID="txtRegPhone" runat="server" CssClass="form-control mb-3" placeholder="Phone"></asp:TextBox>
            <asp:TextBox ID="txtRegAddress" runat="server" CssClass="form-control mb-3" placeholder="Address"></asp:TextBox>
            <asp:Button ID="btnRegister" runat="server" CssClass="btn btn-success w-100" Text="Register" OnClick="btnRegister_Click" />
            <a class="toggle-link text-center mt-2 d-block" onclick="toggleForms(false)">Already registered? Login here</a>
        </div>
    </form>
</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
