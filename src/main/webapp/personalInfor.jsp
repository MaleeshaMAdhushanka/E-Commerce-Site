<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/20/2025
  Time: 9:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="lk.ecommerce.ecommerce1.entities.Message" %>
<%@page import="lk.ecommerce.ecommerce1.entities.User" %>

<%
    User user1 = (User) session.getAttribute("activeUser");
    if (user1 == null) {
        Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
        session.setAttribute("message", message);
        response.sendRedirect("login.jsp");
        return;
    }
%>
<style>
    label {
        font-weight: bold;
    }
</style>
<div class="container px-3 py-3">
    <h3>Personal Information</h3>
    <form id="update-user" action="UpdateUserServlet" method="post">
        <input type="hidden" name="operation" value="updateUser">
        <div class="row">
            <div class="col-md-6 mt-2">
                <label class="form-label">Your name</label> <input type="text"
                                                                   name="name" class="form-control" placeholder="First and last name"
                                                                   value="<%=user1.getUserName()%>">
            </div>
            <div class="col-md-6 mt-2">
                <label class="form-label">Email</label> <input type="email"
                                                               name="email" placeholder="Email address" class="form-control"
                                                               value="<%=user1.getUserEmail()%>">
            </div>
        </div>


        <div id="submit-btn" class="container text-center mt-3">
            <button type="submit" class="btn btn-outline-primary me-3">Update</button>
            <button type="reset" class="btn btn-outline-primary">Reset</button>
        </div>
    </form>
</div>


