<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/20/2025
  Time: 9:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="lk.ecommerce.ecommerce1.entities.Message" %>
<%@page import="lk.ecommerce.ecommerce1.dao.ProductDao" %>
<%@page import="lk.ecommerce.ecommerce1.dao.CartDao" %>
<%@ page import="lk.ecommerce.ecommerce1.entities.User" %>
<%@page errorPage="error_exception.jsp"%>
<%
    User activeUser = (User) session.getAttribute("activeUser");
    if (activeUser == null) {
        Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
        session.setAttribute("message", message);
        response.sendRedirect("login.jsp");
        return;
    }
    String from = (String)session.getAttribute("from");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
    <%@include file="Components/common_css_js.jsp"%>

</head>
<body>
<!--navbar -->
<%@include file="Components/navbar.jsp"%>

<div class="container mt-5" style="font-size: 17px;">
    <div class="row">

        <!-- left column -->
        <div class="col-md-8">
            <div class="card">
                <div class="container px-3 py-3">
                    <div class="card">
                        <div class="container-fluid text-white"
                             style="background-color: #389aeb;">
                            <h4>Delivery Address</h4>
                        </div>
                    </div>
                    <div class="mt-3 mb-3">
                        <h5><%=user.getUserName()%>
                            &nbsp;
                        <%
                            StringBuilder str = new StringBuilder();
                        %>
                        <br>
                        <div class="text-end">
                            <button type="button" class="btn btn-outline-primary"
                                    data-bs-toggle="modal" data-bs-target="#exampleModal">
                                Change Address</button>
                        </div>
                    </div>
                    <hr>
                    <div class="card">
                        <div class="container-fluid text-white"
                             style="background-color: #389aeb;">
                            <h4>Payment Options</h4>
                        </div>
                    </div>
                    <form action="OrderOperationServlet" method="post">
                        <div class="form-check mt-2">
                            <input class="form-check-input" type="radio" name="payementMode"
                                   value="Card Payment" required><label class="form-check-label">Credit
                            /Debit /ATM card</label><br>
                            <div class="mb-3">

                                <input class="form-control mt-3" type="number"
                                       placeholder="Enter card number" name="cardno">
                                <div class="row gx-5">
                                    <div class="col mt-3">
                                        <input class="form-control" type="number"
                                               placeholder="Enter CVV" name="cvv">
                                    </div>
                                    <div class="col mt-3">
                                        <input class="form-control" type="text"
                                               placeholder="Valid through i.e '07/23'">
                                    </div>
                                </div>
                                <input class="form-control mt-3" type="text"
                                       placeholder="Enter card holder name" name="name">
                            </div>
                            <input class="form-check-input" type="radio" name="payementMode"
                                   value="Cash on Delivery"><label
                                class="form-check-label">Cash on Delivery</label>
                        </div>
                        <div class="text-end">
                            <button type="submit"
                                    class="btn btn-lg btn-outline-primary mt-3">Place
                                Order</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- end of column -->

        <!-- right column -->
        <div class="col-md-4">
            <div class="card">
                <div class="container px-3 py-3">
                    <h4>Price Details</h4>
                    <hr>
                    <%
                        if (from.trim().equals("cart")) {
                            CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
                            int totalProduct = cartDao.getCartCountByUserId(user.getUserId());
                            float totalPrice = (float) session.getAttribute("totalPrice");
                    %>
                    <table class="table table-borderless">
                        <tr>
                            <td>Total Item</td>
                            <td><%=totalProduct%></td>
                        </tr>
                        <tr>
                            <td>Total Price</td>
                            <td>&#36; <%=totalPrice%></td>
                        </tr>
                        <tr>
                            <td>Delivery Charges</td>
                            <td>&#36; 40</td>
                        </tr>
                        <tr>
                            <td>Packaging Charges</td>
                            <td>&#36; 29</td>
                        </tr>
                        <tr>
                            <td><h5>Amount Payable :</h5></td>
                            <td><h5>
                                &#36;
                                <%=totalPrice + 69%></h5></td>
                        </tr>
                    </table>
                    <%
                    } else {
                        ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
                        int pid = (int) session.getAttribute("pid");
                        float price = productDao.getProductPriceById(pid);
                    %>
                    <table class="table table-borderless">
                        <tr>
                            <td>Total Item</td>
                            <td>1</td>
                        </tr>
                        <tr>
                            <td>Total Price</td>
                            <td>&#36; <%=price%></td>
                        </tr>
                        <tr>
                            <td>Delivery Charges</td>
                            <td>&#36; 40</td>
                        </tr>
                        <tr>
                            <td>Packaging Charges</td>
                            <td>&#36; 29</td>
                        </tr>
                        <tr>
                            <td><h5>Amount Payable :</h5></td>
                            <td><h5>
                                &#36;
                                <%=price + 69%></h5></td>
                        </tr>
                    </table>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
        <!-- end of column -->
    </div>
</div>


<!--Change Address Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Change
                    Address</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <form action="UpdateUserServlet" method="post">
                <input type="hidden" name="operation" value="changeAddress">
                <div class="modal-body mx-3">
                    <div class="mt-2">
                        <label class="form-label fw-bold">Address</label>
                        <textarea name="user_address" rows="3"
                                  placeholder="Enter Address(Area and Street))"
                                  class="form-control" required></textarea>
                    </div>
                    <div class="mt-2">
                        <label class="form-label fw-bold">City</label> <input
                            class="form-control" type="text" name="city"
                            placeholder="City/District/Town" required>
                    </div>
                    <div class="mt-2">
                        <label class="form-label fw-bold">Pincode</label> <input
                            class="form-control" type="number" name="pincode"
                            placeholder="Pincode" maxlength="6" required>
                    </div>
                    <div class="mt-2">
                        <label class="form-label fw-bold">State</label>

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
                        </select>I
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- end modal -->

</body>
</html>
