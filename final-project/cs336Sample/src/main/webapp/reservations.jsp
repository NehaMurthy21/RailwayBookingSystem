<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reservation Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
        }
        button {
            padding: 15px 30px;
            font-size: 16px;
            margin: 10px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>Reservation Management</h1>
    <p>Please select an action:</p>
    
    <form action="makeReservation.jsp" method="get">
        <button type="submit">Make a Reservation</button>
    </form>
    
    <form action="cancelReservation.jsp" method="get">
        <button type="submit">Cancel</button>
    </form>
    
    <form action="pastReservations.jsp" method="get">
        <button type="submit">Past Reservations</button>
    </form>
    
    <form action="currentReservations.jsp" method="get">
        <button type="submit">Current Reservations</button>
    </form>
    <form action="viewReservationDetails.jsp" method="get">
        <button type="submit">View Itinerary</button>
    </form>
</body>
</html>
