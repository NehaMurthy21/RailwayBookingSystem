<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>View Reservations by Transit Line</title>
</head>
<body>
    <h3>View Reservations by Transit Line</h3>
    <form action="viewReservations.jsp" method="post">
        <label for="transitLine">Transit Line Name:</label>
        <input type="text" id="transitLine" name="transitLine" required><br><br>

        <label for="date">Date:</label>
        <input type="date" id="date" name="date" required><br><br>

        <button type="submit">View Reservations</button>
    </form>

    <h4>Reservations:</h4>
    <table border="1">
        <thead>
            <tr>
                <th>Reservation ID</th>
                <th>Passenger</th>
                <th>Train Line</th>
                <th>Date</th>
                <th>Total Fare</th>
            </tr>
        </thead>
        <tbody>
            <% 
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String transitLine = request.getParameter("transitLine");
                    String date = request.getParameter("date");

                    try {
                        ApplicationDB db = new ApplicationDB();
                        Connection con = db.getConnection();
                        PreparedStatement ps = con.prepareStatement(
                            "SELECT r.rid AS reservation_id, u.fname, u.lname, r.line_name, r.date_ticket, r.total_cost " +
                            "FROM reservations r " +
                            "JOIN users u ON r.username = u.username " +
                            "WHERE r.line_name = ? AND r.date_ticket = ?");

                        ps.setString(1, transitLine);
                        ps.setString(2, date);
                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                            String reservationId = rs.getString("reservation_id");
                            String passenger = rs.getString("fname") + " " + rs.getString("lname");
                            String trainLine = rs.getString("line_name");
                            String reservationDate = rs.getString("date_ticket");
                            double totalFare = rs.getDouble("total_cost");
            %>
            <tr>
                <td><%= reservationId %></td>
                <td><%= passenger %></td>
                <td><%= trainLine %></td>
                <td><%= reservationDate %></td>
                <td><%= totalFare %></td>
            </tr>
            <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            %>
        </tbody>
    </table>
    
    <br>
    <a href="customerRep.jsp">Back to Customer Representative Page</a>
</body>
</html>
