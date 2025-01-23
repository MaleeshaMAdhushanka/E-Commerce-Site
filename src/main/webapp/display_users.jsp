<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/20/2025
  Time: 9:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="lk.ecommerce.ecommerce1.entities.Message" %>
<%@page import="lk.ecommerce.ecommerce1.dao.UserDao" %>
<%@ page import="lk.ecommerce.ecommerce1.entities.Admin" %>
<%@page errorPage="error_exception.jsp" %>

<%
    Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
    if (activeAdmin == null) {
        Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
        session.setAttribute("message", message);
        response.sendRedirect("adminlogin.jsp");
        return;
    }
%>

<html>
<head>
    <title>View User's</title>
    <%@include file="Components/common_css_js.jsp"%>

</head>
<body>
<!--navbar -->
<%@include file="Components/navbar.jsp"%>

<div class="container-fluid px-5 py-3">
    <table class="table table-hover">
        <tr class="text-center table-primary" style="font-size: 18px;">
            <th>User Name</th>
            <th>Email</th>
            <th>Phone No.</th>
        </tr>
        <%
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());
            List<User> userList = userDao.getAllUser();
            for (User u : userList) {
        %>
        <tr>
            <td><%=u.getUserName()%></td>
            <td><%=u.getUserEmail()%></td>
            <td><a href="UpdateUserServlet?operation=deleteUser&uid=<%=u.getUserId()%>" role="button" class="btn btn-danger">Remove</a></td>
        </tr>
        <%
            }
        %>
    </table>
</div>

</body>
</html>
