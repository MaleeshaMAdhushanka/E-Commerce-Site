<%--
  Created by IntelliJ IDEA.
  User: ZeejMaleesha
  Date: 1/20/2025
  Time: 11:57 AM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="lk.ecommerce.ecommerce1.entities.Admin" %>
<%@page import="lk.ecommerce.ecommerce1.dao.CartDao" %>
<%@page import="lk.ecommerce.ecommerce1.entities.User" %>
<%@page import="java.util.List" %>
<%@page import="lk.ecommerce.ecommerce1.entities.Category" %>
<%@page import="lk.ecommerce.ecommerce1.helper.ConnectionProvider" %>
<%@page import="lk.ecommerce.ecommerce1.dao.CategoryDao" %>

<link rel="stylesheet" type="text/css" href="Css/style.css">

<%
    User user = (User) session.getAttribute("activeUser");
    Admin admin = (Admin)  session.getAttribute("activeAdmin");
    int cartCount = 0;

    CategoryDao catDao = new CategoryDao(ConnectionProvider.getConnection());
    List<Category> categoryList = catDao.getAllCategories();
%>
<nav class="navbar navbar-expand-lg custom-color" data-bs-theme="dark">

    <!-- admin nav bar -->
    <%
        if (admin != null) {
    %>
    <div class="container">
        <a class="navbar-brand" href="admin.jsp"><i
                class="fa-sharp fa-solid fa-house" style="color: #ffffff;"></i>&ensp;ZeeMart</a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContentAdmin"
                aria-controls="navbarSupportedContentAdmin" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContentAdmin">

            <div class="container text-end">
                <ul class="navbar-nav justify-content-end">
                    <li class="nav-item"><button type="button"
                                                 class="btn nav-link" data-bs-toggle="modal"
                                                 data-bs-target="#add-category"><i class="fa-solid fa-plus fa-xs"></i>Add Category</button></li>
                    <li class="nav-item"><button type="button"
                                                 class="btn nav-link" data-bs-toggle="modal"
                                                 data-bs-target="#add-product"><i class="fa-solid fa-plus fa-xs"></i>Add Product</button></li>
                    <li class="nav-item"><a class="nav-link" aria-current="page"
                                            href="admin.jsp"><%=admin.getName()%></a></li>
                    <li class="nav-item"><a class="nav-link" aria-current="page"
                                            href="LogoutServlet?user=admin"><i
                            class="fa-solid fa-user-slash fa-sm" style="color: #fafafa;"></i>&nbsp;Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
    <%
    } else {
    %>

    <!-- end -->

    <!-- for all -->
    <div class="container">
        <a class="navbar-brand" href="index.jsp"><i
                class="fa-sharp fa-solid fa-house" style="color: #ffffff;"></i>&ensp;ZeeMart</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContentUser"
                aria-controls="navbarSupportedContentUser" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContentUser">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="products.jsp"
                                        role="button" aria-expanded="false"> Products </a>
                <li class="nav-item dropdown"><a
                        class="nav-link dropdown-toggle" href="#" role="button"
                        data-bs-toggle="dropdown" aria-expanded="false"> Category </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="products.jsp?category=0">All
                            Products</a></li>
                        <%
                            for (Category c : categoryList) {
                        %>
                        <li><a class="dropdown-item"
                               href="products.jsp?category=<%=c.getCategoryId()%>"><%=c.getCategoryName()%></a></li>
                        <%
                            }
                        %>
                    </ul></li>
            </ul>
            <form class="d-flex pe-5" role="search" action="products.jsp"
                  method="get">
                <input name="search" class="form-control me-2" size="50"
                       type="search" placeholder="Search for products" aria-label="Search"
                       style="background-color: white !important;">
                <button class="btn btn-outline-light" type="submit">Search</button>
            </form>

            <!-- when user is logged in -->
            <%
                if (user != null) {
                    CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
                    cartCount = cartDao.getCartCountByUserId(user.getUserId());
            %>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active pe-3"><a
                        class="nav-link position-relative" aria-current="page"
                        href="cart.jsp"><i class="fa-solid fa-cart-shopping"
                                           style="color: #ffffff;"></i> &nbsp;Cart<span
                        class="position-absolute top-1 start-0 translate-middle badge rounded-pill bg-danger"><%=cartCount%></span></a></li>
                <li class="nav-item active pe-3"><a class="nav-link"
                                                    aria-current="page" href="profile.jsp"><%=user.getUserName()%></a></li>
                <li class="nav-item pe-3"><a class="nav-link"
                                             aria-current="page" href="LogoutServlet?user=user"><i
                        class="fa-solid fa-user-slash" style="color: #fafafa;"></i>&nbsp;Logout</a></li>
            </ul>
            <%
            } else {
            %>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active pe-2"><a class="nav-link"
                                                    aria-current="page" href="register.jsp"> <i
                        class="fa-solid fa-user-plus" style="color: #ffffff;"></i>&nbsp;Register
                </a></li>
                <li class="nav-item pe-2"><a class="nav-link"
                                             aria-current="page" href="login.jsp"><i
                        class="fa-solid fa-user-lock" style="color: #fafafa;"></i>&nbsp;Login</a></li>
                <li class="nav-item pe-2"><a class="nav-link"
                                             aria-current="page" href="adminlogin.jsp">&nbsp;Admin</a></li>
            </ul>

        </div>
    </div>
    <%
            }
        }
    %>
    <!-- end  -->
</nav>