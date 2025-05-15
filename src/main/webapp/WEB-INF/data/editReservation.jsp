<%@ page import="java.util.*" %>
<%@ page import="model.Reservation" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String filePath = application.getRealPath("/WEB-INF/data/reservations.txt");
    int id = Integer.parseInt(request.getParameter("id"));
    Reservation editRes = null;
    try (BufferedReader br = new BufferedReader(new java.io.FileReader(filePath))) {
        String line;
        while ((line = br.readLine()) != null) {
            Reservation r = Reservation.fromFileString(line);
            if (r.getId() == id) {
                editRes = r;
                break;
            }
        }
    } catch (Exception e) {}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Reservation</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">
<div class="bg-white p-8 rounded shadow-md w-full max-w-md">
    <h2 class="text-2xl font-bold mb-4">Edit Reservation</h2>
    <form action="AdminEditReservationServlet" method="post" class="space-y-4">
        <input type="hidden" name="id" value="<%= editRes.getId() %>"/>
        <input type="text" name="userName" value="<%= editRes.getUserName() %>" required class="w-full px-3 py-2 border rounded"/>
        <input type="text" name="movie" value="<%= editRes.getMovie() %>" required class="w-full px-3 py-2 border rounded"/>
        <input type="text" name="showTime" value="<%= editRes.getShowTime() %>" required class="w-full px-3 py-2 border rounded"/>
        <input type="number" name="seats" value="<%= editRes.getSeats() %>" min="1" required class="w-full px-3 py-2 border rounded"/>
        <input type="text" name="status" value="<%= editRes.getStatus() %>" required class="w-full px-3 py-2 border rounded"/>
        <button type="submit" class="bg-indigo-600 text-white px-4 py-2 rounded">Save Changes</button>
    </form>
</div>
</body>
</html>
