<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Make a Reservation</title>
</head>
<body>
    <h1>Make a Reservation</h1>
    <form action="processReservation.jsp" method="post">
        <label for="username">Username:</label>
        <input type="text" name="username" required><br>

        <label for="origin_station_id">Origin Station ID:</label>
        <input type="number" name="origin_station_id" required><br>

        <label for="destination_station_id">Destination Station ID:</label>
        <input type="number" name="destination_station_id" required><br>

        <label for="line_name">Line Name:</label>
        <input type="text" name="line_name" required><br>

        <label for="date_ticket">Date of Ticket:</label>
        <input type="date" name="date_ticket" required><br>

        <label for="discount">Discount:</label>
        <select name="discount">
            <option value="Normal">Normal</option>
            <option value="Disabled">Disabled</option>
            <option value="Senior">Senior</option>
            <option value="Child">Child</option>
        </select><br>

        <label for="trip">Trip Type:</label>
        <select name="trip">
            <option value="One">One Way</option>
            <option value="Round">Round Trip</option>
        </select><br>

        <input type="submit" value="Reserve">
    </form>
</body>
</html>
