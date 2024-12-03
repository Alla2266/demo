package com.uniquedeveloper.registration;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Servlet implementation class Product
 */
@WebServlet("/Product")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class Product extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploaded_images";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String prodId = request.getParameter("id");
        String prodName = request.getParameter("name");
        String category = request.getParameter("category");
      
        String price = request.getParameter("price");

        RequestDispatcher dispatcher = null;
        Connection con = null;

        try {
            // Handle file upload
            Part filePart = request.getPart("fname");
            String fileName = filePart.getSubmittedFileName();

            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the database connection
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/food_items?useSSL=false&serverTimezone=UTC",
                "root",
                "admin"
            );

            // Prepare SQL query
            String query = "INSERT INTO menu_item (id, name, category, price, image_path) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(query);

            // Set parameters for placeholders in the query
            pst.setString(1, prodId);
            pst.setString(2, prodName);
            pst.setString(3, category);
            pst.setString(4, price);
            pst.setString(5, UPLOAD_DIR + File.separator + fileName);

            // Execute query and check for success
            int rowCount = pst.executeUpdate();

            dispatcher = request.getRequestDispatcher("admin.jsp");
            if (rowCount > 0) {
                request.setAttribute("status", "success");
                request.setAttribute("message", "Product added successfully!");
                response.sendRedirect("admin.jsp?msg=valid");
            } else {
                request.setAttribute("status", "failed");
                request.setAttribute("message", "Failed to add product. Please try again.");
                response.sendRedirect("admin.jsp?msg=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Forward to an error page if exceptions occur
            request.setAttribute("status", "failed");
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        } finally {
            // Ensure the database connection is properly closed
            try {
                if (con != null && !con.isClosed()) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
