<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>Add New Product</h2>
    <form action="Product" method="post" enctype="multipart/form-data">
        <label for="prodid">Product ID:</label>
        <input type="text" id="prodid" name="prodid" required><br>
        <label for="prodname">Product Name:</label>
        <input type="text" id="prodname" name="prodname" required><br>
        <label for="catagory">Category:</label>
        <input type="text" id="catagory" name="catagory" required><br>
        <label for="price">Price:</label>
        <input type="number" id="price" name="price" required><br>
        <label for="fname">Image:</label>
        <input type="file" id="fname" name="fname" accept="image/*" required><br>
        <button type="submit">Add Product</button>
    </form>
</body>
</html>
