<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <!-- Dashboard Section -->
    <div class="container">
        <!-- Sidebar -->
        <div class="navigation">
            <ul>
                <li>
                    <a href="#">
                        <span class="icon"><i class="fa fa-user-plus" aria-hidden="true"></i></span>
                        <span class="title"><h2>Admin Dashboard</h2></span>
                    </a>
                </li>
                <li>
                    <a href="admin.jsp">
                        <span class="icon"><i class="fa fa-home" aria-hidden="true"></i></span>
                        <span class="title">Home</span>
                    </a>
                </li>
                <li>
                    <a href="add_product.jsp">
                        <span class="icon"><i class="fa fa-plus" aria-hidden="true"></i></span>
                        <span class="title">Add Product</span>
                    </a>
                </li>
                <li>
                    <a href="manage_products.jsp">
                        <span class="icon"><i class="fa fa-list" aria-hidden="true"></i></span>
                        <span class="title">Manage Products</span>
                    </a>
                </li>
                <li>
                    <a href="view_orders.jsp">
                        <span class="icon"><i class="fa fa-shopping-bag" aria-hidden="true"></i></span>
                        <span class="title">View Orders</span>
                    </a>
                </li>
                <li>
                    <a href="view_feedback.jsp">
                        <span class="icon"><i class="fa fa-comments" aria-hidden="true"></i></span>
                        <span class="title">View Feedback</span>
                    </a>
                </li>
                <li>
                    <a href="login.jsp">
                        <span class="icon"><i class="fa fa-sign-out" aria-hidden="true"></i></span>
                        <span class="title">Logout</span>
                    </a>
                </li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main">
            <div class="topbar">
                <div class="toggle"></div>
                <div class="search">
                    <input type="text" placeholder="Search Here">
                    <i class="fa fa-search" aria-hidden="true"></i>
                </div>
                <div class="user">
                    <img src="./img/dashboard_logo.png" alt="Admin" style="height:80px;">
                </div>
            </div>

            <div class="cardbox">
                <!-- Product Count -->
                <div class="card">
                    <div>
                        <div class="numbers">
                            <% 
                                int productCount = 0;
                                Connection conn = null;
                                PreparedStatement stmt = null;
                                ResultSet rs = null;
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_items", "root", "admin");
                                    stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM menu_item");
                                    rs = stmt.executeQuery();
                                    if (rs.next()) {
                                        productCount = rs.getInt("total");
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    if (rs != null) rs.close();
                                    if (stmt != null) stmt.close();
                                    if (conn != null) conn.close();
                                }
                            %>
                            <%= productCount %>
                        </div>
                        <div class="cardname">Products</div>
                    </div>
                    <div class="iconbox"><i class="fa fa-list" aria-hidden="true"></i></div>
                </div>

                <!-- Orders Count -->
                <div class="card">
                    <div>
                        <div class="numbers">
                            <% 
                                int orderCount = 0;
                                try {
                                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_items", "root", "admin");
                                    stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM orders");
                                    rs = stmt.executeQuery();
                                    if (rs.next()) {
                                        orderCount = rs.getInt("total");
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    if (rs != null) rs.close();
                                    if (stmt != null) stmt.close();
                                    if (conn != null) conn.close();
                                }
                            %>
                            <%= orderCount %>
                        </div>
                        <div class="cardname">Orders</div>
                    </div>
                    <div class="iconbox"><i class="fa fa-shopping-cart" aria-hidden="true"></i></div>
                </div>

                <!-- Feedback Count -->
                <div class="card">
                    <div>
                        <div class="numbers">
                            <% 
                                int feedbackCount = 0;
                                try {
                                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_items", "root", "admin");
                                    stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM feedback");
                                    rs = stmt.executeQuery();
                                    if (rs.next()) {
                                        feedbackCount = rs.getInt("total");
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    if (rs != null) rs.close();
                                    if (stmt != null) stmt.close();
                                    if (conn != null) conn.close();
                                }
                            %>
                            <%= feedbackCount %>
                        </div>
                        <div class="cardname">Feedback</div>
                    </div>
                    <div class="iconbox"><i class="fa fa-comments" aria-hidden="true"></i></div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
