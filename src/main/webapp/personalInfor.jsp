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
        <div class="row">
            <div class="col-md-6 mt-2">
                <label class="form-label">Mobile number</label> <input type="number"
                                                                       name="mobile_no" placeholder="Mobile number" class="form-control"
                                                                       value="<%=user1.getUserPhone()%>">
            </div>
            <div class="col-md-6 mt-5">
                <label class="form-label pe-3">Gender</label>
                <%
                    String gender = user1.getUserGender();
                    if (gender.trim().equals("Male")) {
                %>
                <input class="form-check-input" type="radio" name="gender"
                       value="Male" checked> <span
                    class="form-check-label pe-3 ps-1"> Male </span> <input
                    class="form-check-input" type="radio" name="gender" value="Female">
                <span class="form-check-label ps-1"> Female </span>

                <%
                } else {
                %>
                <input class="form-check-input" type="radio" name="gender"
                       value="Male"> <span class="form-check-label pe-3 ps-1">
					Male </span> <input class="form-check-input" type="radio" name="gender"
                                        value="Female" checked> <span class="form-check-label ps-1">
					Female </span>
                <%
                    }
                %>

            </div>
        </div>
        <div class="mt-2">
            <label class="form-label">Address</label> <input type="text"
                                                             name="address" placeholder="Enter Address(Area and Street))"
                                                             class="form-control" value="<%=user1.getUserAddress()%>">
        </div>
        <div class="row">
            <div class="col-md-6 mt-2">
                <label class="form-label">City</label> <input class="form-control"
                                                              type="text" name="city" placeholder="City/District/Town"
                                                              value="<%=user1.getUserCity()%>">
            </div>
            <div class="col-md-6 mt-2">
                <label class="form-label">Pincode</label> <input
                    class="form-control" type="number" name="pincode"
                    placeholder="Pincode" maxlength="6"
                    value="<%=user1.getUserPinCode()%>">
            </div>
        </div>
        <div class="row mt-2">
            <label class="form-label">State</label>
            <div class="input-group mb-3">
                <input class="form-control" type="text"
                       value="<%=user1.getUserState()%>">
                <select name="state"
                        id="state-list" class="form-select">
                    <option selected>--Select State--</option>
                    <option value="Jaffna &amp; Nicobar Islands">Jaffna</option>
                    <option value="Kilinochchi">Kilinochchi</option>
                    <option value="Mannar">Mannar</option>
                    <option value="Mullaitivu">Mullaitivu</option>
                    <option value="Vavuniya">Vavuniya</option>
                    <option value="Puttalam">Puttalam</option>
                    <option value="Kurunegala">Kurunegala</option>
                    <option value="Colombo">Colombo</option>
                    <option value="Kalutara">Kalutara</option>
                    <option value="Anuradhapura">Anuradhapura</option>
                    <option value="Polonnaruwa">Polonnaruwa</option>
                    <option value="Matale">Matale</option>
                    <option value="Kandy">Kandy</option>
                    <option value="Nuwara Eliya">Nuwara Eliya</option>
                    <option value="Kegalle">Kegalle</option>
                    <option value="Ratnapura">Ratnapura</option>
                    <option value="Trincomalee">Trincomalee</option>
                    <option value="Batticaloa">Batticaloa</option>
                    <option value="Ampara">Ampara</option>
                    <option value="Badulla">Badulla</option>
                    <option value="Monaragala">Monaragala</option>
                    <option value="Hambantota">Hambantota</option>
                    <option value="Matara">Matara</option>
                    <option value="Galle">Galle</option>
                </select>
            </div>
        </div>
        <div id="submit-btn" class="container text-center mt-3">
            <button type="submit" class="btn btn-outline-primary me-3">Update</button>
            <button type="reset" class="btn btn-outline-primary">Reset</button>
        </div>
    </form>
</div>


