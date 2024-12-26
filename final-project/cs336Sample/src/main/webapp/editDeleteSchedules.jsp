<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit/Delete Train Schedules</title>
</head>
<body>
    <h3>Edit or Delete Train Schedules</h3>
    <form action="editDeleteSchedules.jsp" method="post">
        <label for="lineName">Line Name:</label>
        <input type="text" id="lineName" name="lineName" required><br><br>

        <label for="departureTime">Current Departure Time (HH:MM:SS):</label>
        <input type="text" id="departureTime" name="departureTime" required pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]"><br><br>

        <label for="arrivalTime">Current Arrival Time (HH:MM:SS):</label>
        <input type="text" id="arrivalTime" name="arrivalTime" required pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]"><br><br>

        <label for="newDepartureTime">New Departure Time (HH:MM:SS):</label>
        <input type="text" id="newDepartureTime" name="newDepartureTime" pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]"><br><br>

        <label for="newArrivalTime">New Arrival Time (HH:MM:SS):</label>
        <input type="text" id="newArrivalTime" name="newArrivalTime" pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]"><br><br>

        <label for="action">Action:</label>
        <select name="action" id="action">
            <option value="edit">Edit Schedule</option>
            <option value="delete">Delete Schedule</option>
        </select><br><br>

        <button type="submit">Submit</button>
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String lineName = request.getParameter("lineName");
            String departureTime = request.getParameter("departureTime");
            String arrivalTime = request.getParameter("arrivalTime");
            String newDepartureTime = request.getParameter("newDepartureTime");
            String newArrivalTime = request.getParameter("newArrivalTime");
            String action = request.getParameter("action");

            Connection con = null;
            PreparedStatement ps = null;

            try {
                ApplicationDB db = new ApplicationDB();
                con = db.getConnection();

                if ("edit".equalsIgnoreCase(action)) {
                    // Editing train_schedule based on line_name, departure_time, and arrival_time
                    ps = con.prepareStatement(
                        "UPDATE train_schedule SET departure_time = ?, arrival_time = ? WHERE line_name = ? AND departure_time = ? AND arrival_time = ?"
                    );
                    ps.setString(1, newDepartureTime);
                    ps.setString(2, newArrivalTime);
                    ps.setString(3, lineName);
                    ps.setString(4, departureTime);
                    ps.setString(5, arrivalTime);
                    int rows = ps.executeUpdate();
                    if (rows > 0) {
                        out.println("<p>Schedule updated successfully!</p>");
                    } else {
                        out.println("<p>No matching schedule found to update.</p>");
                    }
                } else if ("delete".equalsIgnoreCase(action)) {
                    // Deleting train_schedule; related reservations will be deleted due to cascade delete
                    ps = con.prepareStatement(
                            "UPDATE train_schedule SET is_operational = False WHERE line_name = ? AND departure_time = ? AND arrival_time = ?"

                    );
                    ps.setString(1, lineName);
                    ps.setString(2, departureTime);
                    ps.setString(3 , arrivalTime);
                    int rows = ps.executeUpdate();
                    if (rows > 0) {
                        out.println("<p>Schedule and related reservations have been deleted successfully!</p>");
                    } else {
                        out.println("<p>No matching schedule found to delete.</p>");
                    }
                }

            } catch (SQLException e) {
                out.println("<p>Error: Database error occurred. " + e.getMessage() + "</p>");
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                if (ps != null) {
                    try {
                        ps.close();
                    } catch (SQLException e) {
                        out.println("<p>Error closing PreparedStatement: " + e.getMessage() + "</p>");
                    }
                }
                if (con != null) {
                    try {
                        con.close();
                    } catch (SQLException e) {
                        out.println("<p>Error closing Connection: " + e.getMessage() + "</p>");
                    }
                }
            }
        }
    %>
    
    <br>
    <a href="customerRep.jsp">Back to Customer Representative Page</a>
</body>
</html>
