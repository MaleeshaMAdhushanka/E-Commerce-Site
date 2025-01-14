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
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Create an Account</h1>
    <form action="RegisterServlet" method="post" class="form-group">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" class="form-control" placeholder="Enter your name" required><br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" class="form-control" placeholder="Enter your email" required><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required><br>
        <label for="role">Role:</label>
        <select id="role" name="role" class="form-control" required>
            <option value="customer">Customer</option>
            <option value="admin">Admin</option>
        </select><br>
        <button type="submit" class="btn btn-primary w-100">Create Account</button>
    </form>
</div>


</body>
</html>
