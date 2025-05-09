<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="CineStar: Book movie tickets online for the latest blockbusters and classics.">
    <meta name="keywords" content="CineStar, movie tickets, online booking, cinema, films, blockbusters">
    <title>CineStar - Your Online Movie Ticket Platform</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', Arial, sans-serif; background-color: #f7fafc; margin: 0; }
        .container { max-width: 1280px; margin: 0 auto; padding: 16px; }
        .hero-bg { background: linear-gradient(135deg, #3b82f6 0%, #10b981 100%); }
        .card-hover { transition: transform 0.3s ease, box-shadow 0.3s ease; }
        .card-hover:hover { transform: translateY(-5px); box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15); }
        .movie-card { background: white; border-radius: 12px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); padding: 16px; }
        .error-message { background: #fef2f2; color: #dc2626; padding: 16px; border-radius: 8px; margin-bottom: 24px; }
        .no-movies { text-align: center; color: #4b5563; margin: 32px 0; font-size: 18px; }
        .login-dropdown { position: relative; }
        .login-dropdown-content { display: none; position: absolute; top: 100%; right: 0; background: white; box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15); border-radius: 8px; z-index: 20; min-width: 160px; }
        .login-dropdown:hover .login-dropdown-content { display: block; }
        .login-dropdown-content a { display: block; padding: 12px 24px; color: #1f2937; font-weight: 500; transition: background-color 0.2s; }
        .login-dropdown-content a:hover { background-color: #f3f4f6; color: #2563eb; }
        .category-section { margin-bottom: 32px; }
        .category-header { cursor: pointer; transition: background-color 0.2s; }
        .category-header:hover { background-color: #e5e7eb; }
        .fade-in { animation: fadeIn 0.5s ease-in; }
        .form-container { background: white; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); }
        .form-group label { display: block; font-size: 0.875rem; font-weight: 500; margin-bottom: 0.5rem; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 0.75rem; border: 1px solid #d1d5db; border-radius: 8px; font-size: 1rem; }
        .form-group textarea { resize: vertical; min-height: 100px; }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus { outline: none; border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2); }
        .btn { width: 100%; padding: 0.75rem; background: #3b82f6; color: white; font-weight: 600; border-radius: 8px; text-align: center; transition: background 0.2s; }
        .btn:hover { background: #2563eb; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
        @media (max-width: 640px) {
            .mobile-menu { display: none; }
            .mobile-menu.active { display: block; }
        }
    </style>
    <script type="application/ld+json">
        {
            "@context": "https://schema.org",
            "@type": "WebPage",
            "name": "CineStar Movie Booking",
            "description": "Book movie tickets online for the latest films at CineStar.",
            "breadcrumb": {
                "@type": "BreadcrumbList",
                "itemListElement": [
                    {"@type": "ListItem", "position": 1, "name": "Home", "item": "${pageContext.request.contextPath}/pages/index.jsp"}
                ]
            }
        }
    </script>
</head>
<body class="bg-gray-50">
<!-- Navbar -->
<nav class="bg-white shadow-lg sticky top-0 z-50">
    <div class="container flex justify-between items-center py-4">
        <a href="${pageContext.request.contextPath}/pages/index.jsp" class="text-3xl font-bold text-blue-600">CineStar</a>
        <div class="hidden md:flex items-center space-x-6">
            <div class="relative">
                <input type="text" id="searchInput" placeholder="Search movies..."
                       class="w-80 px-4 py-2 rounded-full border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500"
                       aria-label="Search movies">
                <i class="fas fa-search absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
            </div>
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="flex items-center space-x-4">
                        <span class="text-gray-600 font-medium">
                            Welcome, ${sessionScope.user.username} (${sessionScope.user.role})
                        </span>
                        <c:if test="${sessionScope.user.role == 'admin'}">
                            <a href="${pageContext.request.contextPath}/pages/adminDashboard.jsp"
                               class="text-gray-600 hover:text-blue-600 font-medium">Dashboard</a>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/LogoutServlet"
                           class="bg-blue-600 text-white px-4 py-2 rounded-full hover:bg-blue-700 transition">Logout</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="login-dropdown">
                        <button class="text-gray-600 hover:text-blue-600 font-semibold">Login</button>
                        <div class="login-dropdown-content">
                            <a href="${pageContext.request.contextPath}/pages/login.jsp?role=admin">Admin Login</a>
                            <a href="${pageContext.request.contextPath}/pages/login.jsp?role=user">User Login</a>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/pages/register.jsp"
                       class="bg-blue-600 text-white px-4 py-2 rounded-full hover:bg-blue-700 transition">Sign Up</a>
                </c:otherwise>
            </c:choose>
        </div>
        <button id="mobileMenuToggle" class="md:hidden text-gray-600 focus:outline-none">
            <i class="fas fa-bars text-2xl"></i>
        </button>
    </div>
    <div id="mobileMenu" class="mobile-menu md:hidden bg-white shadow-lg px-4 py-4">
        <div class="relative mb-4">
            <input type="text" id="mobileSearchInput" placeholder="Search movies..."
                   class="w-full px-4 py-2 rounded-full border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500"
                   aria-label="Search movies">
            <i class="fas fa-search absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
        </div>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <div class="flex flex-col space-y-2">
                    <span class="text-gray-600 font-medium">
                        Welcome, ${sessionScope.user.username} (${sessionScope.user.role})
                    </span>
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <a href="${pageContext.request.contextPath}/pages/adminDashboard.jsp"
                           class="text-gray-600 hover:text-blue-600">Dashboard</a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/LogoutServlet"
                       class="bg-blue-600 text-white px-4 py-2 rounded-full hover:bg-blue-700 text-center">Logout</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="flex flex-col space-y-2">
                    <a href="${pageContext.request.contextPath}/pages/login.jsp?role=user"
                       class="text-gray-600 hover:text-blue-600">User Login</a>
                    <a href="${pageContext.request.contextPath}/pages/login.jsp?role=admin"
                       class="text-gray-600 hover:text-blue-600">Admin Login</a>
                    <a href="${pageContext.request.contextPath}/pages/register.jsp"
                       class="bg-blue-600 text-white px-4 py-2 rounded-full hover:bg-blue-700 text-center">Sign Up</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-bg text-white py-24">
    <div class="container flex flex-col md:flex-row items-center">
        <div class="md:w-1/2 mb-8 md:mb-0">
            <h1 class="text-4xl md:text-5xl font-bold mb-4 leading-tight">Your Ultimate Movie Experience</h1>
            <p class="text-lg md:text-xl mb-6 text-gray-100">Book tickets for the latest blockbusters and enjoy a seamless cinema experience.</p>
            <a href="#movies" class="bg-white text-blue-600 px-8 py-3 rounded-full font-semibold hover:bg-gray-100 transition">Book Now</a>
        </div>
        <div class="md:w-1/2">
            <img src="https://via.placeholder.com/600x400/1a202c/ffffff?text=Movie+Poster"
                 alt="Movie Poster" class="rounded-xl shadow-2xl w-full h-72 object-contain">
        </div>
    </div>
</section>

<!-- Categories Section -->
<section id="categories" class="py-16 bg-white">
    <div class="container">
        <h2 class="text-3xl font-bold text-gray-800 mb-8 text-center">Movie Genres</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            <a href="#movies?genre=Action" class="card-hover bg-gray-50 p-6 rounded-xl text-center">
                <i class="fas fa-bolt text-4xl text-blue-600 mb-4"></i>
                <h3 class="text-xl font-semibold text-gray-800">Action</h3>
                <p class="text-gray-600 text-sm">Thrilling adventures and epic battles</p>
            </a>
            <a href="#movies?genre=Comedy" class="card-hover bg-gray-50 p-6 rounded-xl text-center">
                <i class="fas fa-laugh text-4xl text-blue-600 mb-4"></i>
                <h3 class="text-xl font-semibold text-gray-800">Comedy</h3>
                <p class="text-gray-600 text-sm">Laugh-out-loud moments</p>
            </a>
            <a href="#movies?genre=Drama" class="card-hover bg-gray-50 p-6 rounded-xl text-center">
                <i class="fas fa-theater-masks text-4xl text-blue-600 mb-4"></i>
                <h3 class="text-xl font-semibold text-gray-800">Drama</h3>
                <p class="text-gray-600 text-sm">Emotional and compelling stories</p>
            </a>
            <a href="#movies?genre=Sci-Fi" class="card-hover bg-gray-50 p-6 rounded-xl text-center">
                <i class="fas fa-rocket text-4xl text-blue-600 mb-4"></i>
                <h3 class="text-xl font-semibold text-gray-800">Sci-Fi</h3>
                <p class="text-gray-600 text-sm">Futuristic worlds and technology</p>
            </a>
        </div>
    </div>
</section>

<!-- Movies Section -->
<section id="movies" class="py-16 bg-gray-50">
    <div class="container">
        <div class="flex justify-between items-center mb-8">
            <h2 class="text-3xl font-bold text-gray-800">Now Playing</h2>
            <div class="flex space-x-2">
                <button data-genre="all" class="genre-filter bg-blue-600 text-white px-4 py-2 rounded-full hover:bg-blue-700 active">All</button>
                <button data-genre="Action" class="genre-filter bg-gray-200 text-gray-700 px-4 py-2 rounded-full hover:bg-blue-600 hover:text-white">Action</button>
                <button data-genre="Comedy" class="genre-filter bg-gray-200 text-gray-700 px-4 py-2 rounded-full hover:bg-blue-600 hover:text-white">Comedy</button>
                <button data-genre="Drama" class="genre-filter bg-gray-200 text-gray-700 px-4 py-2 rounded-full hover:bg-blue-600 hover:text-white">Drama</button>
                <button data-genre="Sci-Fi" class="genre-filter bg-gray-200 text-gray-700 px-4 py-2 rounded-full hover:bg-blue-600 hover:text-white">Sci-Fi</button>
            </div>
        </div>
        <c:set var="movies" value="${[
            { 'name': 'The Sci-Fi Adventure', 'genre': 'Sci-Fi', 'imageUrl': 'https://via.placeholder.com/200x300/1a202c/ffffff?text=Sci-Fi', 'description': 'An epic journey through space.', 'showtimes': '12:00,15:00,18:00', 'price': 10 },
            { 'name': 'Comedy Night', 'genre': 'Comedy', 'imageUrl': 'https://via.placeholder.com/200x300/2d3748/ffffff?text=Comedy', 'description': 'Hilarious antics unfold.', 'showtimes': '13:00,16:00,19:00', 'price': 8 },
            { 'name': 'Action Thriller', 'genre': 'Action', 'imageUrl': 'https://via.placeholder.com/200x300/1a202c/ffffff?text=Action', 'description': 'High-octane action sequences.', 'showtimes': '11:00,14:00,17:00', 'price': 12 },
            { 'name': 'Romantic Drama', 'genre': 'Drama', 'imageUrl': 'https://via.placeholder.com/200x300/2d3748/ffffff?text=Romance', 'description': 'A heartfelt love story.', 'showtimes': '12:30,15:30,18:30', 'price': 9 }
        ]}" />
        <c:set var="genres" value="Action,Comedy,Drama,Sci-Fi" />
        <c:forEach var="genre" items="${genres.split(',')}">
            <div class="category-section">
                <div class="category-header bg-gray-100 rounded-lg p-4 mb-4 flex justify-between items-center">
                    <h3 class="text-2xl font-semibold text-gray-800">${genre}</h3>
                    <i class="fas fa-chevron-down text-gray-600 toggle-icon"></i>
                </div>
                <div class="category-movies grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6" data-genre="${genre}">
                    <c:forEach var="movie" items="${movies}">
                        <c:if test="${movie.genre == genre}">
                            <div class="movie-card card-hover fade-in" data-name="${fn:toLowerCase(movie.name)}" data-description="${fn:toLowerCase(movie.description)}" data-genre="${movie.genre}">
                                <img src="${movie.imageUrl}" alt="${movie.name}" class="w-full h-48 object-contain mb-4 rounded-lg" loading="lazy">
                                <h3 class="text-lg font-semibold text-gray-800 mb-2">${movie.name}</h3>
                                <p class="text-sm text-gray-600 mb-3 line-clamp-2">${movie.description}</p>
                                <p class="text-sm text-gray-600 mb-3">Showtimes: ${movie.showtimes}</p>
                                <div class="flex justify-between items-center mb-4">
                                    <span class="text-xl font-bold text-blue-600">$${movie.price}</span>
                                    <span class="text-green-600 text-sm font-medium">Available</span>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
    </div>
</section>

<!-- Feedback Form -->
<section id="feedback" class="py-16 bg-white">
    <div class="container">
        <h2 class="text-3xl font-bold text-gray-800 mb-8 text-center">Share Your Feedback</h2>
        <div class="form-container mx-auto max-w-lg">
            <form action="${pageContext.request.contextPath}/FeedbackServlet" method="post">
                <div class="form-group mb-4">
                    <label for="feedback-name" class="text-gray-700">Name</label>
                    <input type="text" id="feedback-name" name="name" required class="text-gray-800">
                </div>
                <div class="form-group mb-4">
                    <label for="feedback-email" class="text-gray-700">Email</label>
                    <input type="email" id="feedback-email" name="email" required class="text-gray-800">
                </div>
                <div class="form-group mb-4">
                    <label for="feedback-rating" class="text-gray-700">Rating</label>
                    <select id="feedback-rating" name="rating" required class="text-gray-800">
                        <option value="5">5 - Excellent</option>
                        <option value="4">4 - Very Good</option>
                        <option value="3">3 - Good</option>
                        <option value="2">2 - Fair</option>
                        <option value="1">1 - Poor</option>
                    </select>
                </div>
                <div class="form-group mb-4">
                    <label for="feedback-comments" class="text-gray-700">Comments</label>
                    <textarea id="feedback-comments" name="comments" required class="text-gray-800"></textarea>
                </div>
                <button type="submit" class="btn">Submit Feedback</button>
            </form>
        </div>
    </div>
</section>

<!-- Customer Support Form -->
<section id="customer-support" class="py-16 bg-gray-50">
    <div class="container">
        <h2 class="text-3xl font-bold text-gray-800 mb-8 text-center">Customer Support</h2>
        <div class="form-container mx-auto max-w-lg">
            <form action="${pageContext.request.contextPath}/CustomerSupportServlet" method="post">
                <div class="form-group mb-4">
                    <label for="support-name" class="text-gray-700">Name</label>
                    <input type="text" id="support-name" name="name" required class="text-gray-800">
                </div>
                <div class="form-group mb-4">
                    <label for="support-email" class="text-gray-700">Email</label>
                    <input type="email" id="support-email" name="email" required class="text-gray-800">
                </div>
                <div class="form-group mb-4">
                    <label for="support-issue" class="text-gray-700">Issue Type</label>
                    <select id="support-issue" name="issueType" required class="text-gray-800">
                        <option value="Booking Issue">Booking Issue</option>
                        <option value="Payment Issue">Payment Issue</option>
                        <option value="Account Issue">Account Issue</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                <div class="form-group mb-4">
                    <label for="support-description" class="text-gray-700">Description</label>
                    <textarea id="support-description" name="description" required class="text-gray-800"></textarea>
                </div>
                <button type="submit" class="btn">Submit Request</button>
            </form>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-gray-900 text-white py-12">
    <div class="container grid grid-cols-1 md:grid-cols-4 gap-8">
        <div>
            <h3 class="text-lg font-semibold mb-4">CineStar</h3>
            <p class="text-gray-300 text-sm">Your one-stop platform for booking movie tickets online.</p>
        </div>
        <div>
            <h3 class="text-lg font-semibold mb-4">Quick Links</h3>
            <ul class="space-y-2">
                <li><a href="#" class="text-gray-300 hover:text-white text-sm">About Us</a></li>
                <li><a href="#" class="text-gray-300 hover:text-white text-sm">Contact Us</a></li>
                <li><a href="#" class="text-gray-300 hover:text-white text-sm">FAQ</a></li>
            </ul>
        </div>
        <div>
            <h3 class="text-lg font-semibold mb-4">Customer Service</h3>
            <ul class="space-y-2">
                <li><a href="#" class="text-gray-300 hover:text-white text-sm">Refunds</a></li>
                <li><a href="#" class="text-gray-300 hover:text-white text-sm">Terms & Conditions</a></li>
            </ul>
        </div>
        <div>
            <h3 class="text-lg font-semibold mb-4">Connect With Us</h3>
            <div class="flex space-x-4">
                <a href="#" class="text-gray-300 hover:text-white text-lg"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="text-gray-300 hover:text-white text-lg"><i class="fab fa-twitter"></i></a>
                <a href="#" class="text-gray-300 hover:text-white text-lg"><i class="fab fa-instagram"></i></a>
            </div>
        </div>
    </div>
    <div class="mt-8 border-t border-gray-700 pt-4 text-center text-gray-300 text-sm">
        <p>© 2025 CineStar. All rights reserved.</p>
    </div>
</footer>

<script>
    try {
        const searchInputs = [document.getElementById('searchInput'), document.getElementById('mobileSearchInput')];
        const movieCards = document.querySelectorAll('.movie-card');
        const categorySections = document.querySelectorAll('.category-section');
        searchInputs.forEach(input => {
            if (input) {
                input.addEventListener('input', () => {
                    const query = input.value.toLowerCase().trim();
                    let hasResults = false;
                    movieCards.forEach(card => {
                        const name = card.dataset.name;
                        const description = card.dataset.description;
                        const matches = name.includes(query) || description.includes(query);
                        card.style.display = matches ? '' : 'none';
                        if (matches) hasResults = true;
                    });
                    categorySections.forEach(section => {
                        const visibleCards = section.querySelectorAll('.movie-card:not([style*="display: none"])');
                        section.style.display = visibleCards.length > 0 || query === '' ? '' : 'none';
                    });
                });
            }
        });
        const genreFilters = document.querySelectorAll('.genre-filter');
        genreFilters.forEach(button => {
            button.addEventListener('click', () => {
                const genre = button.dataset.genre;
                genreFilters.forEach(btn => {
                    btn.classList.remove('bg-blue-600', 'text-white', 'active');
                    btn.classList.add('bg-gray-200', 'text-gray-700');
                });
                button.classList.add('bg-blue-600', 'text-white', 'active');
                button.classList.remove('bg-gray-200', 'text-gray-700');
                let hasResults = false;
                categorySections.forEach(section => {
                    const sectionGenre = section.querySelector('.category-movies').dataset.genre;
                    const matches = genre === 'all' || sectionGenre === genre;
                    section.style.display = matches ? '' : 'none';
                    if (matches) hasResults = true;
                });
            });
        });
        const categoryHeaders = document.querySelectorAll('.category-header');
        categoryHeaders.forEach(header => {
            header.addEventListener('click', () => {
                const movies = header.nextElementSibling;
                const icon = header.querySelector('.toggle-icon');
                const isHidden = movies.style.display === 'none';
                movies.style.display = isHidden ? '' : 'none';
                icon.classList.toggle('fa-chevron-down', isHidden);
                icon.classList.toggle('fa-chevron-up', !isHidden);
            });
        });
        const mobileMenuToggle = document.getElementById('mobileMenuToggle');
        const mobileMenu = document.getElementById('mobileMenu');
        if (mobileMenuToggle && mobileMenu) {
            mobileMenuToggle.addEventListener('click', () => {
                mobileMenu.classList.toggle('active');
            });
        }
    } catch (error) {
        console.error('JavaScript error in index.jsp:', error);
    }
</script>
</body>
</html>