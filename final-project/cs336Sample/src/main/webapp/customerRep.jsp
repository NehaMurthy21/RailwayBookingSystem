<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Representative Dashboard</title>
    <style>
        .nav-links {
            margin-bottom: 20px;
        }

        .nav-links a {
            display: block;
            margin-bottom: 10px;
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <h2>Welcome!</h2>

    <div class="nav-links">
        <a href="editDeleteSchedules.jsp">Edit/Delete Schedules</a>
        <a href="replyQueries.jsp">Reply to Customer Queries</a>
        <a href="viewReservations.jsp">View Reservations by Transit Line</a>
        <a href="viewStationSchedules.jsp">View Schedules by Station</a>
        <a href="viewMessagesSentByCustomers.jsp">View Questions Sent By Customers</a>
        
    </div>
    
  <form method="get" action="actionLogout.jsp">
	<input type="submit" value="Logout" class="big-button">
</form>

</body>
</html>
