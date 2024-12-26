<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
</head>
<body>
<%
   // Get parameters from the HTML form
   String fname = request.getParameter("firstName");
   String lname = request.getParameter("lastName");
   String username = request.getParameter("username");
   String password = request.getParameter("password");
   String email = request.getParameter("email");

   // Check if this is a login or registration request
   if (fname != null && lname != null && username != null && password != null && email != null) {
       // Registration logic
       try {
           ApplicationDB db = new ApplicationDB();
           Connection con = db.getConnection();

           if (con != null) {
               // Check if username already exists
               String checkQuery = "SELECT * FROM users WHERE username = ?";
               PreparedStatement checkStmt = con.prepareStatement(checkQuery);
               checkStmt.setString(1, username);
               ResultSet rs = checkStmt.executeQuery();

               if (rs.next()) {
                   // Username already exists
                   out.print("<div class='message'>Username already exists. Please try a different username.</div>");
               } else {
                   // Validate email or SSN based on role
                   if (email == null || email.trim().isEmpty()) {
                       out.print("<div class='message'>Email is required for customers.</div>");
                   } else {
                       // Insert the new user into the database
                       String insertQuery = "INSERT INTO users (username, password, email, fname, lname, role) VALUES (?, ?, ?, ?, ?, ?)";
                       PreparedStatement insertStmt = con.prepareStatement(insertQuery);
                       insertStmt.setString(1, username);
                       insertStmt.setString(2, password);
                       insertStmt.setString(3, email != null ? email : "");
                       insertStmt.setString(4, fname);
                       insertStmt.setString(5, lname);
                       insertStmt.setString(6, "customer");

                       int rowsInserted = insertStmt.executeUpdate();
                       
                       
                       if (rowsInserted > 0) {
                           out.print("<div class='message'>Registration successful! You can now log in.</div>");
                           out.print("<form action='login.jsp'> <input type='submit' value='Login' /> </form>");
                       } else {
                           out.print("<div class='message'>Registration failed. Please try again.</div>");
                       }
                       insertStmt.close();
                       
                   }
               }
               rs.close();
               checkStmt.close();
               con.close();
           } else {
               out.print("<div class='message'>Failed to connect to the database.</div>");
           }
       } catch (Exception ex) {
           out.print("<div class='message'>An error occurred: " + ex.getMessage() + "</div>");
       }
   } else {
       
   }
%>
</body>
</html>