<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cancellation Result</title>
</head>
<body>
<%
    //String username = request.getParameter("username");
    int rid = Integer.parseInt(request.getParameter("rid"));

    try {
        // Establish database connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        // Update reservation status to 'Cancelled'
        String query = "UPDATE reservations SET status = 'Cancelled' WHERE rid = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, rid);
//        ps.setString(2, username);

        int rows = ps.executeUpdate();
        if (rows > 0) {
            out.println("<h2>Cancellation Successful!</h2>");
            out.println("<p>Your reservation has been cancelled.</p>");
        } else {
            out.println("<h2>Cancellation Failed</h2>");
            out.println("<p>No reservation found with the provided ID for the user.</p>");
        }

        // Close the database connection
        con.close();
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>
</body>
</html>
