<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer</title>
</head>
<body>
<h1>Customer</h1>
<form action="trainSchedule.jsp">
    <input type="submit" value="Train Schedules" />
</form>
<form action="reservations.jsp">
    <input type="submit" value="Create Reservation" />
</form>
<form action="sendMessage.jsp">
    <input type="submit" value="Send Message" />
</form>
<form action="viewAllMessages.jsp">
    <input type="submit" value="View All Sent Messages" />
</form>
<form method="get" action="actionLogout.jsp">
	<input type="submit" value="Logout" class="big-button">
</form>

</body>
</html>
