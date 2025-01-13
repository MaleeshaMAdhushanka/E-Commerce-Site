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
    <title>CheckOut</title>
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Checkout</h1>
    <form action="PlaceOrderServlet" method="post" class="form-group">
        <label for="address">Shipping Address:</label>
        <input type="text" id="address" name="address" class="form-control" required><br>
        <label for="payment">Payment Method:</label>
        <select id="payment" name="payment" class="form-control" required>
            <option value="credit">Credit Card</option>
            <option value="paypal">PayPal</option>
        </select><br>
        <button type="submit" class="btn btn-success">Place Order</button>
    </form>
</div>

</body>
</html>
