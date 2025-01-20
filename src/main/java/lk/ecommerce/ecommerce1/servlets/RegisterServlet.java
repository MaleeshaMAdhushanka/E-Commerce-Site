package lk.ecommerce.ecommerce1.servlets;

import jakarta.servlet.ServletException;
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

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String userName = req.getParameter("user_name");
            String userEmail = req.getParameter("user_email");
            String userPassword = req.getParameter("user_password");
            String userPhone = req.getParameter("user_mobile_no");
            String userGender = req.getParameter("gender");
            String userAddress = req.getParameter("user_address");
            String userCity = req.getParameter("city");
            String userPincode = req.getParameter("pincode");
            String userState = req.getParameter("state");

            User user = new User(userName, userEmail, userPassword, userPhone, userGender, userAddress, userCity, userPincode, userState);
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
            return;

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
