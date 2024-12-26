<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Send Message</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            color: #007bff;
        }
        label {
            font-weight: bold;
        }
        textarea, input[type="text"], input[type="submit"] {
            padding: 10px;
            font-size: 14px;
            margin: 5px 0;
            width: 100%;
            max-width: 600px;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>Send a Message to the Customer Representative</h1>

    <!-- Form for submitting a message -->
    <form method="post" action="sendMessage.jsp">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br><br>
        
        <label for="subject">Subject:</label>
        <input type="text" id="subject" name="subject" required><br><br>
        
        <label for="content">Message:</label><br>
        <textarea id="content" name="content" rows="5" required></textarea><br><br>

        <input type="submit" value="Send Message">
    </form>

    <br><br>
    <a href="customer.jsp">Back to Customer Page</a>

    <% 
        // Process the message submission if the form is submitted
        String username = request.getParameter("username");
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");

        if (username != null && !username.isEmpty() && subject != null && !subject.isEmpty() && content != null && !content.isEmpty()) {
            try {
                // Database connection and message insertion
                ApplicationDB db = new ApplicationDB();
                Connection con = db.getConnection();

                String query = "INSERT INTO messaging (user, subject, content, answer) VALUES (?, ?, ?, NULL)";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, username);  // Use the entered username
                ps.setString(2, subject);   // Subject of the message
                ps.setString(3, content);   // Content of the message

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    out.println("<h2>Message Sent Successfully!</h2>");
                    out.println("<p>Your message has been sent to the customer representative. You will receive a response soon.</p>");
                } else {
                    out.println("<p>Error: There was an issue sending your message. Please try again.</p>");
                }

                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>

</body>
</html>
