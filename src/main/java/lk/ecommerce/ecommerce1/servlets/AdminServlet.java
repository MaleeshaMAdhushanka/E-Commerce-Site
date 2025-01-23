package lk.ecommerce.ecommerce1.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ecommerce.ecommerce1.dao.AdminDao;
import lk.ecommerce.ecommerce1.entities.Admin;
import lk.ecommerce.ecommerce1.entities.Message;
import lk.ecommerce.ecommerce1.helper.ConnectionProvider;

import java.io.IOException;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String operation = req.getParameter("operation");
        AdminDao adminDao = new AdminDao(ConnectionProvider.getConnection());
        HttpSession session = req.getSession();
        Message message = null;

        if(operation.trim().equals("save")) {

            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String phone = req.getParameter("phone");

            Admin admin = new Admin(name, email, phone, password);

            boolean flag = adminDao.saveAdmin(admin);

            if(flag) {
                message = new Message("New admin register successfully!", "success", "alert-success");
            }else {
                message = new Message("Sorry! Something went wrong", "error", "alert-danger");
            }

        }else if(operation.trim().equals("delete")) {

            int id = Integer.parseInt(req.getParameter("id"));
            boolean flag = adminDao.deleteAdmin(id);
            if(flag) {
                message = new Message("Admin deleted successfully!", "success", "alert-success");
            }else {
                message = new Message("Sorry! Something went wrong", "error", "alert-danger");
            }
        }
        session.setAttribute("message", message);
        resp.sendRedirect("display_admin.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
