<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reserve Movie Ticket</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">
<div class="bg-white p-8 rounded shadow-md w-full max-w-md">
    <h2 class="text-2xl font-bold mb-4">Reserve Movie Ticket</h2>
    <form action="ReserveTicketServlet" method="post" class="space-y-4">
        <input type="text" name="userName" placeholder="Your Name" required class="w-full px-3 py-2 border rounded"/>
        <input type="text" name="movie" placeholder="Movie Name" required class="w-full px-3 py-2 border rounded"/>
        <input type="text" name="showTime" placeholder="Show Time" required class="w-full px-3 py-2 border rounded"/>
        <input type="number" name="seats" min="1" placeholder="Number of Seats" required class="w-full px-3 py-2 border rounded"/>
        <button type="submit" class="bg-indigo-600 text-white px-4 py-2 rounded">Reserve</button>
    </form>
    <% if (request.getParameter("success") != null) { %>
    <p class="text-green-600 mt-4">Reservation submitted! Await admin approval.</p>
    <% } %>
    <% if (request.getParameter("error") != null) { %>
    <p class="text-red-600 mt-4"><%= request.getParameter("error") %></p>
    <% } %>
</div>
</body>
</html>
