package lk.ecommerce.ecommerce1.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ecommerce.ecommerce1.dao.CartDao;
import lk.ecommerce.ecommerce1.dao.OrderDao;
import lk.ecommerce.ecommerce1.dao.OrderProductDao;
import lk.ecommerce.ecommerce1.dao.ProductDao;
import lk.ecommerce.ecommerce1.entities.*;
import lk.ecommerce.ecommerce1.helper.ConnectionProvider;
import lk.ecommerce.ecommerce1.helper.MailMessenger;
import lk.ecommerce.ecommerce1.helper.OrderIdGenerator;

import java.io.IOException;
import java.util.Date;
import java.util.List;

public class OrderOperationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String from = (String) session.getAttribute("from");
        String paymentType = req.getParameter("payementMode");
        User user = (User) session.getAttribute("activeUser");
        String orderId = OrderIdGenerator.getOrderId();
        String status = "Order Placed";

        if (from.trim().equals("cart")) {
            try {

                Order order = new Order(orderId, status, paymentType, user.getUserId());
                OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
                int id = orderDao.insertOrder(order);

                CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
                List<Cart> listOfCart = cartDao.getCartListByUserId(user.getUserId());
                OrderProductDao orderedProductDao = new OrderProductDao(ConnectionProvider.getConnection());
                ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
                for (Cart item : listOfCart) {

                    Product prod = productDao.getProductsByProductId(item.getProductId());
                    String prodName = prod.getProductName();
                    int prodQty = item.getQuantity();
                    float price = prod.getProductPriceAfterDiscount();
                    String image = prod.getProductImages();

                    OrderedProduct orderedProduct = new OrderedProduct(prodName, prodQty, price, image, id);
                    orderedProductDao.insertOrderedProduct(orderedProduct);
                }
                session.removeAttribute("from");
                session.removeAttribute("totalPrice");

                //removing all product from cart after successful order
                cartDao.removeAllProduct();

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (from.trim().equals("buy")) {

            try {

                int pid = (int) session.getAttribute("pid");
                Order order = new Order(orderId, status, paymentType, user.getUserId());
                OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
                int id = orderDao.insertOrder(order);
                OrderProductDao orderedProductDao = new OrderProductDao(ConnectionProvider.getConnection());
                ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());

                Product prod = productDao.getProductsByProductId(pid);
                String prodName = prod.getProductName();
                int prodQty = 1;
                float price = prod.getProductPriceAfterDiscount();
                String image = prod.getProductImages();

                OrderedProduct orderedProduct = new OrderedProduct(prodName, prodQty, price, image, id);
                orderedProductDao.insertOrderedProduct(orderedProduct);

                //updating(decreasing) quantity of product in database
                productDao.updateQuantity(pid, productDao.getProductQuantityById(pid) - 1);

                session.removeAttribute("from");
                session.removeAttribute("pid");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        session.setAttribute("order", "success");
        MailMessenger.successfullyOrderPlaced(user.getUserName(), user.getUserEmail(), orderId, new Date().toString());
        resp.sendRedirect("index.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
     doPost(req, resp);
    }
}
