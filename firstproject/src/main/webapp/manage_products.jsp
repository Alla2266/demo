<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Products</title>
</head>
<body>
    <h2>Manage Products</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Category</th>
            <th>Price</th>
            <th>Image</th>
            <th>Actions</th>
        </tr>
        <% 
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_items", "root", "admin");
                stmt = conn.prepareStatement("SELECT * FROM menu_item");
                rs = stmt.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("category") %></td>
            <td><%= rs.getDouble("price") %></td>
            <td><img src="<%= rs.getString("image_path") %>" width="100"></td>
            <td>
                <a href="edit_product.jsp?id=<%= rs.getString("id") %>">Edit</a>
                <a href="delete_product.jsp?id=<%= rs.getString("id") %>" onclick="return confirm('Are you sure?')">Delete</a>
            </td>
        </tr>
        <% 
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </table>
</body>
</html>
