<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/20/2025
  Time: 9:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="lk.ecommerce.ecommerce1.entities.Message" %>
<%@page import="lk.ecommerce.ecommerce1.dao.UserDao" %>
<%@page errorPage="error_exception.jsp" %>

<%@page import="lk.ecommerce.ecommerce1.entities.OrderedProduct" %>
<%@page import="lk.ecommerce.ecommerce1.entities.Order" %>
<%@page import="java.util.List" %>
<%@page import="lk.ecommerce.ecommerce1.dao.OrderProductDao" %>
<%@page import="lk.ecommerce.ecommerce1.dao.OrderDao" %>
<%@page import="lk.ecommerce.ecommerce1.helper.ConnectionProvider" %>
<%@ page import="lk.ecommerce.ecommerce1.entities.Admin" %>

<%
    Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
    if (activeAdmin == null) {
        Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
        session.setAttribute("message", message);
        response.sendRedirect("adminlogin.jsp");
        return;
    }
    OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
    OrderProductDao ordProdDao = new OrderProductDao(ConnectionProvider.getConnection());
    List<Order> orderList = orderDao.getAllOrder();
    UserDao userDao = new UserDao(ConnectionProvider.getConnection());
%>

<html>
<head>
    <title>View Order's</title>
    <%@include file="Components/common_css_js.jsp"%>
</head>
<body>
<!--navbar -->
<%@include file="Components/navbar.jsp"%>

<!-- order details -->

<div class="container-fluid px-3 py-3">
    <%
        if (orderList == null || orderList.size() == 0) {
    %>
    <div class="container mt-5 mb-5 text-center">
        <img src="Images/empty-cart.png" style="max-width: 200px;"
             class="img-fluid">
        <h4 class="mt-3">Zero Order found</h4>
    </div>
    <%
    } else {
    %>
    <div class="container-fluid">
        <table class="table table-hover">
            <tr class="table-primary" style="font-size: 18px;">
                <th class="text-center">Product</th>
                <th>Order ID</th>
                <th>Product Details</th>
                <th>Delivery Address</th>
                <th>Date & Time</th>
                <th>Payment Type</th>
                <th>Status</th>
                <th colspan="2" class="text-center">Action</th>
            </tr>
            <%
                for (Order order : orderList) {
                    List<OrderedProduct> ordProdList = ordProdDao.getAllOrderedProduct(order.getId());
                    for (OrderedProduct orderProduct : ordProdList) {
            %>
            <form action="UpdateOrderServlet?oid=<%=order.getId()%>"
                  method="post">
                <tr>
                    <td class="text-center"><img
                            src="Product_imgs\<%=orderProduct.getImage()%>"
                            style="width: 50px; height: 50px; width: auto;"></td>
                    <td><%=order.getOrderId()%></td>
                    <td><%=orderProduct.getName()%><br>Quantity: <%=orderProduct.getQuantity()%><br>Total
                        Price: &#8377;<%=orderProduct.getPrice() * orderProduct.getQuantity()%></td>
                    <td><%=userDao.getUserName(order.getUserId())%><br></td>
                    <td><%=order.getDate()%></td>
                    <td><%=order.getPaymentType()%></td>
                    <td><%=order.getStatus()%></td>
                    <td><select id="operation" name="status" class="form-select">
                        <option>--Select Operation--</option>
                        <option value="Order Confirmed">Order Confirmed</option>
                        <option value="Shipped">Shipped</option>
                        <option value="Out For Delivery">Out For Delivery</option>
                        <option value="Delivered">Delivered</option>
                    </select></td>
                    <td>
                        <%
                            if (order.getStatus().equals("Delivered")) {
                        %>
                        <button type="submit" class="btn btn-success disabled">Update</button>
                        <%
                        } else {
                        %>
                        <button type="submit" class="btn btn-secondary">Update</button>
                        <%
                            }
                        %>
                    </td>
                </tr>
            </form>
            <%
                    }
                }
            %>
        </table>

    </div>
    <%
        }
    %>
</div>

</body>
</html>
