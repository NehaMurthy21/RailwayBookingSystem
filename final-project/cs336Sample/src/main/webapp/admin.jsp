<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Administrator</title>
	<script type="text/javascript">
        function toggleField(value) {
            if (value === "list") {
                document.getElementById("customerUsername").style.display = "block";
                document.getElementById("transitLine").style.display = "block";
                document.getElementById("firstName").style.display = "none";
            	document.getElementById("lastName").style.display = "none";
            	document.getElementById("username").style.display = "none";
            	document.getElementById("password").style.display = "none";
            	document.getElementById("ssn").style.display = "none";
            	document.getElementById("changeActions").style.display = "none";
            	document.getElementById("newFirstName").style.display = "none";
            	document.getElementById("newLastName").style.display = "none";
            	document.getElementById("newPassword").style.display = "none";
            } else if (value === "change") {
            	document.getElementById("customerUsername").style.display = "none";
                document.getElementById("transitLine").style.display = "none";
            	document.getElementById("firstName").style.display = "none";
            	document.getElementById("lastName").style.display = "none";
            	document.getElementById("username").style.display = "none";
            	document.getElementById("password").style.display = "none";
            	document.getElementById("ssn").style.display = "none";
            	document.getElementById("newFirstName").style.display = "none";
            	document.getElementById("newLastName").style.display = "none";
            	document.getElementById("newPassword").style.display = "none";
            	document.getElementById("changeActions").style.display = "block";
            } else if (value === "revenue") {
            	document.getElementById("customerUsername").style.display = "block";
                document.getElementById("transitLine").style.display = "block";
                document.getElementById("firstName").style.display = "none";
            	document.getElementById("lastName").style.display = "none";
            	document.getElementById("username").style.display = "none";
            	document.getElementById("password").style.display = "none";
            	document.getElementById("ssn").style.display = "none";
            	document.getElementById("newFirstName").style.display = "none";
            	document.getElementById("newLastName").style.display = "none";
            	document.getElementById("newPassword").style.display = "none";
            	document.getElementById("changeActions").style.display = "none";
            }
        }
        function customerRepAction(value) {
        	if (value === "add") {
        		document.getElementById("customerUsername").style.display = "none";
                document.getElementById("transitLine").style.display = "none";
                document.getElementById("newFirstName").style.display = "none";
            	document.getElementById("newLastName").style.display = "none";
            	document.getElementById("newPassword").style.display = "none";
            	document.getElementById("firstName").style.display = "block";
            	document.getElementById("lastName").style.display = "block";
            	document.getElementById("username").style.display = "block";
            	document.getElementById("password").style.display = "block";
            	document.getElementById("ssn").style.display = "block";
        	} else if (value === "edit") {
        		document.getElementById("customerUsername").style.display = "none";
                document.getElementById("transitLine").style.display = "none";
                document.getElementById("firstName").style.display = "none";
                document.getElementById("lastName").style.display = "none";
            	document.getElementById("username").style.display = "none";
            	document.getElementById("password").style.display = "none";
            	document.getElementById("ssn").style.display = "none";
        		document.getElementById("username").style.display = "block";
        		document.getElementById("newFirstName").style.display = "block";
            	document.getElementById("newLastName").style.display = "block";
            	document.getElementById("newPassword").style.display = "block";
        	} else if (value === "delete") {
        		document.getElementById("customerUsername").style.display = "none";
                document.getElementById("transitLine").style.display = "none";
                document.getElementById("firstName").style.display = "none";
                document.getElementById("lastName").style.display = "none";
                document.getElementById("password").style.display = "none";
        		document.getElementById("username").style.display = "block";
        		document.getElementById("ssn").style.display = "block";
        		document.getElementById("newFirstName").style.display = "none";
            	document.getElementById("newLastName").style.display = "none";
            	document.getElementById("newPassword").style.display = "none";
        	}
        }
    </script>
</head>
<body>
<h1>Administrator</h1>
<h2>Welcome to your home page!</h2>
    <form method="get" action="adminResult.jsp">
        <table>
            <tr>
            	<td class="form-label">Action: </td>
	                <td>
	                    <label class="radio-option">
	                        <input type="radio" name="action" value="list" onclick="toggleField('list')"> List of Reservations
	                    </label>
	                    <label class="radio-option">
	                        <input type="radio" name="action" value="change" onclick="toggleField('change')"> Change Customer Rep Info
	                    </label>
	                    <label class="radio-option">
	                        <input type="radio" name="action" value="revenue" onclick="toggleField('revenue')"> Total Revenue Generated
	                    </label>
	                </td>
	        </tr>
	        <tr id="customerUsername" style="display:none;">
                <td class="form-label">Customer Username: </td>
                <td><input type="text" name="customer_Username" class="input-field"></td>
            </tr>
            <tr id="transitLine" style="display:none;">
                <td class="form-label">Transit Line: </td>
                <td><input type="text" name="transit_line" class="input-field"></td>
            </tr>
            <tr id="firstName" style="display:none;">
                <td class="form-label">First Name: </td>
                <td><input type="text" name="first_name" class="input-field"></td>
            </tr>
            <tr id="lastName" style="display:none;">
                <td class="form-label">Last Name: </td>
                <td><input type="text" name="last_name" class="input-field"></td>
            </tr>
            <tr id="username" style="display:none;">
                <td class="form-label">Username: </td>
                <td><input type="text" name="user_name" class="input-field"></td>
            </tr>
            <tr id="password" style="display:none;">
                <td class="form-label">Password: </td>
                <td><input type="text" name="pass_word" class="input-field"></td>
            </tr>
            <tr id="ssn" style="display:none;">
                <td class="form-label">SSN: </td>
                <td><input type="text" name="SSN" class="input-field"></td>
            </tr>
            <tr id="newFirstName" style="display:none;">
                <td class="form-label">New First Name: </td>
                <td><input type="text" name="new_first_name" class="input-field"></td>
            </tr>
            <tr id="newLastName" style="display:none;">
                <td class="form-label">New Last Name: </td>
                <td><input type="text" name="new_last_name" class="input-field"></td>
            </tr>
            <tr id="newPassword" style="display:none;">
                <td class="form-label">New Password: </td>
                <td><input type="text" name="new_pass_word" class="input-field"></td>
            </tr>
            <tr id="changeActions" style="display:none;">
            <td class="form-label">Choose Action: </td>
            <td>
                <label class="radio-option">
                    <input type="radio" name="changeAction" value="add" onclick="customerRepAction('add')"> Add
                </label>
                <label class="radio-option">
                    <input type="radio" name="changeAction" value="edit" onclick="customerRepAction('edit')"> Edit
                </label>
                <label class="radio-option">
                    <input type="radio" name="changeAction" value="delete" onclick="customerRepAction('delete')"> Delete
                </label>
            </td>
        </tr>
        </table>
        <br>
        <input type="submit" value="Search">
    </form>
<%
    

    try {
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        String queryTopCustomer = "SELECT r.username, SUM(r.total_cost) AS total_revenue " +
        		"FROM reservations r " +
        		"GROUP BY r.username " +
        		"ORDER BY total_revenue DESC " +
        		"LIMIT 1;";
        String queryActive5 = "SELECT r.line_name, COUNT(r.rid) AS total_reservations " +
        		"FROM reservations r " +
        		"GROUP BY r.line_name " +
        		"ORDER BY total_reservations DESC " +
        		"LIMIT 5;";
   		String queryMonthlyRevenue = "SELECT YEAR(r.date_ticket) AS year, " +
                "MONTH(r.date_ticket) AS month, " +
                "SUM(r.total_cost) AS total_revenue " +
                "FROM reservations r " +
                "GROUP BY YEAR(r.date_ticket), MONTH(r.date_ticket) " +
                "ORDER BY year, month;";
        if (con != null) {
        	PreparedStatement pstmt1 = con.prepareStatement(queryTopCustomer);
            ResultSet rs1 = pstmt1.executeQuery();
            PreparedStatement pstmt2 = con.prepareStatement(queryActive5);
            ResultSet rs2 = pstmt2.executeQuery();
            PreparedStatement pstmt3 = con.prepareStatement(queryMonthlyRevenue);
            ResultSet rs3 = pstmt3.executeQuery();
            %>
            <!-- Table for Top Customer -->
            <h3>Top Customer by Revenue</h3>
            <table border="1">
                <tr>
                    <th>Username</th>
                    <th>Total Revenue</th>
                </tr>
            <%
                while (rs1.next()) {
            %>
                <tr>
                    <td><%= rs1.getString("username") %></td>
                    <td><%= rs1.getDouble("total_revenue") %></td>
                </tr>
            <%
                }
            %>
            </table>
            <!-- Table for Top 5 Active Transit Lines -->
            <h3>Top 5 Most Active Transit Lines</h3>
            <table border="1">
                <tr>
                    <th>Transit Line</th>
                    <th>Reservations</th>
                </tr>
            <%
                while (rs2.next()) {
            %>
                <tr>
                    <td><%= rs2.getString("line_name") %></td>
                    <td><%= rs2.getInt("total_reservations") %></td>
                </tr>
            <%
                }
            %>
            </table>
            <h3>Sales Report Per Month</h3>
            <table border="1">
                <tr>
                    <th>Year</th>
                    <th>Month</th>
                    <th>Total Revenue</th>
                </tr>
            <%
                while (rs3.next()) {
            %>
                <tr>
                    <td><%= rs3.getInt("year") %></td>
                    <td><%= rs3.getInt("month") %></td>
                    <td><%= String.format("%.2f", rs3.getDouble("total_revenue")) %></td>
                </tr>
            <%
                }
            %>
            </table>
    <%
        }
    } catch (Exception ex) {
        out.print("<div class='message'>An error occurred: " + ex.getMessage() + "</div>");
    }
%>




<form method="get" action="actionLogout.jsp">
	<input type="submit" value="Logout" class="big-button">
</form>

</body>
</html>