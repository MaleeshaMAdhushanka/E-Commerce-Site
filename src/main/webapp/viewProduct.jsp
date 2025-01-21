<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/20/2025
  Time: 9:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="lk.ecommerce.ecommerce1.dao.WishlistDao"%>
<%@page import="lk.ecommerce.ecommerce1.dao.ProductDao"%>
<%@page import="lk.ecommerce.ecommerce1.entities.Product"%>
<%@ page import="lk.ecommerce.ecommerce1.helper.ConnectionProvider" %>
<%@page errorPage="error_exception.jsp" %>
<%
    int productId = Integer.parseInt(request.getParameter("pid"));
    ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
    Product product = (Product) productDao.getProductsByProductId(productId);
%>

<html>
<head>
    <title>View Product</title>
    <%@include file="Components/common_css_js.jsp"%>
    <style type="text/css">
        .real-price {
            font-size: 26px !important;
            font-weight: 600;
        }

        .product-price {
            font-size: 18px !important;
            text-decoration: line-through;
        }

        .product-discount {
            font-size: 16px !important;
            color: #027a3e;
        }
    </style>

</head>
<body>
<!--navbar -->
<%@include file="Components/navbar.jsp"%>

<div class="container mt-5">
    <%@include file="Components/alert_message.jsp"%>
    <div class="row border border-3">
        <div class="col-md-6">
            <div class="container-fluid text-end my-3">
                <img src="Product_imgs\<%=product.getProductImages()%>"
                     class="card-img-top"
                     style="max-width: 100%; max-height: 500px; width: auto;">
            </div>
        </div>
        <div class="col-md-6">
            <div class="container-fluid my-5">
                <h4><%=product.getProductName()%></h4>
                <span class="fs-5"><b>Description</b></span><br> <span><%=product.getProductDescription()%></span><br>
                <span class="real-price">&#8377;<%=product.getProductPriceAfterDiscount()%></span>&ensp;
                <span class="product-price">&#8377;<%=product.getProductPrice()%></span>&ensp;
                <span class="product-discount"><%=product.getProductDiscount()%>&#37;off</span><br>
                <span class="fs-5"><b>Status : </b></span> <span id="availability">
						<%
                            if (product.getProductQuantity() > 0) {
                                System.out.println("Available");
                            } else {
                               System.out.println("Currently Out of stock");
                            }
                        %>
					</span><br> <span class="fs-5"><b>Category : </b></span> <span><%=catDao.getCategoryName(product.getCategoryId())%></span>
                <form method="post">
                    <div class="container-fluid text-center mt-3">
                        <%
                            if (user == null) {
                        %>
                        <button type="button" onclick="window.open('login.jsp', '_self')"
                                class="btn btn-primary text-white btn-lg">Add to Cart</button>
                        &emsp;
                        <button type="button" onclick="window.open('login.jsp', '_self')"
                                class="btn btn-info text-white btn-lg">Buy Now</button>
                        <%
                        } else {
                        %>
                        <button type="submit"
                                formaction="./AddToCartServlet?uid=<%=user.getUserId()%>&pid=<%=product.getProductId()%>"
                                class="btn btn-primary text-white btn-lg">Add to Cart</button>
                        &emsp; <a
                            href="checkout.jsp" id="buy-btn"
                            class="btn btn-info text-white btn-lg" role="button"
                            aria-disabled="true">Buy Now</a>
                        <%
                            }
                        %>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        if ($('#availability').text().trim() == "Currently Out of stock") {
            $('#availability').css('color', 'red');
            $('.btn').addClass('disabled');
        }
        $('#buy-btn').click(function(){
            <%
            session.setAttribute("pid", productId);
            session.setAttribute("from", "buy");
            %>
        });
    });
</script>

</body>
</html>
