<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/20/2025
  Time: 9:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="lk.ecommerce.ecommerce1.entities.Message" %>
<%@page import="lk.ecommerce.ecommerce1.entities.Product" %>
<%@page import="lk.ecommerce.ecommerce1.dao.ProductDao" %>
<%@page import="lk.ecommerce.ecommerce1.entities.Cart" %>
<%@page import="lk.ecommerce.ecommerce1.dao.CartDao" %>
<%@ page import="lk.ecommerce.ecommerce1.entities.User" %>
<%@page errorPage="error_exception.jsp" %>

<%
  User activeUser = (User) session.getAttribute("activeUser");
  if (activeUser == null) {
    Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
    session.setAttribute("message", message);
    response.sendRedirect("login.jsp");
    return;
  }
%>



<html>
  <head>
    <title>Shopping Cart</title>
    <%@include file="Components/common_css_js.jsp"%>
    <style type="text/css">
      .qty {
        display: inline-block;
        padding: 3px 6px;
        width: 46px;
        height: 32px;
        border-radius: 2px;
        background-color: #fff;
        border: 1px solid #c2c2c2;
        margin: 0 5px;
      }


    </style>
  </head>
  <body>
  <!--navbar -->
  <%@include file="Components/navbar.jsp"%>

  <%
    float totalPrice = 0;
    CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
    List<Cart> listOfCart = cartDao.getCartListByUserId(user.getUserId());
    if (listOfCart == null || listOfCart.size() == 0) {
  %>
  <div class="container text-center py-5 px-5">
    <img src="Images/empty-cart.png" style="max-width: 250px;"
         class="img-fluid">
    <h4 class="mt-5">Your cart is empty!</h4>
    <p>Add items to it now.</p>
    <a href="products.jsp" class="btn btn-primary btn-lg" role="button"
       aria-disabled="true">Shop Now</a>
  </div>
  <%
  } else {
  %>

  <div class="container mt-5">
    <%@include file="Components/alert_message.jsp"%>
    <div class="card px-3 py-3">
      <table class="table table-hover">
        <thead>
        <tr class="table-primary text-center" style="font-size: 18px;">
          <th>Item</th>
          <th>Item Name</th>
          <th>Price</th>
          <th>Quantity</th>
          <th>Total price</th>
          <th>Remove</th>
        </tr>
        </thead>
        <tbody>
        <%
          ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
          for (Cart c : listOfCart) {
            Product prod = productDao.getProductsByProductId(c.getProductId());
        %>
        <tr class="text-center">
          <td><img src="Images/<%=prod.getProductImages()%>"
                   style="width: 50px; height: 50px; width: auto;"></td>
          <td class="text-start"><%=prod.getProductName()%></td>
          <td>&#36;<%=prod.getProductPriceAfterDiscount()%></td>
          <td><a
                  href="CartOperationServlet?cid=<%=c.getCartId()%>&opt=1"
                  role="button" class="btn btn-light"
                  style="border-radius: 50%; font-size: 8px;"> <i
                  class="fa-regular fa-plus fa-2xl"></i>
          </a>
            <div class="qty"><%=c.getQuantity()%></div>
            <%if(c.getQuantity() > 1){ %>
            <a href="CartOperationServlet?cid=<%=c.getCartId()%>&opt=2"
               role="button" class="btn btn-light" id="qtyDesc"
               style="border-radius: 50%; font-size: 8px;"> <i
                    class="fa-solid fa-minus fa-2xl"></i></a>
            <%}else{ %>
            <a href="CartOperationServlet?cid=<%=c.getCartId()%>&opt=2"
               role="button" class="btn btn-light disabled" id="qtyDesc"
               style="border-radius: 50%; font-size: 8px;"> <i
                    class="fa-solid fa-minus fa-2xl"></i></a>
            <%} %>
          </td>

          <td>&#36;<%=c.getQuantity() * prod.getProductPriceAfterDiscount()%></td>
          <td><a
                  href="CartOperationServlet?cid=<%=c.getCartId()%>&opt=3"
                  class="btn btn-secondary" role="button">Remove</a></td>
        </tr>
        <%
            totalPrice += c.getQuantity() * prod.getProductPriceAfterDiscount();
          }
        %>
        <tr>
          <td class="text-end" colspan="8"><h4 class='pe-5'>
            Total Amount : &#36;
            <%=totalPrice%></h4></td>
        </tr>
        </tbody>
      </table>
      <div class="text-end">
        <a href="products.jsp" class="btn btn-outline-primary" role="button"
           aria-disabled="true">Continue Shopping</a>&nbsp;
        <a href="checkout.jsp" id="checkout-btn"
           class="btn btn-outline-primary" role="button" aria-disabled="true">Checkout</a>
      </div>

    </div>
  </div>
  <%
    }
  %>
  <script>
    $(document).ready(function(){
      $('#checkout-btn').click(function(){
        <%
        session.setAttribute("totalPrice", totalPrice);
        session.setAttribute("from", "cart");
        %>
      });
    });
  </script>


  </body>
</html>
