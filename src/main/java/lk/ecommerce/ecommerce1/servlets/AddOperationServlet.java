package lk.ecommerce.ecommerce1.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.ecommerce.ecommerce1.dao.CategoryDao;
import lk.ecommerce.ecommerce1.dao.ProductDao;
import lk.ecommerce.ecommerce1.entities.Category;
import lk.ecommerce.ecommerce1.entities.Message;
import lk.ecommerce.ecommerce1.entities.Product;
import lk.ecommerce.ecommerce1.helper.ConnectionProvider;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

@WebServlet("/AddOperationServlet")
public class AddOperationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String operation = req.getParameter("operation");
        CategoryDao catDao = new CategoryDao(ConnectionProvider.getConnection());
        ProductDao pdao = new ProductDao(ConnectionProvider.getConnection());
        HttpSession session = req.getSession();
        Message message = null;

        if (operation.trim().equals("addCategory")) {

            String categoryName = req.getParameter("category_name");
            Part part = req.getPart("category_img");
            Category category = new Category(categoryName, part.getSubmittedFileName());
            boolean flag = catDao.saveCategory(category);

            String path = req.getServletContext().getRealPath("/") + "Product_imgs" + File.separator
                    + part.getSubmittedFileName();

            try {
                FileOutputStream fos = new FileOutputStream(path);
                InputStream is = part.getInputStream();
                byte[] data = new byte[is.available()];
                is.read(data);
                fos.write(data);
                fos.flush();
                fos.close();

            } catch (Exception e) {
                e.printStackTrace();
            }

            if (flag) {
                message = new Message("Category added successfully!!", "success", "alert-success");
            } else {
                message = new Message("Something went wrong! Try again!!", "error", "alert-danger");
            }
            session.setAttribute("message", message);
            resp.sendRedirect("admin.jsp");

        } else if (operation.trim().equals("addProduct")) {

            // add product to database
            String pName = req.getParameter("name");
            String pDesc = req.getParameter("description");
            int pPrice = Integer.parseInt(req.getParameter("price"));
            int pDiscount = Integer.parseInt(req.getParameter("discount"));
            if (pDiscount < 0 || pDiscount > 100) {
                pDiscount = 0;
            }
            int pQuantity = Integer.parseInt(req.getParameter("quantity"));
            Part part = req.getPart("photo");
            int categoryType = Integer.parseInt(req.getParameter("categoryType"));

            Product product = new Product(pName, pDesc, pPrice, pDiscount, pQuantity, part.getSubmittedFileName(),
                    categoryType);
            boolean flag = pdao.saveProduct(product);

            String path = req.getServletContext().getRealPath("/") + "Product_imgs" + File.separator
                    + part.getSubmittedFileName();
            try {
                FileOutputStream fos = new FileOutputStream(path);
                InputStream is = part.getInputStream();
                byte[] data = new byte[is.available()];
                is.read(data);
                fos.write(data);
                fos.flush();
                fos.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
            if (flag) {
                message = new Message("Product added successfully!!", "success", "alert-success");
            } else {
                message = new Message("Something went wrong! Try again!!", "error", "alert-danger");
            }
            session.setAttribute("message", message);
            resp.sendRedirect("admin.jsp");

        } else if (operation.trim().equals("updateCategory")) {

            int cid = Integer.parseInt(req.getParameter("cid"));
            String name = req.getParameter("category_name");
            Part part = req.getPart("category_img");
            if (part.getSubmittedFileName().isEmpty()) {
                String image = req.getParameter("image");
                Category category = new Category(cid, name, image);
                catDao.updateCategory(category);
            } else {
                Category category = new Category(cid, name, part.getSubmittedFileName());
                catDao.updateCategory(category);
                String path = req.getServletContext().getRealPath("/") + "Product_imgs" + File.separator
                        + part.getSubmittedFileName();
                try {
                    FileOutputStream fos = new FileOutputStream(path);
                    InputStream is = part.getInputStream();
                    byte[] data = new byte[is.available()];
                    is.read(data);
                    fos.write(data);
                    fos.flush();
                    fos.close();

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            message = new Message("Category updated successfully!!", "success", "alert-success");
            session.setAttribute("message", message);
            resp.sendRedirect("display_category.jsp");

        } else if (operation.trim().equals("deleteCategory")) {

            int cid = Integer.parseInt(req.getParameter("cid"));
            catDao.deleteCategory(cid);
            resp.sendRedirect("display_category.jsp");

        } else if (operation.trim().equals("updateProduct")) {

            int pid = Integer.parseInt(req.getParameter("pid"));
            String name = req.getParameter("name");
            float price = Float.parseFloat(req.getParameter("price"));
            String description = req.getParameter("description");
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            int discount = Integer.parseInt(req.getParameter("discount"));
            if (discount < 0 || discount > 100) {
                discount = 0;
            }
            Part part = req.getPart("product_img");
            int cid = Integer.parseInt(req.getParameter("categoryType"));
            if (cid == 0) {
                cid = Integer.parseInt(req.getParameter("category"));
            }
            if (part.getSubmittedFileName().isEmpty()) {
                String image = req.getParameter("image");
                Product product = new Product(pid, name, description, price, discount, quantity, image, cid);
                pdao.updateProduct(product);
            } else {

                Product product = new Product(pid, name, description, price, discount, quantity,
                        part.getSubmittedFileName(), cid);
                pdao.updateProduct(product);
                // product image upload
                String path = req.getServletContext().getRealPath("/") + "Product_imgs" + File.separator
                        + part.getSubmittedFileName();
                try {
                    FileOutputStream fos = new FileOutputStream(path);
                    InputStream is = part.getInputStream();
                    byte[] data = new byte[is.available()];
                    is.read(data);
                    fos.write(data);
                    fos.flush();
                    fos.close();

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            message = new Message("Product updated successfully!!", "success", "alert-success");
            session.setAttribute("message", message);
            resp.sendRedirect("display_products.jsp");

        } else if (operation.trim().equals("deleteProduct")) {

            int pid = Integer.parseInt(req.getParameter("pid"));
            pdao.deleteProduct(pid);
            resp.sendRedirect("display_products.jsp");

        }
        return;
        
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
