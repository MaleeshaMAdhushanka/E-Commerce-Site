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

import java.io.IOException;

@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String op = req.getParameter("operation");
        HttpSession session = req.getSession();
        User oldUser = (User) session.getAttribute("activeUser");
        UserDao userDao = new UserDao(ConnectionProvider.getConnection());

        if (op.trim().equals("changeAddress")) {
            try {
                String userAddress = req.getParameter("user_address");
                String userCity = req.getParameter("city");
                String userPincode = req.getParameter("pincode");
                String userState = req.getParameter("state");

                User user = new User();
                user.setUserId(oldUser.getUserId());
                user.setUserName(oldUser.getUserName());
                user.setUserEmail(oldUser.getUserEmail());
                user.setUserPassword(oldUser.getUserPassword());
                user.setUserPhone(oldUser.getUserPhone());
                user.setUserGender(oldUser.getUserGender());
                user.setDateTime(oldUser.getDateTime());
                user.setUserAddress(userAddress);
                user.setUserCity(userCity);
                user.setUserPinCode(userPincode);
                user.setUserState(userState);

                userDao.updateUserAddresss(user);
                session.setAttribute("activeUser", user);
                resp.sendRedirect("checkout.jsp");

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (op.trim().equals("updateUser")) {
            try {
                String userName = req.getParameter("name");
                String userEmail = req.getParameter("email");
                String userPhone = req.getParameter("mobile_no");
                String userGender = req.getParameter("gender");
                String userAddress = req.getParameter("address");
                String userCity = req.getParameter("city");
                String userPincode = req.getParameter("pincode");
                String userState = req.getParameter("state");

                User user = new User(userName, userEmail, userPhone, userGender, userAddress, userCity, userPincode,
                        userState);
                user.setUserId(oldUser.getUserId());
                user.setUserPassword(oldUser.getUserPassword());
                user.setDateTime(oldUser.getDateTime());

                userDao.updateUser(user);
                session.setAttribute("activeUser", user);
                Message message = new Message("User information updated successfully!!", "success", "alert-success");
                session.setAttribute("message", message);
                resp.sendRedirect("profile.jsp");

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (op.trim().equals("deleteUser")) {
            int uid = Integer.parseInt(req.getParameter("uid"));
            userDao.deleteUser(uid);
            resp.sendRedirect("display_users.jsp");
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
