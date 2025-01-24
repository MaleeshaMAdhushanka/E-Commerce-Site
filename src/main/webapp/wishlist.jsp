<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/20/2025
  Time: 9:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="lk.ecommerce.ecommerce1.entities.Message" %>
<%@page import="lk.ecommerce.ecommerce1.entities.Product" %>
<%@page import="lk.ecommerce.ecommerce1.dao.ProductDao" %>
<%@page import="lk.ecommerce.ecommerce1.entities.Wishlist" %>
<%@page import="java.util.List" %>
<%@page errorPage="error_exception.jsp" %>
<%@page import="lk.ecommerce.ecommerce1.entities.User" %>
<%@page import="lk.ecommerce.ecommerce1.helper.ConnectionProvider" %>
<%@ page import="lk.ecommerce.ecommerce1.dao.WishlistDao" %>
<%
    User u1 = (User) session.getAttribute("activeUser");
    if (u1 == null) {
        Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
        session.setAttribute("message", message);
        response.sendRedirect("login.jsp");
        return;
    }
    WishlistDao wishListDao = new WishlistDao(ConnectionProvider.getConnection());
    List<Wishlist> wlist = wishListDao.getListByUserId(u1.getUserId());
    ProductDao pDao = new ProductDao(ConnectionProvider.getConnection());
%>
<div class="container px-3 py-3">
    <%
        if (wlist == null || wlist.size() == 0) {
    %>
    <div class="container mt-5 mb-5 text-center">
        <img src="Images/wishlist.png" style="max-width: 200px;"
             class="img-fluid">
        <h4 class="mt-3">Empty Wishlist</h4>
        You have no items in your wishlist. Start adding!
    </div>
    <%
    } else {
    %>
    <h4>
        My Wishlist (<%=wlist.size()%>)
    </h4>
    <hr>
    <div class="container">
        <table class="table table-hover">
            <%
                for (Wishlist w : wlist) {
                    Product p = pDao.getProductsByProductId(w.getProductId());
            %>
            <tr class="text-center">
                <td><img src="Images/<%=p.getProductImages()%>"
                         style="width: 50px; height: 50px; width: auto;"></td>
                <td class="text-start"><%=p.getProductName()%></td>
                <td>&#36;<%=p.getProductPriceAfterDiscount()%></td>
                <td><a
                        href="WishlistServlet?uid=<%=u1.getUserId()%>&pid=<%=p.getProductId()%>&op=delete"
                        class="btn btn-secondary" role="button">Remove</a></td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
    <%
        }
    %>
</div>

