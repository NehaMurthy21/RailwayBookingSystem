<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cancel</title>
</head>
<body>
    <form action="processCancellation.jsp" method="post">

    <label for="rid">Reservation ID:</label>
    <input type="number" name="rid" required><br>
   

    <input type="submit" value="Cancel Reservation">
</form>
</body>
</html>
