<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/20/2025
  Time: 9:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="lk.ecommerce.ecommerce1.dao.AdminDao" %>
<%@ page import="lk.ecommerce.ecommerce1.entities.Admin" %>
<%@ page import="lk.ecommerce.ecommerce1.entities.Message" %>
<%@ page import="lk.ecommerce.ecommerce1.helper.ConnectionProvider" %>
<%@ page import="java.util.List" %>
<%@page errorPage="error_exception.jsp" %>

<%
    Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
    if (activeAdmin == null) {
        Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
        session.setAttribute("message", message);
        response.sendRedirect("adminlogin.jsp");
        return;
    }
    AdminDao adminDao = new AdminDao(ConnectionProvider.getConnection());
    List<Admin> adminList = adminDao.getAllAdmin();
%>
<html>
<head>
    <title>View Admin's</title>
    <%@include file="Components/common_css_js.jsp"%>
    <style>
        label {
            font-weight: bold;
        }
    </style>

</head>
<body>
<!--navbar -->
<%@include file="Components/navbar.jsp"%>

<div class="container-fluid px-5 py-3">
    <div class="row">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body px-3">
                    <div class="container text-center">
                        <img src="Images/admin.png" style="max-width: 100px;"
                             class="img-fluid">
                    </div>
                    <h3 class="text-center">Add Admin</h3>
                    <%@include file="Components/alert_message.jsp"%>

                    <!--admin-form-->
                    <form action="AdminServlet?operation=save" method="post">
                        <div class="mb-3">
                            <label class="form-label">Name</label> <input type="text"
                                                                          name="name" placeholder="Enter name" class="form-control"
                                                                          required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label> <input type="email"
                                                                           name="email" placeholder="Email address" class="form-control"
                                                                           required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label> <input
                                type="password" name="password" placeholder="Enter password"
                                class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phone</label> <input type="number"
                                                                           name="phone" placeholder="Enter phone number"
                                                                           class="form-control" required>
                        </div>
                        <div class="d-grid gap-2 col-6 mx-auto py-3">
                            <button type="submit" class="btn btn-primary me-3">Register</button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
        <div class="col-md-8">
            <div class="card">
                <div class="card-body px-3">
                    <table class="table table-hover">
                        <tr class="text-center table-primary" style="font-size: 18px;">
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Action</th>
                        </tr>
                        <%
                            for (Admin a : adminList) {
                        %>
                        <tr class="text-center">
                            <td><%=a.getName() %></td>
                            <td><%=a.getEmail() %></td>
                            <td><%=a.getPhone() %></td>
                            <td><a href="AdminServlet?operation=delete&id=<%=a.getId()%>" role="button" class="btn btn-danger">Remove</a></td>
                        </tr>
                        <%
                            }
                        %>
                    </table>
                </div>
            </div>
        </div>
    </div>
 </div>

</body>
</html>
