<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%--<div class="container text-center mt-5">--%>
<%--    <h1>Welcome to Our E-commerce Platform</h1>--%>
<%--    <a href="login.jsp" class="btn btn-primary">Login</a>--%>
<%--    <a href="register.jsp" class="btn btn-secondary">Register</a>--%>
<%--</div>--%>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">E-Commerce</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="home.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="product_list.jsp">Products</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="cart.jsp">Cart</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register.jsp">Register</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<div class="hero-section text-center bg-light py-5">
    <div class="container">
        <h1 class="display-4">Welcome to Our E-Commerce Platform</h1>
        <p class="lead">Discover the best products at unbeatable prices!</p>
        <a href="product_list.jsp" class="btn btn-primary btn-lg">Shop Now</a>
    </div>
</div>

<!-- Featured Products Section -->
<div class="container mt-5">
    <h2 class="text-center">Featured Products</h2>
    <div class="row">
        <!-- Example Product Card -->
        <div class="col-md-4">
            <div class="card">
                <img src="images/sample-product.jpg" class="card-img-top" alt="Product">
                <div class="card-body">
                    <h5 class="card-title">Product Name</h5>
                    <p class="card-text">$99.99</p>
                    <a href="product_details.jsp" class="btn btn-primary">View Details</a>
                </div>
            </div>
        </div>
        <!-- Repeat product cards as needed -->
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-light text-center py-3 mt-5">
    <p>&copy; 2025 E-Commerce. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>