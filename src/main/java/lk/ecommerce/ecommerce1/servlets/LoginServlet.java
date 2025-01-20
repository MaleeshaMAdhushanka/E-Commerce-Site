package lk.ecommerce.ecommerce1.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ecommerce.ecommerce1.dao.AdminDao;
import lk.ecommerce.ecommerce1.dao.UserDao;
import lk.ecommerce.ecommerce1.entities.Admin;
import lk.ecommerce.ecommerce1.entities.Message;
import lk.ecommerce.ecommerce1.entities.User;
import lk.ecommerce.ecommerce1.helper.ConnectionProvider;

import java.io.IOException;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String login = req.getParameter("login");
        if (login.trim().equals("user")) {
            try {
                String userEmail = req.getParameter("user_email");
                String userPassword = req.getParameter("user_password");

                // getting user through entered email and passsword
                UserDao userDao = new UserDao(ConnectionProvider.getConnection());
                User user = userDao.getUserByEmailPassword(userEmail, userPassword);

                // storing current user in session
                HttpSession session = req.getSession();
                if (user != null) {
                    session.setAttribute("activeUser", user);
                    resp.sendRedirect("index.jsp");
                } else {
                    Message message = new Message("Invalid details! Try again!!", "error", "alert-danger");
                    session.setAttribute("message", message);
                    resp.sendRedirect("login.jsp");
                    return;
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (login.trim().equals("admin")) {
            try {
                String userName = req.getParameter("email");
                String password = req.getParameter("password");

                AdminDao adminDao = new AdminDao(ConnectionProvider.getConnection());
                Admin admin = adminDao.getAdminByEmailPassword(userName, password);

                HttpSession session = req.getSession();
                if (admin != null) {
                    session.setAttribute("activeAdmin", admin);
                    resp.sendRedirect("admin.jsp");
                } else {
                    Message message = new Message("Invalid details! Try again!!", "error", "alert-danger");
                    session.setAttribute("message", message);
                    resp.sendRedirect("adminlogin.jsp");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
