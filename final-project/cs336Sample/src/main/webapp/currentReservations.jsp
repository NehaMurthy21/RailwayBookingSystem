<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Current Reservations</title>
</head>
<body>
    <h1>Current Reservations</h1>

    <form method="post" action="">
        <label for="username">Enter Username:</label>
        <input type="text" id="username" name="username" required>
        <input type="submit" value="Get Reservations">
    </form>

<%
String username = request.getParameter("username");

if (username != null && !username.isEmpty()) {
    out.println("<p>Current User: " + username + "</p>");

    try {
        // Establish database connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        // Query to retrieve current reservations after the current date and time
        String query = "SELECT * FROM reservations WHERE username = ? AND date_ticket >= NOW()";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();

        out.println("<table border='1'><tr><th>Reservation ID</th><th>Total Cost</th><th>Origin</th><th>Destination</th><th>Date Ticket</th><th>Status</th></tr>");
        boolean hasReservations = false; // Flag to check if there are any reservations
        while (rs.next()) {
            hasReservations = true; // Set flag to true if at least one reservation is found
            out.println("<tr>");
            out.println("<td>" + rs.getInt("rid") + "</td>");
            out.println("<td>" + rs.getDouble("total_cost") + "</td>");
            out.println("<td>" + rs.getInt("origin_station_id") + "</td>");
            out.println("<td>" + rs.getInt("destination_station_id") + "</td>");
            out.println("<td>" + rs.getTimestamp("date_ticket") + "</td>"); // Use getTimestamp for date and time
            out.println("<td>" + rs.getString("status") + "</td>");
            out.println("</tr>");
        }
        if (!hasReservations) {
            out.println("<tr><td colspan='6'>No current reservations found.</td></tr>");
        }
        out.println("</table>");

        // Close the database connection
        con.close();
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
}
%>
</body>
</html>
