<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/13/2025
  Time: 11:04 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile Management</title>
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Profile Management</h1>
    <form action="ProfileManagementServlet" method="post" class="form-group">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" class="form-control" value="${user.email}" required><br>
        <label for="password">New Password:</label>
        <input type="password" id="password" name="password" class="form-control"><br>
        <button type="submit" class="btn btn-primary">Update</button>
    </form>
</div>

</body>
</html>
