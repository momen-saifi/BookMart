<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.DAO.UserDAOImpl" %>
<%@ page import="com.entity.User" %>
<%@ page import="com.DB.DBConnect"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.*"%>
<%@page errorPage="error_page.jsp"%>
<%
    // Initialize variables
    UserDAOImpl userdao = new UserDAOImpl(DBConnect.getConn());
    User user = null;

    // Retrieve user profile data based on the email parameter
    String email = request.getParameter("email");
    if (email != null) {
        user = userdao.userProfile(email);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <!-- Include any necessary CSS or JavaScript files here -->
</head>
<body>
    <div>
       
        <% if (user != null) { %>
            <table class="table">
                <tbody>
                    <tr>
                        <th scope="row">ID :</th>
                        <td><%= user.getId() %></td>
                    </tr>
                    <tr>
                        <th scope="row">Email :</th>
                        <td><%= user.getEmail() %></td>
                    </tr>
                    <tr>
                        <th scope="row">Name :</th>
                        <td><%= user.getName() %></td>
                    </tr>
                    <tr>
                        <th scope="row">Phone :</th>
                        <td><%= user.getPhno() %></td>
                    </tr>
                    <!-- Add more user profile fields as needed -->
                </tbody>
            </table>
        <% } else { %>
            <!-- Display a message if user profile data is not available -->
            <p>No user profile data available.</p>
        <% } %>
    </div>
</body>
</html>
