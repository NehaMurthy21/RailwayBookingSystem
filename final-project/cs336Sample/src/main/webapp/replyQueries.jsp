<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Reply to Customer Queries</title>
</head>
<body>
    <h3>Reply to Customer Queries</h3>

    <!-- Always show the form to enter queryId and response -->
    <form action="replyQueries.jsp" method="post">
        <label for="queryId">Query ID:</label>
        <input type="text" id="queryId" name="queryId" required><br><br>

        <label for="response">Response:</label><br>
        <textarea id="response" name="response" rows="4" cols="50" required></textarea><br><br>

        <button type="submit">Submit Response</button>
    </form>

    <% 
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String queryId = request.getParameter("queryId");
            String responseToQuestion = request.getParameter("response");

            try {
                ApplicationDB db = new ApplicationDB();
                Connection con = db.getConnection();
                PreparedStatement ps = con.prepareStatement("UPDATE messaging SET answer = ? WHERE mid = ?");
                
                ps.setString(1, responseToQuestion);
                ps.setString(2, queryId);
                int rows = ps.executeUpdate();
                out.println("<p>" + (rows > 0 ? "Response submitted successfully!" : "Failed to submit the response.") + "</p>");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
    
     <br>
        <a href="customerRep.jsp">Back to Customer Representative Page</a>
</body>
</html>
