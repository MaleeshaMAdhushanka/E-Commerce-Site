package lk.ecommerce.ecommerce1.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ecommerce.ecommerce1.entities.Message;

import java.io.IOException;

public class LogoutServlet extends HttpServlet {

    private static  final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String user = req.getParameter("user");
        HttpSession session = req.getSession();
        if(user.trim().equals("user")) {
            session.removeAttribute("activeUser");
            Message message = new Message("Logout successfully!!", "success", "alert-success");
            session.setAttribute("message", message);
            resp.sendRedirect("login.jsp");
        }else if(user.trim().equals("admin")) {
            session.removeAttribute("activeAdmin");
            Message message = new Message("Logout successfully!!", "success", "alert-success");
            session.setAttribute("message", message);
            resp.sendRedirect("adminlogin.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
