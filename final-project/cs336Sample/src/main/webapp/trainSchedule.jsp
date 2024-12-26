<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
        h1 {
            font-size: 40px;
            color: #004080;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .form-label {
            font-size: 30px;
            font-weight: bold;
        }
        .radio-option {
            font-size: 30px;
        }
        .input-field {
            font-size: 25px;
            padding: 8px;
            width: 200px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            font-size: 16px;
            font-weight: bold;
            padding: 10px 15px;
            background-color: #0073e6;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #005bb5;
        }
        input[type="radio"] {
            transform: scale(1.5);
            margin-right: 8px;
        }
        .radio-option {
            font-size: 35px;
        }
    </style>
<meta charset="UTF-8">
<title>Train Schedules</title>
</head>
<body>

    <form method="get" action="actionSearch.jsp">
        <table>
            <tr>
                <td class="form-label">Search: </td>
                <td><input type="text" name="search" class="input-field"></td>
            </tr>
            <tr>
            	<td class="form-label">Search By: </td>
	                <td>
	                    <label class="radio-option">
	                        <input type="radio" name="searchBy" value="origin" onclick="toggleField('origin')"> Origin
	                    </label>
	                    <label class="radio-option">
	                        <input type="radio" name="searchBy" value="destination" onclick="toggleField('destination')"> Destination
	                    </label>
	                    <label class="radio-option">
	                        <input type="radio" name="searchBy" value="date" onclick="toggleField('date')"> Date of Travel
	                    </label>
	                </td>
	        </tr>
	        <tr>
                <td class="form-label">Sort By: </td>
                <td>
                    <label class="radio-option">
                        <input type="radio" name="sortBy" value="arrivalTime" onclick="toggleField('arrivalTime')"> Arrival Time
                    </label>
                    <label class="radio-option">
                        <input type="radio" name="sortBy" value="departureTime" onclick="toggleField('departureTime')"> Departure Time
                    </label>
                    <label class="radio-option">
                        <input type="radio" name="sortBy" value="fare" onclick="toggleField('fare')"> Fare
                    </label>
                </td>
            </tr>
        </table>
        <br>
        <input type="submit" value="Search">
    </form>


<form method="get" action="index.jsp">
<input type="submit" value="Home"  class="big-button">
</form>


</body>
</html>