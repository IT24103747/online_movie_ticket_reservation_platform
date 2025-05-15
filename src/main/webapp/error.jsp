<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/movie.css">
</head>
<body>
    <div class="container">
        <h1>Error</h1>
        <div class="error-message">
            <c:out value="${error}"/>
        </div>
        <a href="${pageContext.request.contextPath}/movies" class="btn">Back to Movies</a>
    </div>
</body>
</html>