<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/20/2025
  Time: 9:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="lk.ecommerce.ecommerce1.entities.Message" %>
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
    <title>View Categories</title>
    <%@include file="Components/common_css_js.jsp"%>
</head>
<body>
<!--navbar -->
<%@include file="Components/navbar.jsp"%>

<!-- Category -->
<div class="container mt-3">
    <%@include file="Components/alert_message.jsp"%>
    <table class="table table-hover">
        <tr class="table-primary text-center" style="font-size: 20px;">
            <th>Image</th>
            <th>Category Name</th>
            <th>Action</th>
        </tr>
        <%
            for (Category c : categoryList) {
        %>
        <tr class="text-center">
            <td><img src="Product_imgs\<%=c.getCategoryImage()%>"
                     style="width: 60px; height: 60px; width: auto;"></td>
            <td><%=c.getCategoryName()%></td>
            <td><a href="update_category.jsp?cid=<%=c.getCategoryId()%>" role="button" class="btn btn-secondary">Update</a>&emsp;<a
                    href="AddOperationServlet?cid=<%=c.getCategoryId()%>&operation=deleteCategory"
                    class="btn btn-danger" role="button">Delete</a></td>
        </tr>
        <%
            }
        %>
    </table>
</div>


</body>
</html>
