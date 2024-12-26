<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>View Schedules by Station</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        form {
            margin: 20px auto;
            width: 80%;
            text-align: center;
        }
    </style>
</head>
<body>
    <h1 style="text-align: center;">View Train Schedules by Station</h1>

    <form method="get" action="viewStationSchedules.jsp">
        <label for="stationName">Station Name:</label>
        <input type="text" id="stationName" name="stationName" required>
        <input type="submit" value="Search">
    </form>

    <%
        String stationName = request.getParameter("stationName");
        if (stationName != null && !stationName.trim().isEmpty()) {
            Connection con = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // Connect to the database
                ApplicationDB db = new ApplicationDB();
                con = db.getConnection();

                // SQL query to fetch schedules with the given station as origin or destination
                String sql = "SELECT ts.line_name, ts.fare, ts.departure_time, ts.arrival_time, " +
                             "s1.name AS origin, s2.name AS destination " +
                             "FROM train_schedule ts " +
                             "JOIN station s1 ON ts.origin_station_id = s1.station_id " +
                             "JOIN station s2 ON ts.destination_station_id = s2.station_id " +
                             "WHERE s1.name = ? OR s2.name = ?";

                stmt = con.prepareStatement(sql);
                stmt.setString(1, stationName);
                stmt.setString(2, stationName);

                rs = stmt.executeQuery();

                // Display the results in a table
                if (rs.isBeforeFirst()) { // Check if there are any results
    %>
                    <table>
                        <thead>
                            <tr>
                                <th>Line Name</th>
                                <th>Fare</th>
                                <th>Departure Time</th>
                                <th>Arrival Time</th>
                                <th>Origin</th>
                                <th>Destination</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% while (rs.next()) { %>
                            <tr>
                                <td><%= rs.getString("line_name") %></td>
                                <td><%= rs.getInt("fare") %></td>
                                <td><%= rs.getTime("departure_time") %></td>
                                <td><%= rs.getTime("arrival_time") %></td>
                                <td><%= rs.getString("origin") %></td>
                                <td><%= rs.getString("destination") %></td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
    <%          } else { %>
                    <p style="text-align: center; color: red;">No schedules found for the station "<%= stationName %>".</p>
    <%          }
            } catch (Exception ex) {
                out.println("<p style='color: red; text-align: center;'>Error retrieving schedules: " + ex.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (con != null) con.close();
                } catch (SQLException ex) {
                    out.println("<p style='color: red; text-align: center;'>Error closing resources: " + ex.getMessage() + "</p>");
                }
            }
        } else {
    %>
        <p style="text-align: center; color: red;">Please enter a station name.</p>
    <% } %>
    <br>
    <a href="customerRep.jsp">Back to Customer Representative Page</a>

</body>
</html>
