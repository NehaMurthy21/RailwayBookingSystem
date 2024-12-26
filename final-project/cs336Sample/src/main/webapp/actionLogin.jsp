<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        .message {
            font-size: 40px;
            font-weight: bold;
            color: #333;
            margin: 20px 0;
        }
        .big-button {
            font-size: 18px;
            padding: 12px 20px;
            width: 120px;
            background-color: #0073e6;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .big-button:hover {
            background-color: #005bb5;
        }
    </style>
</head>
<body>
<%

    String loginUsername = request.getParameter("username");
    String loginPassword = request.getParameter("password");
    boolean isLoggedIn = false;

    try {
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        if (con != null) {
            String query = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, loginUsername);
            pstmt.setString(2, loginPassword);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                isLoggedIn = true;
                query = "SELECT role FROM users WHERE username = ? AND password = ?";
                PreparedStatement p = con.prepareStatement(query);
                p.setString(1, loginUsername);
                p.setString(2, loginPassword);
                rs = p.executeQuery();
                rs.next();
                if (rs.getString("role").equals("customer_service_rep")) {
                	String redirectURL = "customerRep.jsp";
             	    response.sendRedirect(redirectURL);
                } else if (rs.getString("role").equals("administrator")) {
                	String redirectURL = "admin.jsp";
                	response.sendRedirect(redirectURL);
                } else if (rs.getString("role").equals("customer")) {
                	String redirectURL = "customer.jsp";
                	response.sendRedirect(redirectURL);
                }
                out.print("<div class='message'>Successfully Logged In</div>");
            } else {
                out.print("<div class='message'>Invalid username or password.</div>");
            }
            rs.close();
            pstmt.close();
            con.close();
        } else {
            out.print("<div class='message'>Failed to connect to the database.</div>");
        }
    } catch (Exception ex) {
        out.print("<div class='message'>An error occurred: " + ex.getMessage() + "</div>");
    }

    if (isLoggedIn) {
        %>
        <form method="get" action="actionLogout.jsp">
            <input type="submit" value="Logout" class="big-button">
        </form>
        <%
    } else {
        %>
        <form method="get" action="login.jsp">
            <input type="submit" value="Try Again" class="big-button">
        </form>
        <%
    }
   
%>
</body>
</html>