<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/13/2025
  Time: 11:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Login</h1>
    <form action="LoginServlet" method="post" class="form-group">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" class="form-control" required><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" class="form-control" required><br>
        <button type="submit" class="btn btn-primary">Login</button>
    </form>
    <p class="text-center">Don't have an account? <a href="register.jsp">Register here</a></p>
</div>


</body>
</html>
