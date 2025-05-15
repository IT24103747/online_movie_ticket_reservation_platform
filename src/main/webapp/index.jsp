<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>CineStar - Online Movie Tickets</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/css/style.css">
</head>
<c:if test="${sessionScope.isDesignAdmin}">
    <div id="design-controls" class="floating-controls">
        <button id="toggleDesignPanel">
            <i class="fas fa-palette"></i>
        </button>
        <div class="design-panel">
            <h3>Design Settings</h3>
            <form id="designForm">
                <label>Color Scheme:</label>
                <input type="color" name="colorScheme" value="#e50914">

                <label>Layout:</label>
                <select name="layout">
                    <option value="grid">Grid</option>
                    <option value="flex">Flex</option>
                </select>

                <button type="submit">Apply Changes</button>
            </form>
        </div>
    </div>
</c:if>
<body>
<!-- Login Button (Owned by User Accounts Team) -->
<div class="login-container">
    <a href="${pageContext.request.contextPath}/login"
       class="login-btn"
       data-team="user-accounts"
       title="Managed by User Accounts Team">
        <i class="fas fa-sign-in-alt"></i> Log In
    </a>
</div>

<!-- Vertical Navigation Bar (Left Side) -->
<div class="sidebar">
    <div class="logo">
        <h1><i class="fas fa-star"></i> CineStar</h1>
    </div>
    <ul class="nav-menu">
        <!-- Dashboard (Your Responsibility) -->
        <li class="nav-item">
            <a href="#" class="nav-link" id="dashboardBtn">
                <i class="fas fa-columns"></i> Dashboard
            </a>
        </li>
        <!-- Movies (Movie Management Team) -->
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/movies"
               class="nav-link"
               data-team="movie-management">
                <i class="fas fa-film"></i> Movies
            </a>
        </li>
        <!-- Support (Support Team) -->
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/support"
               class="nav-link"
               data-team="support">
                <i class="fas fa-headset"></i> Support
            </a>
        </li>
        <!-- Admin (User Accounts Team) -->
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin"
               class="nav-link"
               data-team="user-accounts">
                <i class="fas fa-user-shield"></i> Admin
            </a>
        </li>
        <!-- Log Out (User Accounts Team) -->
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/logout"
               class="nav-link"
               data-team="user-accounts">
                <i class="fas fa-sign-out-alt"></i> Log Out
            </a>
        </li>
    </ul>
</div>

<!-- Main Content Area -->
<div class="main-content">
    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <h2>Experience the Magic of Cinema</h2>
            <p>Book your favorite movies anytime, anywhere</p>

            <!-- Book Now Button (Booking Team) -->
            <a href="${pageContext.request.contextPath}/booking"
               class="book-now-btn"
               data-team="booking">
                <i class="fas fa-ticket-alt"></i> Book Now
            </a>
        </div>
    </section>
</div>

<script src="${pageContext.request.contextPath}/home/js/script.js"></script>
</body>
</html>