<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="login/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
</head>
<body>
<div class="auth-container">
    <!-- Logo Section -->
    <div class="logo-container" style="text-align: center; margin-bottom: 20px;">

    </div>

    <div class="login-container" id="loginContainer">
        <h1>Login</h1>

        <form id="loginForm">
            <div class="input-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>

            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="options">
                <div class="remember-me">
                    <input type="checkbox" id="remember" name="remember">
                    <label for="remember">Remember Me</label>
                </div>
                <a href="#" class="forgot-password">Forget Password</a>
            </div>

            <button type="submit" class="auth-button">Login</button>
        </form>

        <div class="switch-auth">
            Don't have an account? <a href="signup.jsp" class="switch-link">Sign Up</a>
        </div>
    </div>
</div>

<script src="login/js/script.js"></script>
</body>
</html>