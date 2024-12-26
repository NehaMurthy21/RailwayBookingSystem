<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
   /* Styling for the logout message */
   .logout-message {
       font-size: 32px;       /* Increase font size */
       font-weight: bold;     /* Make the text bold */
       color: #333;           /* Set a neutral color */
       margin: 20px 0;        /* Add space above and below */
       text-align: center;    /* Center-align the text */
   }
   /* Styling for the login button */
   .big-button {
       font-size: 18px;       /* Increase button text size */
       padding: 12px 24px;    /* Add padding to make the button larger */
       width: 120px;          /* Set a fixed width */
       background-color: #0073e6;
       color: #fff;
       border: none;
       border-radius: 5px;
       cursor: pointer;
       display: block;
       margin: 20px auto;     /* Center the button */
   }
   .big-button:hover {
       background-color: #005bb5; /* Darken color on hover */
   }
</style>
<meta charset="UTF-8">
<title>Logout Page</title>
</head>
<body>
<h1 class="logout-message">You are logged out!!</h1>
<form method="get" action="index.jsp">
<input type="submit" value="Home"  class="big-button">
</form>
</body>
</html>