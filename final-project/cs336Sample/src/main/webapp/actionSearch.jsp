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
<title>Train Schedule</title>
</head>
<body>
<%
    String search = request.getParameter("search");
    String searchBy = request.getParameter("searchBy");
    String sortBy = request.getParameter("sortBy");

    try {
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        String query = "";

        if (con != null) {
            if (search == "" || searchBy == null || sortBy == null) {
%>
            <h2>Invalid Input!</h2>
            <form method="get" action="trainSchedule.jsp">
                <input type="submit" value="Go Back" class="big-button">
            </form>
<%
            } else {
                if (searchBy.equals("origin")) {
                    query = "SELECT ts.line_name, " +
                            "s1.name AS origin_station, " +
                            "s2.name AS destination_station, " +
                            "ts.departure_time, " +
                            "ts.arrival_time, " +
                            "ts.fare, " +
                            "ts.travel_time, " +
                            "ts.num_stops, " +
                            "ts.is_operational " +
                            "FROM train_schedule ts " +
                            "JOIN station s1 ON ts.origin_station_id = s1.station_id " +
                            "JOIN station s2 ON ts.destination_station_id = s2.station_id " +
                            "WHERE s1.name LIKE ? ";
                } else if (searchBy.equals("destination")) {
                    query = "SELECT ts.line_name, " +
                            "s1.name AS origin_station, " +
                            "s2.name AS destination_station, " +
                            "ts.departure_time, " +
                            "ts.arrival_time, " +
                            "ts.fare, " +
                            "ts.travel_time, " +
                            "ts.num_stops, " +
                            "ts.is_operational " +
                            "FROM train_schedule ts " +
                            "JOIN station s1 ON ts.origin_station_id = s1.station_id " +
                            "JOIN station s2 ON ts.destination_station_id = s2.station_id " +
                            "WHERE s2.name LIKE ? ";
                } else if (searchBy.equals("date")) {
                    query = "SELECT ts.line_name, " +
                            "s1.name AS origin_station, " +
                            "s2.name AS destination_station, " +
                            "ts.departure_time, " +
                            "ts.arrival_time, " +
                            "ts.fare, " +
                            "ts.travel_time, " +
                            "ts.num_stops, " +
                            "ts.is_operational " +
                            "FROM train_schedule ts " +
                            "JOIN station s1 ON ts.origin_station_id = s1.station_id " +
                            "JOIN station s2 ON ts.destination_station_id = s2.station_id " +
                            "WHERE ts.departure_time LIKE ? ";
                }

                if (sortBy.equals("arrivalTime")) {
                    query += "ORDER BY ts.arrival_time ASC;";
                } else if (sortBy.equals("departureTime")) {
                    query += "ORDER BY ts.departure_time ASC;";
                } else if (sortBy.equals("fare")) {
                    query += "ORDER BY ts.fare ASC;";
                } else {
                    query += ";";
                }

                PreparedStatement pstmt = con.prepareStatement(query);
                pstmt.setString(1, "%" + search + "%");
                ResultSet rs = pstmt.executeQuery();

                if (!rs.next()) {
%>
                <h2>No matching results!</h2>
                <form method="get" action="trainSchedule.jsp">
                    <input type="submit" value="Go Back" class="big-button">
                </form>
<%
                } else {
%>
                <table border="1">
                    <tr>
                        <th>Line Name</th>
                        <th>Origin Station</th>
                        <th>Destination Station</th>
                        <th>Departure Time</th>
                        <th>Arrival Time</th>
                        <th>Travel Time</th>
                        <th>Number Of Stops</th>
                        <th>Fare</th>
                        <th>Operational?</th>
                    </tr>
<%
                    do {
                        String lineName = rs.getString("line_name");
%>
                    <tr>
                        <td><%= lineName %></td>
                        <td><%= rs.getString("origin_station") %></td>
                        <td><%= rs.getString("destination_station") %></td>
                        <td><%= rs.getTime("departure_time") %></td>
                        <td><%= rs.getTime("arrival_time") %></td>
                        <td><%= rs.getTime("travel_time") %></td>
                        <td><%= rs.getInt("num_stops") %></td>
                        <td><%= rs.getInt("fare") %></td>
                        <td><%= rs.getBoolean("is_operational") %></td>
                    </tr>
<%
                        // Query for stops on this line
                        String stopsQuery = "SELECT sa.station_id, st.name AS station_name, sa.stop_arrival_time, sa.stop_departure_time, sa.stop_number " +
                                            "FROM stops_at sa " +
                                            "JOIN station st ON sa.station_id = st.station_id " +
                                            "WHERE sa.line_name = ? " +
                                            "ORDER BY sa.stop_number ASC";
                        PreparedStatement stopsStmt = con.prepareStatement(stopsQuery);
                        stopsStmt.setString(1, lineName);
                        ResultSet stopsRs = stopsStmt.executeQuery();
%>
                    <tr>
                        <td colspan="9">
                            <b>Stops:</b>
                            <ul>
<%
                        while (stopsRs.next()) {
%>
                                <li>Stop <%= stopsRs.getInt("stop_number") %>: <%= stopsRs.getString("station_name") %> (Arrival: <%= stopsRs.getTime("stop_arrival_time") %>, Departure: <%= stopsRs.getTime("stop_departure_time") %>)</li>
<%
                        }
%>
                            </ul>
                        </td>
                    </tr>
<%
                        stopsRs.close();
                        stopsStmt.close();
                    } while (rs.next());
%>
                </table>
<%
                }

                rs.close();
                pstmt.close();
                con.close();
            }
        } else {
            out.print("<div class='message'>Failed to connect to the database.</div>");
        }
    } catch (Exception ex) {
        out.print("<div class='message'>An error occurred: " + ex.getMessage() + "</div>");
    }
%>
<form method="get" action="customer.jsp">
    <input type="submit" value="Home" class="big-button">
</form>
<form method="get" action="trainSchedule.jsp">
    <input type="submit" value="Train Schedules" class="big-button">
</form>
</body>
</html>