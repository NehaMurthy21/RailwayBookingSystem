<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Results</title>
</head>
<body>
<%
    String action = request.getParameter("action");
    try {
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        String query = "";
        ResultSet rs = null;
        
        boolean custName = false;
        boolean noResult = false;
        String customerUsername = null;
        String transitLine = null;
        int result = 0;
        if (con != null) {
        	if (action == null) {
        		noResult = true;
        	} else if (action.equals("list")) {
        		customerUsername = request.getParameter("customer_Username");
        	    transitLine = request.getParameter("transit_line");
        	    if (customerUsername != "") {
        	    	query = "SELECT r.rid, r.username, r.date_ticket, r.date_reserved, r.total_cost, r.trip, r.line_name, r.status " +
        	    			"FROM reservations r " +
        	    			"WHERE r.username = ?;";;

        	    	PreparedStatement pstmt = con.prepareStatement(query);
                    pstmt.setString(1, customerUsername);
                    rs = pstmt.executeQuery();
        	    } else if (transitLine != "") {
   	    	        query = "SELECT r.rid, r.username, r.date_ticket, r.date_reserved, r.total_cost, r.trip, r.line_name, r.status " +
           	    			"FROM reservations r " +
           	    			"WHERE r.line_name = ?;";
        	    	PreparedStatement pstmt = con.prepareStatement(query);
                    pstmt.setString(1, transitLine);
                    rs = pstmt.executeQuery();
        	    } else {
        	    	noResult = true;
        	    }
        	    
        	} else if (action.equals("change")) {
        		String changeAction = request.getParameter("changeAction");
        		if (changeAction == null) {
        			noResult = true;
        		} else if (changeAction.equals("add")) {
        			String firstName = request.getParameter("first_name");
        		    String lastName = request.getParameter("last_name");
        		    String username = request.getParameter("user_name");
        		    String password = request.getParameter("pass_word");
        		    String ssn = request.getParameter("SSN");
        		    query = "INSERT INTO users (username, password, email, ssn, fname, lname, role) VALUES (?, ?, ?, ?, ?, ?, 'customer_service_rep');";
					if (firstName != "" && lastName != "" && username != "" && password != "" && ssn != "") {
						PreparedStatement pstmt = con.prepareStatement(query);
	        		    pstmt.setString(1, username);
	        		    pstmt.setString(2, password);
	        		    pstmt.setString(3, null);
	        		    pstmt.setString(4, ssn);
	        		    pstmt.setString(5, firstName);
	        		    pstmt.setString(6, lastName);
	                    result = pstmt.executeUpdate();
					} else {
						noResult = true;
					}
        		    
                    
        		} else if (changeAction.equals("edit")) {
        			String username = request.getParameter("user_name");
        		    String newFirstName = request.getParameter("new_first_name");
        		    String newLastName = request.getParameter("new_last_name");
        		    String newPassword = request.getParameter("new_pass_word");
        		    query = "UPDATE users SET password = ?, fname = ?, lname = ? WHERE username = ? AND role = 'customer_service_rep';";
        		    if ((newFirstName != "" || newLastName != "" || newPassword != "") && username != "") {
        		    	PreparedStatement pstmt = con.prepareStatement(query);
             		    pstmt.setString(1, newPassword);
             		    pstmt.setString(2, newFirstName);
             		    pstmt.setString(3, newLastName);
             		    pstmt.setString(4, username);
             		    result = pstmt.executeUpdate();
					} else {
						noResult = true;
					}
        		   
                    
        		} else if (changeAction.equals("delete")) {
        			String username = request.getParameter("user_name");
        			query = "DELETE FROM users WHERE username = ? AND role = 'customer_service_rep';";
        			if (username != "") {
        				PreparedStatement pstmt = con.prepareStatement(query);
            			pstmt.setString(1, username);
            			result = pstmt.executeUpdate();
        			} else {
        				noResult = true;
        			}
        			
                    
        		} else {
        			noResult = true;
        		}
        		
        	} else if (action.equals("revenue")) {
        		customerUsername = request.getParameter("customer_Username");
        	    transitLine = request.getParameter("transit_line");
        	    if (customerUsername != "") {
        	    	query = "SELECT SUM(r.total_cost) AS total_revenue " +
        	    			"FROM reservations r " +
        	    			"WHERE r.username = ?;";

        	    	PreparedStatement pstmt = con.prepareStatement(query);
                    pstmt.setString(1, customerUsername);
                    rs = pstmt.executeQuery();
                    custName = true;
                    
        	    } else if (transitLine != "") {
        	    	query = "SELECT SUM(r.total_cost) AS total_revenue " +
        	    			"FROM reservations r " +
        	    			"WHERE r.line_name = ?;";
        	    	PreparedStatement pstmt = con.prepareStatement(query);
                    pstmt.setString(1, transitLine);
                    rs = pstmt.executeQuery();
        	    } else {
        	    	noResult = true;
        	    }
        	}
        	if (noResult) {
        		%>
        		<h2>Invalid Input!</h2>
        		<form method="get" action="admin.jsp">
					<input type="submit" value="Go Back" class="big-button">
				</form>
        		<%
        	} else {
        		%>
        		
            	<h2>Results</h2>
            	<table border="1">
            	    <thead>
            	        <tr>
            	            <% if ("list".equals(action)) { %>
            	                <th>Reservation ID</th>
            	                <th>Date of Travel</th>
            	                <th>Date Reserved</th>
            	                <th>Total Cost</th>
            	                <th>Trip Type</th>
            	                <th>Customer Username</th>
            	                <th>Transit Line</th>
            	            <% } else if ("change".equals(action) && result > 0) { %>
            	                <h1>User was added/edited/deleted!</h1>
            	            <% } else if ("change".equals(action)) { %>
            	            	<h1>Invalid user!</h1>
            	            <% } else if ("revenue".equals(action)) {
            	            	if (custName) {
            	            %>		<h2>Total revenue for <%= customerUsername %></h2> <%
            	            	} else {
            	            %>		<h2>Total revenue for <%= transitLine %></h2> <%
            	            	}
            	            %>    <th>Total Revenue</th> <%
            	            } %>
            	        </tr>
            	    </thead>
            	    <tbody>
            	        <% 
            	            while (rs != null && rs.next()) {
            	                if ("list".equals(action)) {
            	        %>
            	                    <tr>
            	                        <td><%= rs.getInt("rid") %></td>
            	                        <td><%= rs.getDate("date_ticket") %></td>
            	                        <td><%= rs.getDate("date_reserved") %></td>
            	                        <td><%= rs.getDouble("total_cost") %></td>
            	                        <td><%= rs.getString("trip") %></td>
            	                        <td><%= rs.getString("username") %></td>
            	                        <td><%= rs.getString("line_name") %></td>
            	                    </tr>
            	        <% 
            	                } else if ("change".equals(action)) {
            	                    // Render rows for "change" action if applicable
            	                } else if ("revenue".equals(action)) {
            	                	if (custName) {
            	        %>
            	                    <tr>
            	                        <td><%= rs.getDouble("total_revenue") %></td>
            	                    </tr>
            	        <% 
            	                	} else {
            	        %>
                	                    <tr>
                	                        
                	                        <td><%= rs.getDouble("total_revenue") %></td>
                	                    </tr>
                	    <%         		
            	                	}
            	                }
            	            } 
            	        %>
            	    </tbody>
            	</table>
				<form method="get" action="admin.jsp">
					<input type="submit" value="Go Back" class="big-button">
				</form>
    <%
        	}

        } else {
            out.print("<div class='message'>Failed to connect to the database.</div>");
        }
    } catch (Exception ex) {
        out.print("<div class='message'>An error occurred: " + ex.getMessage() + "</div>");
    }


%>
</body>
</html>