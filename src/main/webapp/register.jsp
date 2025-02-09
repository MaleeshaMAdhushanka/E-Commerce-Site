<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/20/2025
  Time: 9:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration</title>
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

<div class="container-fluid mt-4">
    <div class="row g-0">
        <div class="col-md-6 offset-md-3">
            <div class="card">
                <div class="card-body px-5">

                    <div class="container text-center">
                        <img src="Images/signUp.png" style="max-width: 80px;"
                             class="img-fluid">
                    </div>
                    <h3 class="text-center">Create Account</h3>
                    <%@include file="Components/alert_message.jsp"%>

                    <!--registration-form-->
                    <form id="register-form" action="RegisterServlet" method="post">
                        <div class="row">
                            <div class="col-md-6 mt-2">
                                <label class="form-label">Your name</label> <input type="text"
                                                                                   name="user_name" class="form-control"
                                                                                   placeholder="First and last name" required>
                            </div>
                            <div class="col-md-6 mt-2">
                                <label class="form-label">Email</label> <input type="email"
                                                                               name="user_email" placeholder="Email address"
                                                                               class="form-control" required>
                            </div>
                        </div>



                        <div class="row">

                            <div class="col-md-6 mt-2">
                                <label class="form-label">Password</label> <input
                                    type="password" name="user_password"
                                    placeholder="Enter Password" class="form-control" required>
                            </div>
                        </div>

                        <div id="submit-btn" class="container text-center mt-4">
                            <button type="submit" class="btn btn-outline-primary me-3">Submit</button>
                            <button type="reset" class="btn btn-outline-primary">Reset</button>
                        </div>
                        <div class="mt-3 text-center">
                            <h6>
                                Already have an account?<a href="login.jsp"
                                                           style="text-decoration: none"> Sign in</a>
                            </h6>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>
