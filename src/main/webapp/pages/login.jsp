<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Log in to CineStar to book movie tickets or manage the platform as an admin.">
    <meta name="keywords" content="CineStar, login, movie tickets, admin, user">
    <title>CineStar - Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background: linear-gradient(135deg, #3b82f6 0%, #10b981 100%); margin: 0; min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        h1, h2 { font-family: 'Poppins', sans-serif; }
        .login-container { max-width: 400px; width: 100%; padding: 2rem; background: white; border-radius: 12px; box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15); }
        .form-group label { display: block; font-size: 0.875rem; font-weight: 500; color: #1f2937; margin-bottom: 0.5rem; }
        .form-group input { width: 100%; padding: 0.75rem; border: 1px solid #d1d5db; border-radius: 8px; font-size: 1rem; transition: border-color 0.2s, box-shadow 0.2s; }
        .form-group input:focus { outline: none; border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2); }
        .form-group input.valid { border-color: #10b981; }
        .form-group input.invalid { border-color: #dc2626; }
        .btn { width: 100%; padding: 0.75rem; background: #3b82f6; color: white; font-weight: 600; border-radius: 8px; text-align: center; transition: background 0.2s; }
        .btn:hover { background: #2563eb; }
        .error-message { background: #fef2f2; color: #dc2626; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem; display: flex; align-items: center; }
        .error-message i { margin-right: 0.5rem; }
        .fade-in { animation: fadeIn 0.5s ease-in; }
        .checkbox-group { display: flex; align-items: center; margin-bottom: 1rem; }
        .checkbox-group input { width: auto; margin-right: 0.5rem; }
        .links { display: flex; justify-content: space-between; margin-top: 1rem; }
        .links a { color: #3b82f6; text-decoration: none; font-size: 0.875rem; transition: color 0.2s; }
        .links a:hover { color: #2563eb; text-decoration: underline; }
        .sr-only { position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip: rect(0, 0, 0, 0); border: 0; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
        @media (max-width: 640px) {
            .login-container { margin: 1rem; padding: 1.5rem; }
        }
    </style>
    <script type="application/ld+json">
        {
            "@context": "https://schema.org",
            "@type": "WebPage",
            "name": "CineStar Login",
            "description": "Log in to CineStar to book movie tickets or manage the platform.",
            "breadcrumb": {
                "@type": "BreadcrumbList",
                "itemListElement": [
                    {"@type": "ListItem", "position": 1, "name": "Home", "item": "${pageContext.request.contextPath}/pages/index.jsp"},
                    {"@type": "ListItem", "position": 2, "name": "Login", "item": "${pageContext.request.contextPath}/pages/login.jsp"}
                ]
            }
        }
    </script>
</head>
<body>
<div class="login-container fade-in" role="main" aria-label="Login Form">
    <h1 class="text-2xl font-bold text-gray-800 mb-6 text-center">Log in to CineStar</h1>

    <!-- Error Message -->
    <c:if test="${not empty sessionScope.error}">
        <div class="error-message fade-in" role="alert" aria-live="assertive">
            <i class="fas fa-exclamation-circle"></i>
            <c:out value="${sessionScope.error}"/>
            <% session.removeAttribute("error"); %>
        </div>
    </c:if>

    <!-- Login Form -->
    <form action="${pageContext.request.contextPath}/LoginServlet" method="post" id="loginForm" aria-describedby="form-instructions">
        <p id="form-instructions" class="sr-only">Please enter your username and password to log in.</p>

        <input type="hidden" name="role" value="${param.role}">

        <div class="form-group mb-4">
            <label for="username" class="text-gray-700">Username</label>
            <input type="text" id="username" name="username" required
                   class="text-gray-800"
                   aria-required="true"
                   placeholder="Enter your username"
                   value="<c:out value='${param.username}'/>">
        </div>

        <div class="form-group mb-4">
            <label for="password" class="text-gray-700">Password</label>
            <input type="password" id="password" name="password" required
                   class="text-gray-800"
                   aria-required="true"
                   placeholder="Enter your password">
        </div>

        <div class="checkbox-group">
            <input type="checkbox" id="rememberMe" name="rememberMe" aria-describedby="rememberMe-label">
            <label for="rememberMe" id="rememberMe-label" class="text-gray-700 text-sm">Remember Me</label>
        </div>

        <button type="submit" class="btn" aria-label="Submit login form">Log In</button>

        <div class="links">
            <a href="${pageContext.request.contextPath}/pages/register.jsp" aria-label="Sign up for a new account">Don't have an account? Sign Up</a>
            <a href="#" aria-label="Recover your password">Forgot Password?</a>
        </div>
    </form>
</div>

<script>
    (function () {
        const form = document.getElementById('loginForm');
        const usernameInput = document.getElementById('username');
        const passwordInput = document.getElementById('password');

        // Real-time validation
        function validateInput(input) {
            if (input.value.trim() === '') {
                input.classList.remove('valid');
                input.classList.add('invalid');
            } else {
                input.classList.remove('invalid');
                input.classList.add('valid');
            }
        }

        usernameInput.addEventListener('input', () => validateInput(usernameInput));
        passwordInput.addEventListener('input', () => validateInput(passwordInput));

        // Form submission validation
        form.addEventListener('submit', (e) => {
            let isValid = true;
            [usernameInput, passwordInput].forEach(input => {
                validateInput(input);
                if (input.value.trim() === '') isValid = false;
            });
            if (!isValid) {
                e.preventDefault();
                alert('Please fill in all required fields.');
            }
        });

        // Focus on first input
        usernameInput.focus();
    })();
</script>
</body>
</html>