package lk.ecommerce.ecommerce1.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ecommerce.ecommerce1.dao.OrderDao;
import lk.ecommerce.ecommerce1.dao.UserDao;
import lk.ecommerce.ecommerce1.entities.Order;
import lk.ecommerce.ecommerce1.helper.ConnectionProvider;
import lk.ecommerce.ecommerce1.helper.MailMessenger;

import java.io.IOException;

public class UpdateOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int oid = Integer.parseInt(req.getParameter("oid"));
        String status = req.getParameter("status");
        OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
        orderDao.updateOrderStatus(oid, status);
        if (status.trim().equals("Shipped") || status.trim().equals("Out For Delivery")) {
            Order order = orderDao.getOrderById(oid);
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());
            MailMessenger.orderShipped(userDao.getUserName(order.getUserId()), userDao.getUserEmail(order.getUserId()),
                    order.getOrderId(), order.getDate().toString());
        }
        resp.sendRedirect("display_orders.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
