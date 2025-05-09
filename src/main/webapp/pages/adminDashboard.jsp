<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page import="java.io.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="CineStar Admin Dashboard for managing movies, feedback, customer support, and users.">
  <title>CineStar - Admin Dashboard</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
  <style>
    body { font-family: 'Inter', sans-serif; }
    h1, h2, h3, h4, h5, h6 { font-family: 'Poppins', sans-serif; }
    .admin-bg { background: linear-gradient(135deg, #1e3a8a, #3b82f6); }
    .sidebar { transition: width 0.3s ease; }
    .sidebar-collapsed { width: 80px; }
    .sidebar-expanded { width: 250px; }
    .dashboard-card, .card-hover { transition: transform 0.3s ease, box-shadow 0.3s ease; }
    .dashboard-card:hover, .card-hover:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); }
    .sidebar-link { display: flex; align-items: center; padding: 12px 16px; color: #4b5563; transition: background-color 0.2s, color 0.2s; }
    .sidebar-link:hover, .sidebar-link.active { background-color: #2563eb; color: white; }
    .sidebar-link i { margin-right: 12px; min-width: 24 _

    px; }
    .content { transition: margin-left 0.3s ease; }
    .notification { transition: opacity 0.5s ease; }
    @media (max-width: 768px) {
      .sidebar-expanded { width: 200px; }
      .sidebar-collapsed { width: 60px; }
      .content { margin-left: 60px; }
      .sidebar-expanded .content { margin-left: 200px; }
    }
  </style>
</head>
<body class="bg-gray-100">
<c:if test="${empty sessionScope.user}">
  <c:redirect url="${pageContext.request.contextPath}/pages/login.jsp"/>
</c:if>

<div class="flex min-h-screen">
  <aside id="sidebar" class="sidebar sidebar-expanded bg-white shadow-lg fixed top-0 left-0 h-full z-50" aria-label="Sidebar Navigation">
    <div class="flex items-center justify-between h-16 px-4 border-b">
      <a href="${pageContext.request.contextPath}/pages/index.jsp" class="text-2xl font-bold text-blue-600">CineStar</a>
      <button id="toggleSidebar" class="text-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-600 rounded" aria-label="Toggle Sidebar">
        <i class="fas fa-bars text-xl"></i>
      </button>
    </div>
    <nav class="mt-6" aria-label="Main Navigation">
      <ul>
        <li>
          <a href="${pageContext.request.contextPath}/pages/adminDashboard.jsp" class="sidebar-link active" aria-current="page">
            <i class="fas fa-tachometer-alt" aria-hidden="true"></i>
            <span class="sidebar-text">Dashboard</span>
          </a>
        </li>
        <li>
          <a href="#" class="sidebar-link">
            <i class="fas fa-film" aria-hidden="true"></i>
            <span class="sidebar-text">Manage Movies</span>
          </a>
        </li>
        <li>
          <a href="#feedback" class="sidebar-link">
            <i class="fas fa-comment-dots" aria-hidden="true"></i>
            <span class="sidebar-text">Manage Feedback</span>
          </a>
        </li>
        <li>
          <a href="#customer-support" class="sidebar-link">
            <i class="fas fa-headset" aria-hidden="true"></i>
            <span class="sidebar-text">Customer Support</span>
          </a>
        </li>
        <li>
          <a href="#" class="sidebar-link">
            <i class="fas fa-users" aria-hidden="true"></i>
            <span class="sidebar-text">Manage Users</span>
          </a>
        </li>
        <li>
          <a href="${pageContext.request.contextPath}/LogoutServlet" class="sidebar-link">
            <i class="fas fa-sign-out-alt" aria-hidden="true"></i>
            <span class="sidebar-text">Logout</span>
          </a>
        </li>
      </ul>
    </nav>
  </aside>

  <main class="flex-1 content ml-[250px] p-6" aria-label="Main Content">
    <nav class="bg-white shadow-lg rounded-lg p-4 mb-6">
      <div class="flex justify-between items-center">
        <h2 class="text-xl font-semibold text-gray-800">Welcome, <c:out value="${fn:escapeXml(sessionScope.user.username)}"/></h2>
        <div class="flex items-center space-x-4">
          <span id="notification" class="text-sm text-green-600 hidden" role="alert"></span>
          <a href="${pageContext.request.contextPath}/LogoutServlet" class="bg-blue-600 text-white px-4 py-2 rounded-full hover:bg-blue-700 transition focus:outline-none focus:ring-2 focus:ring-blue-600">Logout</a>
        </div>
      </div>
    </nav>

    <section class="admin-bg text-white py-12 rounded-lg mb-12">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <h1 class="text-3xl font-bold mb-8 text-center">Dashboard Overview</h1>
        <div class="dashboard-grid grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
          <div class="dashboard-card bg-white text-gray-800 p-6 rounded-lg shadow-md text-center" role="button" tabindex="0" onclick="window.location.href='#movies'" onkeydown="if(event.key === 'Enter') window.location.href='#movies'">
            <i class="fas fa-film text-4xl text-blue-600 mb-4" aria-hidden="true"></i>
            <h3 class="text-xl font-semibold mb-2">Total Movies</h3>
            <p class="text-2xl font-bold text-gray-600">4</p>
          </div>
          <div class="dashboard-card bg-white text-gray-800 p-6 rounded-lg shadow-md text-center" role="button" tabindex="0" onclick="window.location.href='#feedback'" onkeydown="if(event.key === 'Enter') window.location.href='#feedback'">
            <i class="fas fa-comment-dots text-4xl text-blue-600 mb-4" aria-hidden="true"></i>
            <h3 class="text-xl font-semibold mb-2">Total Feedback</h3>
            <p class="text-2xl font-bold text-gray-600">
              <%
                int feedbackCount = 0;
                String feedbackFile = application.getRealPath("/data/feedback.txt");
                try (BufferedReader reader = new BufferedReader(new FileReader(feedbackFile))) {
                  while (reader.readLine() != null) feedbackCount++;
                  feedbackCount--; // Subtract header line
                } catch (IOException e) {
                  e.printStackTrace();
                }
              %>
              <%= feedbackCount %>
            </p>
          </div>
          <div class="dashboard-card bg-white text-gray-800 p-6 rounded-lg shadow-md text-center" role="button" tabindex="0" onclick="window.location.href='#customer-support'" onkeydown="if(event.key === 'Enter') window.location.href='#customer-support'">
            <i class="fas fa-headset text-4xl text-blue-600 mb-4" aria-hidden="true"></i>
            <h3 class="text-xl font-semibold mb-2">Support Requests</h3>
            <p class="text-2xl font-bold text-gray-600">
              <%
                int supportCount = 0;
                String supportFile = application.getRealPath("/data/customerSupport.txt");
                try (BufferedReader reader = new BufferedReader(new FileReader(supportFile))) {
                  while (reader.readLine() != null) supportCount++;
                  supportCount--; // Subtract header line
                } catch (IOException e) {
                  e.printStackTrace();
                }
              %>
              <%= supportCount %>
            </p>
          </div>
          <div class="dashboard-card bg-white text-gray-800 p-6 rounded-lg shadow-md text-center" role="button" tabindex="0" onclick="alert('Users: <%= new File(application.getRealPath("/data/users.txt")).exists() ? new BufferedReader(new FileReader(application.getRealPath("/data/users.txt"))).lines().count() - 1 : 0 %>')" onkeydown="if(event.key === 'Enter') alert('Users: <%= new File(application.getRealPath("/data/users.txt")).exists() ? new BufferedReader(new FileReader(application.getRealPath("/data/users.txt"))).lines().count() - 1 : 0 %>')">
            <i class="fas fa-users text-4xl text-blue-600 mb-4" aria-hidden="true"></i>
            <h3 class="text-xl font-semibold mb-2">Active Users</h3>
            <p class="text-2xl font-bold text-gray-600">
              <%
                int userCount = 0;
                String userFile = application.getRealPath("/data/users.txt");
                try (BufferedReader reader = new BufferedReader(new FileReader(userFile))) {
                  while (reader.readLine() != null) userCount++;
                  userCount--; // Subtract header line
                } catch (IOException e) {
                  e.printStackTrace();
                }
              %>
              <%= userCount %>
            </p>
          </div>
        </div>
      </div>
    </section>

    <section id="feedback" class="bg-white p-6 rounded-lg shadow-md mb-12">
      <h2 class="text-2xl font-bold text-gray-800 mb-6">Manage Feedback</h2>
      <div class="overflow-x-auto">
        <table class="w-full text-left border-collapse">
          <thead>
          <tr class="bg-gray-100">
            <th class="p-4 text-gray-700">Name</th>
            <th class="p-4 text-gray-700">Email</th>
            <th class="p-4 text-gray-700">Rating</th>
            <th class="p-4 text-gray-700">Comments</th>
          </tr>
          </thead>
          <tbody>
          <%
            List<String[]> feedbackList = new ArrayList<>();
            try (BufferedReader reader = new BufferedReader(new FileReader(feedbackFile))) {
              String line;
              boolean firstLine = true;
              while ((line = reader.readLine()) != null) {
                if (firstLine) {
                  firstLine = false;
                  continue; // Skip header
                }
                String[] parts = line.split(",(?=([^\"]*\"[^\"]*\")*[^\"]*$)", -1);
                if (parts.length >= 4) {
                  for (int i = 0; i < parts.length; i++) {
                    parts[i] = parts[i].replaceAll("^\"|\"$", "").replaceAll("\"\"", "\"");
                  }
                  feedbackList.add(parts);
                }
              }
            } catch (IOException e) {
              e.printStackTrace();
            }
            pageContext.setAttribute("feedbackList", feedbackList);
          %>
          <c:forEach var="feedback" items="${feedbackList}">
            <tr class="border-b">
              <td class="p-4 text-gray-600"><c:out value="${feedback[0]}"/></td>
              <td class="p-4 text-gray-600"><c:out value="${feedback[1]}"/></td>
              <td class="p-4 text-gray-600"><c:out value="${feedback[2]}"/></td>
              <td class="p-4 text-gray-600"><c:out value="${feedback[3]}"/></td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </section>

    <section id="customer-support" class="bg-white p-6 rounded-lg shadow-md">
      <h2 class="text-2xl font-bold text-gray-800 mb-6">Manage Customer Support</h2>
      <div class="overflow-x-auto">
        <table class="w-full text-left border-collapse">
          <thead>
          <tr class="bg-gray-100">
            <th class="p-4 text-gray-700">Name</th>
            <th class="p-4 text-gray-700">Email</th>
            <th class="p-4 text-gray-700">Issue Type</th>
            <th class="p-4 text-gray-700">Description</th>
          </tr>
          </thead>
          <tbody>
          <%
            List<String[]> supportList = new ArrayList<>();
            try (BufferedReader reader = new BufferedReader(new FileReader(supportFile))) {
              String line;
              boolean firstLine = true;
              while ((line = reader.readLine()) != null) {
                if (firstLine) {
                  firstLine = false;
                  continue; // Skip header
                }
                String[] parts = line.split(",(?=([^\"]*\"[^\"]*\")*[^\"]*$)", -1);
                if (parts.length >= 4) {
                  for (int i = 0; i < parts.length; i++) {
                    parts[i] = parts[i].replaceAll("^\"|\"$", "").replaceAll("\"\"", "\"");
                  }
                  supportList.add(parts);
                }
              }
            } catch (IOException e) {
              e.printStackTrace();
            }
            pageContext.setAttribute("supportList", supportList);
          %>
          <c:forEach var="support" items="${supportList}">
            <tr class="border-b">
              <td class="p-4 text-gray-600"><c:out value="${support[0]}"/></td>
              <td class="p-4 text-gray-600"><c:out value="${support[1]}"/></td>
              <td class="p-4 text-gray-600"><c:out value="${support[2]}"/></td>
              <td class="p-4 text-gray- issu-gray-600"><c:out value="${support[3]}"/></td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </section>
  </main>
</div>

<footer class="bg-gray-800 text-white py-8 mt-6">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="text-center">
      <p class="text-gray-400">© <%= java.time.Year.now().getValue() %> CineStar. All rights reserved.</p>
    </div>
  </div>
</footer>

<script>
  (function () {
    const sidebar = document.getElementById('sidebar');
    const toggleSidebar = document.getElementById('toggleSidebar');
    const content = document.querySelector('.content');
    const sidebarTexts = document.querySelectorAll('.sidebar-text');
    const notification = document.getElementById('notification');
    toggleSidebar.addEventListener('click', () => {
      sidebar.classList.toggle('sidebar-expanded');
      sidebar.classList.toggle('sidebar-collapsed');
      updateSidebar();
    });
    function updateSidebar() {
      if (sidebar.classList.contains('sidebar-collapsed')) {
        content.style.marginLeft = '80px';
        sidebarTexts.forEach(text => text.style.display = 'none');
      } else {
        content.style.marginLeft = '250px';
        sidebarTexts.forEach(text => text.style.display = 'inline');
      }
    }
    function showNotification(message, type = 'success') {
      notification.textContent = message;
      notification.className = `text-sm ${type == 'success' ? 'text-green-600' : 'text-red-600'} hidden`;
      notification.classList.remove('hidden');
      setTimeout(() => {
        notification.classList.add('opacity-0');
        setTimeout(() => notification.classList.add('hidden'), 500);
      }, 3000);
    }
    updateSidebar();
    window.showNotification = showNotification;
  })();
</script>
</body>
</html>