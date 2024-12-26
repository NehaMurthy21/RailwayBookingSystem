<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*, com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>View All Customer Queries</title>
    <style>
        .highlight {
            background-color: #ffcccc; /* Light red background */
        }
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h3>All Customer Queries</h3>

    <table>
        <thead>
            <tr>
                <th>Message ID</th>
                <th>Username</th>
                <th>Subject</th>
                <th>Question</th>
                <th>Response</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    // Establish database connection
                    ApplicationDB db = new ApplicationDB();
                    Connection con = db.getConnection();
                    
                    // Query to fetch all messages
                    String query = "SELECT mid, user, subject, content, answer FROM messaging";
                    PreparedStatement ps = con.prepareStatement(query);
                    ResultSet rs = ps.executeQuery();

                    // Loop through the results and display each message
                    while (rs.next()) {
                        String mid = rs.getString("mid");
                        String username = rs.getString("user");
                        String subject = rs.getString("subject");
                        String question = rs.getString("content");
                        String answerText = rs.getString("answer");

                        // Highlight rows where no response is provided
                        boolean noResponse = (answerText == null || answerText.trim().isEmpty());

                        out.println("<tr" + (noResponse ? " class='highlight'" : "") + ">");
                        out.println("<td>" + mid + "</td>");
                        out.println("<td>" + username + "</td>");
                        out.println("<td>" + subject + "</td>");
                        out.println("<td>" + question + "</td>");
                        out.println("<td>" + (noResponse ? "No response yet" : answerText) + "</td>");
                        out.println("</tr>");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </tbody>
    </table>

    <!-- Link to go back -->
    <br>
    <a href="customerRep.jsp">Back to Customer Representative Page</a>
</body>
</html>
