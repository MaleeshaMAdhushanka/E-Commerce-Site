<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/20/2025
  Time: 9:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create new password</title>
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
                    <h3 class="text-center mt-3">Update Password</h3>
                    <%@include file="Components/alert_message.jsp"%>

                    <form action="<%=request.getContextPath()%>/ChangePasswordServlet" method="post">
                        <div class="mb-3 mt-3">
                            <label class="form-label">New Password</label> <input
                                type="password" name="password" id="password"
                                placeholder="Enter new password" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Confirm Password</label> <input
                                type="password" id="confirm_password"
                                placeholder="Confirm password" class="form-control" required>
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
<script type="text/javascript">
    var password = document.getElementById("password");
    var confirm_password = document.getElementById("confirm_password");

    function validatePassword() {
        if (password.value != confirm_password.value) {
            confirm_password.setCustomValidity("Passwords Don't Match");
        } else {
            confirm_password.setCustomValidity('');
        }
    }
    password.onchange = validatePassword;
    confirm_password.onkeyup = validatePassword;
</script>

</body>
</html>
