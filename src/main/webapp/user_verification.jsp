<%@page import="com.DB.DBConnect"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="com.DAO.BookDAOImpl"%>
<%@page import="com.DB.BookDtls"%>
<%@page import="java.util.*"%>
<%@page import="com.entity.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ebook: Index</title>
<%@include file="all_component/allCss.jsp"%>

<style type="text/css">
.back-img {
	background: url("img/bc.jpg");
	height: 50vh;
	width: 100%;
	background-repeat: no-repeat;
	background-size: cover;
}

.crd-ho:hover {
	background-color: #fcf7f7;
}
</style>
</head>
<body style="background-color: #f7f6f7;">

	<%
	User u = (User) session.getAttribute("user");
	%>

	<span>We already sent a verification code to your email.</span>

	<form id="otpForm">
		<input type="text" id="authcode" name="authcode" required> <input
			type="submit" value="Verify">
	</form>

	<div id="passwordForm" style="display: none;">
		<h3>Update Password</h3>
		<form id="updatePasswordForm" onsubmit="updatePassword(event)"
			method="post">
			<input type="hidden" id="email" name="email"> <input
				type="password" id="password" name="password" required> <input
				type="submit" value="Update Password">
		</form>
	</div>

	<script>
    function updatePassword(event) {
        event.preventDefault(); // Prevent form submission
        
        // Get email and password from form fields
        var email = document.getElementById("email").value;
        var password = document.getElementById("password").value;

        // Create a hidden form to send email and password via POST request
        var form = document.createElement("form");
        form.setAttribute("action", "forgot_password");
        form.setAttribute("method", "post");
        form.style.display = "none"; // Hide the form
        
        // Add email and password as hidden input fields to the form
        var emailInput = document.createElement("input");
        emailInput.setAttribute("type", "hidden");
        emailInput.setAttribute("name", "email");
        emailInput.setAttribute("value", email);
        form.appendChild(emailInput);
        
        var passwordInput = document.createElement("input");
        passwordInput.setAttribute("type", "hidden");
        passwordInput.setAttribute("name", "password");
        passwordInput.setAttribute("value", password);
        form.appendChild(passwordInput);
        
        // Append the form to the document body and submit it
        document.body.appendChild(form);
        form.submit();
    }

    var incorrectAttempts = 0;

    document.getElementById("otpForm").addEventListener("submit", function(event) {
        event.preventDefault(); // Prevent form submission

        var enteredOTP = document.getElementById("authcode").value;
        
        // Get the code from the session using a JSP variable
        var sessionCode = "<%= u.getCode() %>";

        // Compare the entered OTP with the session code
        if (enteredOTP === sessionCode) {
            // OTP verification successful, show password update form
            document.getElementById("passwordForm").style.display = "block";

            // Hide the OTP form
            document.getElementById("otpForm").style.display = "none";

            // Set email in the hidden field
            var email = '<%= u.getEmail() %>';
            document.getElementById("email").value = email;
        } else {
            // Increment the number of incorrect attempts
            incorrectAttempts++;

            // Display error message for the first three attempts
            if (incorrectAttempts <= 3) {
                alert("Invalid OTP. Please try again.");
            }

            // If more than three attempts, redirect to forgot_pass.jsp
            if (incorrectAttempts > 3) {
                window.location.href = "forgot_pass.jsp";
            }
            setTimeout(function() {
                window.location.href = "forgot_pass.jsp";
            }, 300000);
        }
    });

</body>
</html>
