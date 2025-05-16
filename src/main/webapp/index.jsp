<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Movie Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/movie.css">
</head>
<body>
<div class="container">
    <h1>Movie Management</h1>
    <a href="movies?action=new" class="btn">Add New Movie</a>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <table>
        <thead>
        <tr>
            <th>Title</th>
            <th>Description</th>
            <th>Release Date</th>
            <th>Available</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="movie" items="${movies}">
            <tr>
                <td>${movie.title}</td>
                <td>${movie.description}</td>
                <td>${movie.releaseDate}</td>
                <td>${movie.available ? 'Yes' : 'No'}</td>
                <td>
                    <a href="movies?action=edit&id=${movie.id}" class="btn">Edit</a>
                    <a href="movies?action=delete&id=${movie.id}" class="btn danger"
                       onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script src="${pageContext.request.contextPath}/js/movie.js"></script>
</body>
</html>