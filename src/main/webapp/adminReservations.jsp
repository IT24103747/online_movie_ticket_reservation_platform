<%@ page import="java.util.List" %>
<%@ page import="model.Reservation" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - All Reservations</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-8">
<div class="bg-white p-8 rounded shadow-md w-full max-w-4xl mx-auto">
    <h2 class="text-2xl font-bold mb-4">All Reservations</h2>
    <table class="min-w-full bg-white">
        <thead>
        <tr>
            <th class="px-4 py-2">ID</th>
            <th class="px-4 py-2">User</th>
            <th class="px-4 py-2">Movie</th>
            <th class="px-4 py-2">Show Time</th>
            <th class="px-4 py-2">Seats</th>
            <th class="px-4 py-2">Status</th>
            <th class="px-4 py-2">Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
            if (reservations != null) {
                for (Reservation r : reservations) {
        %>
        <tr class="border-t">
            <td class="px-4 py-2"><%= r.getId() %></td>
            <td class="px-4 py-2"><%= r.getUserName() %></td>
            <td class="px-4 py-2"><%= r.getMovie() %></td>
            <td class="px-4 py-2"><%= r.getShowTime() %></td>
            <td class="px-4 py-2"><%= r.getSeats() %></td>
            <td class="px-4 py-2"><%= r.getStatus() %></td>
            <td class="px-4 py-2 flex space-x-2">
                <!-- Accept -->
                <form action="AdminUpdateReservationServlet" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= r.getId() %>"/>
                    <input type="hidden" name="action" value="accept"/>
                    <button type="submit" class="bg-green-500 text-white px-2 py-1 rounded">Accept</button>
                </form>
                <!-- Reject -->
                <form action="AdminUpdateReservationServlet" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= r.getId() %>"/>
                    <input type="hidden" name="action" value="reject"/>
                    <button type="submit" class="bg-red-500 text-white px-2 py-1 rounded">Reject</button>
                </form>
                <!-- Edit -->
                <form action="editReservation.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="id" value="<%= r.getId() %>"/>
                    <button type="submit" class="bg-yellow-500 text-white px-2 py-1 rounded">Edit</button>
                </form>
                <!-- Delete -->
                <form action="AdminDeleteReservationServlet" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this reservation?');">
                    <input type="hidden" name="id" value="<%= r.getId() %>"/>
                    <button type="submit" class="bg-gray-700 text-white px-2 py-1 rounded">Delete</button>
                </form>
            </td>
        </tr>
        <%      }
        }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
