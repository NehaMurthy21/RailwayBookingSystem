<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*, com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>View All Messages</title>
    <script>
        function filterMessages() {
            const query = document.getElementById("searchBar").value.toLowerCase();
            const rows = document.querySelectorAll("tbody tr");

            rows.forEach(row => {
                const content = row.innerText.toLowerCase();
                if (content.includes(query)) {
                    row.style.display = ""; // Show the row
                } else {
                    row.style.display = "none"; // Hide the row
                }
            });
        }
    </script>
</head>
<body>
    <h3>All Customer Messages</h3>

    <!-- Search Bar -->
    <input type="text" id="searchBar" onkeyup="filterMessages()" placeholder="Search messages..." />

    <!-- Messages Table -->
    <table border="1">
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

                        out.println("<tr>");
                        out.println("<td>" + mid + "</td>");
                        out.println("<td>" + username + "</td>");
                        out.println("<td>" + subject + "</td>");
                        out.println("<td>" + question + "</td>");
                        out.println("<td>" + (answerText != null ? answerText : "No response yet") + "</td>");
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
    <a href="customer.jsp">Back to Customer Page</a>
</body>
</html>
