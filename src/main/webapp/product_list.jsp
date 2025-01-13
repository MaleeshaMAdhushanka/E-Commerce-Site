<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/13/2025
  Time: 10:51 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product List</title>
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">


</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Products</h1>
    <ul class="list-group">
        <%-- Loop through products and display --%>
        <c:forEach var="product" items="${products}">
            <li class="list-group-item">${product.name} - ${product.price}</li>
        </c:forEach>
    </ul>
</div>


</body>
</html>
