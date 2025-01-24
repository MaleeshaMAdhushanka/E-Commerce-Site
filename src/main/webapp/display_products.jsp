<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/20/2025
  Time: 9:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="lk.ecommerce.ecommerce1.entities.Message" %>
<%@page errorPage="error_exception.jsp" %>
<%@page import="lk.ecommerce.ecommerce1.dao.UserDao" %>
<%@page import="lk.ecommerce.ecommerce1.entities.Product" %>
<%@page import="lk.ecommerce.ecommerce1.dao.ProductDao" %>
<%@ page import="lk.ecommerce.ecommerce1.entities.Admin" %>
<%@ page import="lk.ecommerce.ecommerce1.helper.ConnectionProvider" %>


<%
    Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
    if (activeAdmin == null) {
        Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
        session.setAttribute("message", message);
        response.sendRedirect("adminlogin.jsp");
        return;
    }
    UserDao userDao = new UserDao(ConnectionProvider.getConnection());
    ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
%>
<html>
<head>
    <title>View Product's</title>
    <%@include file="Components/common_css_js.jsp"%>
</head>
<body>
<!--navbar -->
<%@include file="Components/navbar.jsp"%>

<!-- update product -->
<div class="container mt-3">
    <%@include file="Components/alert_message.jsp"%>
    <table class="table table-hover">
        <tr class="table-primary text-center" style="font-size: 20px;">
            <th>Image</th>
            <th>Name</th>
            <th class="text-start">Category</th>
            <th>Price</th>
            <th class="text-start">Quantity</th>
            <th class="text-start">Discount</th>
            <th>Action</th>
        </tr>
        <%
            List<Product> productList = productDao.getAllProducts();
            for (Product prod : productList) {
                String category = catDao.getCategoryName(prod.getCategoryId());
        %>
        <tr class="text-center">
            <td><img src="Images/<%=prod.getProductImages()%>"
                     style="width: 60px; height: 60px; width: auto;"></td>
            <td class="text-start"><%=prod.getProductName()%></td>
            <td><%=category%></td>
            <td>&#36;<%=prod.getProductPriceAfterDiscount()%></td>
            <td><%=prod.getProductQuantity()%></td>
            <td><%=prod.getProductDiscount()%>%</td>
            <td><a href="update_product.jsp?pid=<%=prod.getProductId()%>" role="button" class="btn btn-secondary">Update</a>&emsp;<a
                    href="AddOperationServlet?pid=<%=prod.getProductId()%>&operation=deleteProduct"
                    class="btn btn-danger" role="button">Delete</a></td>
        </tr>
        <%
            }
        %>
    </table>
</div>

</body>
</html>
