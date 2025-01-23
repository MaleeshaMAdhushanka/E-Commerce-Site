package lk.ecommerce.ecommerce1.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ecommerce.ecommerce1.dao.UserDao;
import lk.ecommerce.ecommerce1.entities.Message;
import lk.ecommerce.ecommerce1.helper.ConnectionProvider;
import lk.ecommerce.ecommerce1.helper.MailMessenger;

import java.io.IOException;
import java.util.List;
import java.util.Random;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String referrer = req.getHeader("referer");
        UserDao userDao = new UserDao(ConnectionProvider.getConnection());
        HttpSession session = req.getSession();

        if(referrer.contains("forgot_password")) {
            String email = req.getParameter("email").trim();
            List<String> list = userDao.getAllEmail();
            if(list.contains(email)) {
                Random rand = new Random();
                int max = 99999, min = 10000;
                int otp = rand.nextInt(max - min + 1) + min;
                //System.out.println(otp);
                session.setAttribute("otp", otp);
                session.setAttribute("email", email);
                MailMessenger.sendOtp(email, otp);

                Message message = new Message("We'ev sent a password reset code to "+email, "success", "alert-success");
                session.setAttribute("message", message);
                resp.sendRedirect("otp_code.jsp");
            }else {
                Message message = new Message("Email not found! Try with another email!", "error", "alert-danger");
                session.setAttribute("message", message);
                resp.sendRedirect("forgot_password.jsp");
                return;
            }
        }else if(referrer.contains("otp_code")) {
            int code = Integer.parseInt(req.getParameter("code"));
            int otp = (int)session.getAttribute("otp");
            if(code == otp) {
                session.removeAttribute("otp");
                resp.sendRedirect("change_password.jsp");
            }else {
                Message message = new Message("Invalid verification code entered!", "error", "alert-danger");
                session.setAttribute("message", message);
                resp.sendRedirect("otp_code.jsp");
                return;
            }
        }else if(referrer.contains("change_password")) {
            String password = req.getParameter("password");
            String email =(String)session.getAttribute("email");
            userDao.updateUserPasswordByEmail(password, email);
            session.removeAttribute("email");

            Message message = new Message("Password updated successfully!", "error", "alert-success");
            session.setAttribute("message", message);
            resp.sendRedirect("login.jsp");
        }
    }

}
