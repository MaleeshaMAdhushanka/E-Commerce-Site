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
    <title>Cart</title>
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Your Shopping Cart</h1>
    <ul class="list-group">
        <%-- Loop through cart items --%>
        <c:forEach var="item" items="${cartItems}">
            <li class="list-group-item">${item.productName} - ${item.quantity} x ${item.price}</li>
        </c:forEach>
    </ul>
    <p class="text-center mt-3">Total: ${cartTotal}</p>
    <a href="checkout.jsp" class="btn btn-primary">Proceed to Checkout</a>
</div>

</body>
</html>
