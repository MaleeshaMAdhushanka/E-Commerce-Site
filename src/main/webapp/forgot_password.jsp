<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/20/2025
  Time: 9:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Forget Password</title>
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

<div class="container-fluid ">
    <div class="row mt-5">
        <div class="col-md-4 offset-md-4">
            <div class="card">
                <div class="card-body px-5">

                    <div class="container text-center">
                        <img src="Images/forgot-password.png" style="max-width: 100px;"
                             class="img-fluid">
                    </div>
                    <h3 class="text-center mt-3">Change Password</h3>
                    <%@include file="Components/alert_message.jsp"%>

                    <!--change password-->
                    <form action="ChangePasswordServlet" method="post">
                        <div class="mb-3">
                            <label class="form-label">Email</label> <input type="email"
                                                                           name="email" placeholder="Enter email" class="form-control"
                                                                           required>
                        </div>
                        <div class="container text-center">
                            <button type="submit" class="btn btn-outline-primary me-3">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
