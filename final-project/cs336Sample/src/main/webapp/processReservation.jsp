<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Reservation Result</title>
</head>
<body>
<%
    String username = request.getParameter("username");
    int originStationId = Integer.parseInt(request.getParameter("origin_station_id"));
    int destinationStationId = Integer.parseInt(request.getParameter("destination_station_id"));
    String lineName = request.getParameter("line_name");
    String dateTicket = request.getParameter("date_ticket");
    String discountType = request.getParameter("discount"); // "child", "senior", "disabled"
    String tripType = request.getParameter("trip"); //  "oneway", "roundtrip"

    double baseFare = 50.00; 
    int numberOfStops = 10; 
    double farePerStop = baseFare / numberOfStops; 

    double totalCost = 0.0;

    // Calculate total cost based on trip type
    if ("roundtrip".equalsIgnoreCase(tripType)) {
        totalCost = 2 * baseFare; // Double the fare for round trip
    } else {
        totalCost = baseFare; // One way fare
    }

    // Apply discounts based on passenger type
    if ("child".equalsIgnoreCase(discountType)) {
        totalCost *= 0.75; // 25% discount
    } else if ("senior".equalsIgnoreCase(discountType)) {
        totalCost *= 0.65; // 35% discount
    } else if ("disabled".equalsIgnoreCase(discountType)) {
        totalCost *= 0.50; // 50% discount
    }

    double bookingFee = 10.00; // Example booking fee
    totalCost += bookingFee; // Add booking fee to total cost

    try {
        // Establish database connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        // Insert reservation into the database
        String query = "INSERT INTO reservations (username, total_cost, origin_station_id, destination_station_id, date_ticket, date_reserved, discount, trip, line_name, status) VALUES (?, ?, ?, ?, ?, NOW(), ?, ?, ?, 'Confirmed')";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, username);
        ps.setDouble(2, totalCost);
        ps.setInt(3, originStationId);
        ps.setInt(4, destinationStationId);
        ps.setString(5, dateTicket);
        ps.setString(6, discountType);
        ps.setString(7, tripType);
        ps.setString(8, lineName);

        int rows = ps.executeUpdate();
        if (rows > 0) {
            out.println("<h2>Reservation Successful!</h2>");
            out.println("<p>Your total cost is <strong>$" + String.format("%.2f", totalCost) + "</strong>.</p>");
        } else {
            out.println("<h2>Reservation Failed</h2>");
            out.println("<p>There was an issue processing your reservation. Please try again.</p>");
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
