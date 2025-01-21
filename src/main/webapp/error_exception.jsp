<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/20/2025
  Time: 9:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
    <title>Something went wrong</title>
    <%@include file="Components/common_css_js.jsp"%>

</head>
<body>
<div class="container p-5 text-center">
    <img src="Images/no-results.png" class="img-fluid" style="max-width: 400px;">
    <h1>Sorry! Something went wrong...</h1>
    <p><%=exception%></p>
    <a href="index.jsp" class="btn btn-outline-primary btn-lg mt-3">Home
        Page</a>
</div>


</body>
</html>
