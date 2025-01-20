package lk.ecommerce.ecommerce1.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ecommerce.ecommerce1.dao.WishlistDao;
import lk.ecommerce.ecommerce1.entities.Wishlist;
import lk.ecommerce.ecommerce1.helper.ConnectionProvider;

import java.io.IOException;

public class WishlistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int uid = Integer.parseInt(req.getParameter("uid"));
        int pid = Integer.parseInt(req.getParameter("pid"));
        String op = req.getParameter("op");

        WishlistDao wishlistDao = new WishlistDao(ConnectionProvider.getConnection());
        if (op.trim().equals("add")) {
            Wishlist wishlist = new Wishlist(uid, pid);
            wishlistDao.addToWishlist(wishlist);
            resp.sendRedirect("products.jsp");
        } else if (op.trim().equals("remove")) {
            wishlistDao.deleteWishlist(uid, pid);
            resp.sendRedirect("products.jsp");
        }else if(op.trim().equals("delete")) {
            wishlistDao.deleteWishlist(uid, pid);
            resp.sendRedirect("profile.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
