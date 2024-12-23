package com.uniquedeveloper.registration;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form input parameters
        String uname = request.getParameter("name");
        String uemail = request.getParameter("email");
        String upwd = request.getParameter("pass");
        String umobile = request.getParameter("contact");

        RequestDispatcher dispatcher = null;
        Connection con = null;

        // Check if the input values are valid
        if (uname == null || uemail == null || upwd == null || umobile == null ||
            uname.isEmpty() || uemail.isEmpty() || upwd.isEmpty() || umobile.isEmpty()) {
            request.setAttribute("status", "failed");
            request.setAttribute("errorMessage", "All fields are required.");
            dispatcher = request.getRequestDispatcher("registration.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the database connection
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/food_items?useSSL=false&serverTimezone=UTC",
                "root",
                "admin"
            );

            // Validate the database connection
            if (con == null) {
                throw new Exception("Failed to connect to the database.");
            }

            // Prepare SQL query
            String query = "INSERT INTO users (uname, upwd, uemail, umobile) VALUES (?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(query);

            // Set parameter values for placeholders in the query
            pst.setString(1, uname);
            pst.setString(2, upwd); // Password should ideally be hashed for security
            pst.setString(3, uemail);
            pst.setString(4, umobile);

            // Execute the query and check for successful insertion
            int rowCount = pst.executeUpdate();

            // Prepare response based on the result
            dispatcher = request.getRequestDispatcher("registration.jsp");
            if (rowCount > 0) {
                request.setAttribute("status", "success");
                request.setAttribute("message", "Registration successful!");
            } else {
                request.setAttribute("status", "failed");
                request.setAttribute("message", "Registration failed, please try again.");
            }

            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            // Handle errors by forwarding to an error page
            request.setAttribute("status", "failed");
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        } finally {
            // Ensure the connection is properly closed
            try {
                if (con != null && !con.isClosed()) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
