package lk.ecommerce.ecommerce1.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ecommerce.ecommerce1.dao.UserDao;
import lk.ecommerce.ecommerce1.entities.Message;
import lk.ecommerce.ecommerce1.entities.User;
import lk.ecommerce.ecommerce1.helper.ConnectionProvider;
import lk.ecommerce.ecommerce1.helper.MailMessenger;

import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String userName = req.getParameter("user_name");
            String userEmail = req.getParameter("user_email");
            String userPassword = req.getParameter("user_password");

            User user = new User(userName, userEmail, userPassword);
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());
            boolean flag = userDao.saveUser(user);

            HttpSession session = req.getSession();
            Message message;
            if (flag) {
                message = new Message("Registration Successful !!", "success", "alert-success");
                MailMessenger.successfullyRegister(userName, userEmail);
            } else {
                message = new Message("Something went wrong! Try again!!", "error", "alert-danger");
            }
            session.setAttribute("message", message);
            resp.sendRedirect("register.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
