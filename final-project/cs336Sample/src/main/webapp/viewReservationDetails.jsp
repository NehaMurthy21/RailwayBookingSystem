<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>View Reservation Details</title>
</head>
<body>
    <h1>View Reservation Details</h1>

    <form method="post" action="">
        <label for="username">Enter Username:</label>
        <input type="text" id="username" name="username" required>
        <br>
        <label for="rid">Enter Reservation ID:</label>
        <label for="rid">You can find reservation ID is looking at past or current reservations</label>
        
        <input type="text" id="rid" name="rid" required>
        <br>
        <input type="submit" value="View Reservation">
    </form>

<%
String username = request.getParameter("username");
String rid = request.getParameter("rid");

if (username != null && !username.isEmpty() && rid != null && !rid.isEmpty()) {
    try {
        // Establish database connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        // Query to retrieve reservation details based on username and reservation ID
        String reservationQuery = "SELECT r.*, ts.line_name FROM reservations r " +
                                  "JOIN train_schedule ts ON r.line_name = ts.line_name " +
                                  "WHERE r.username = ? AND r.rid = ?";
        PreparedStatement ps = con.prepareStatement(reservationQuery);
        ps.setString(1, username);
        ps.setInt(2, Integer.parseInt(rid));
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            out.println("<h2>Reservation Details</h2>");
            out.println("<p>Reservation ID: " + rs.getInt("rid") + "</p>");
            out.println("<p>Username: " + rs.getString("username") + "</p>");
            out.println("<p>Total Cost: $" + rs.getDouble("total_cost") + "</p>");
            out.println("<p>Date Ticket: " + rs.getDate("date_ticket") + "</p>");
            out.println("<p>Date Reserved: " + rs.getDate("date_reserved") + "</p>");
            out.println("<p>Discount: " + rs.getString("discount") + "</p>");
            out.println("<p>Trip Type: " + rs.getString("trip") + "</p>");
            out.println("<p>Line Name: " + rs.getString("line_name") + "</p>");
            out.println("<p>Status: " + rs.getString("status") + "</p>");

            // Fetching origin station details including arrival and departure times
            String originStationQuery = "SELECT s.name, sa.stop_arrival_time, sa.stop_departure_time " +
                                         "FROM station s " +
                                         "JOIN stops_at sa ON s.station_id = sa.station_id " +
                                         "WHERE s.station_id = ? AND sa.line_name = ?";
            PreparedStatement originPs = con.prepareStatement(originStationQuery);
            originPs.setInt(1, rs.getInt("origin_station_id"));
            originPs.setString(2, rs.getString("line_name"));
            ResultSet originRs = originPs.executeQuery();
            String originStationName = "";
            String originArrivalTime = "N/A";
            String originDepartureTime = "N/A";
            if (originRs.next()) {
                originStationName = originRs.getString("name");
                originArrivalTime = originRs.getTime("stop_arrival_time") != null ? originRs.getTime("stop_arrival_time").toString() : "N/A";
                originDepartureTime = originRs.getTime("stop_departure_time") != null ? originRs.getTime("stop_departure_time").toString() : "N/A";
            }

            // Fetching destination station details including arrival and departure times
            String destinationStationQuery = "SELECT s.name, sa.stop_arrival_time, sa.stop_departure_time " +
                                              "FROM station s " +
                                              "JOIN stops_at sa ON s.station_id = sa.station_id " +
                                              "WHERE s.station_id = ? AND sa.line_name = ?";
            PreparedStatement destinationPs = con.prepareStatement(destinationStationQuery);
            destinationPs.setInt(1, rs.getInt("destination_station_id"));
            destinationPs.setString(2, rs.getString("line_name"));
            ResultSet destinationRs = destinationPs.executeQuery();
            String destinationStationName = "";
            String destinationArrivalTime = "N/A";
            String destinationDepartureTime = "N/A";
            if (destinationRs.next()) {
                destinationStationName = destinationRs.getString("name");
                destinationArrivalTime = destinationRs.getTime("stop_arrival_time") != null ? destinationRs.getTime("stop_arrival_time").toString() : "N/A";
                destinationDepartureTime = destinationRs.getTime("stop_departure_time") != null ? destinationRs.getTime("stop_departure_time").toString() : "N/A";
            }

            // Now retrieve the stops for this reservation
            String stopsQuery = "SELECT sa.station_id, s.name, sa.stop_arrival_time, sa.stop_departure_time " +
                    "FROM stops_at sa " +
                    "JOIN station s ON sa.station_id = s.station_id " +
                    "WHERE sa.line_name = ? " +
                    "AND sa.stop_number > (SELECT stop_number FROM stops_at WHERE line_name = ? AND station_id = ?) " +
                    "AND sa.stop_number < (SELECT stop_number FROM stops_at WHERE line_name = ? AND station_id = ?) " +
                    "ORDER BY sa.stop_number";
            PreparedStatement stopsPs = con.prepareStatement(stopsQuery);
            stopsPs.setString(1, rs.getString("line_name"));
            stopsPs.setString(2, rs.getString("line_name"));
            stopsPs.setInt(3, rs.getInt("origin_station_id"));
            stopsPs.setString(4, rs.getString("line_name"));
            stopsPs.setInt(5, rs.getInt("destination_station_id"));
            ResultSet stopsRs = stopsPs.executeQuery();

            // Check if the ResultSet is empty
            out.println("<h3>Journey Details:</h3>");
            out.println("<table border='1'><tr><th>Station ID</th><th>Station Name</th><th>Arrival Time</th><th>Departure Time</th></tr>");

            // Add origin station as the first row
            out.println("<tr>");
            out.println("<td>" + rs.getInt("origin_station_id") + "</td>");
            out.println("<td>" + originStationName + "</td>");
            out.println("<td>" + originArrivalTime + "</td>");
            out.println("<td>" + originDepartureTime + "</td>");
            out.println("</tr>");

            // Add stops in between
            while (stopsRs.next()) {
                out.println("<tr>");
                out.println("<td>" + stopsRs.getInt("station_id") + "</td>");
                out.println("<td>" + stopsRs.getString("name") + "</td>");
                out.println("<td>" + stopsRs.getTime("stop_arrival_time") + "</td>");
                out.println("<td>" + stopsRs.getTime("stop_departure_time") + "</td>");
                out.println("</tr>");
            }

            // Add destination station as the last row
            out.println("<tr>");
            out.println("<td>" + rs.getInt("destination_station_id") + "</td>");
            out.println("<td>" + destinationStationName + "</td>");
            out.println("<td>" + destinationArrivalTime + "</td>");
            out.println("<td>" + destinationDepartureTime + "</td>");
            out.println("</tr>");

            out.println("</table>");
        } else {
            out.println("<p>No reservation found for the provided username and reservation ID.</p>");
        }

        // Close the database connection
        con.close();
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } catch (NumberFormatException e) {
        out.println("<p>Error: Reservation ID must be a number.</p>");
    }
}
%>
</body>
</html>
