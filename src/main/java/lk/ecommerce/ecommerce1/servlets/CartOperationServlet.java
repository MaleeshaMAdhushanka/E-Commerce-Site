package lk.ecommerce.ecommerce1.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ecommerce.ecommerce1.dao.CartDao;
import lk.ecommerce.ecommerce1.dao.ProductDao;
import lk.ecommerce.ecommerce1.entities.Message;
import lk.ecommerce.ecommerce1.helper.ConnectionProvider;

import java.io.IOException;

@WebServlet("/CartOperationServlet")
public class CartOperationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
        ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
        int cid =Integer.parseInt(req.getParameter("cid"));
        int opt =Integer.parseInt(req.getParameter("opt"));

        int qty = cartDao.getQuantityById(cid);
        int pid = cartDao.getProductId(cid);
        int quantity = productDao.getProductQuantityById(pid);

        if(opt == 1) {
            if(quantity > 0) {
                cartDao.updateQuantity(cid, qty+1);
                //updating(decreasing) quantity of product in database
                productDao.updateQuantity(pid, productDao.getProductQuantityById(pid) - 1);
                resp.sendRedirect("cart.jsp");

            }else {
                HttpSession session = req.getSession();
                Message message = new Message("Product out of stock!", "error", "alert-danger");
                session.setAttribute("message", message);
                resp.sendRedirect("cart.jsp");
            }

        }else if(opt == 2) {
            cartDao.updateQuantity(cid, qty-1);

            //updating(increasing) quantity of product in database
            productDao.updateQuantity(pid, productDao.getProductQuantityById(pid) + 1);
            resp.sendRedirect("cart.jsp");

        }else if(opt == 3) {
            cartDao.removeProduct(cid);
            HttpSession session = req.getSession();
            Message message = new Message("Product removed from cart!", "success", "alert-success");
            session.setAttribute("message", message);

            //updating quantity of product in database
            //adding all the product qty back to database
            productDao.updateQuantity(pid, productDao.getProductQuantityById(pid) + qty);
            resp.sendRedirect("cart.jsp");
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
