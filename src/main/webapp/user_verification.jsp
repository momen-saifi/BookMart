<%@page import="com.DB.DBConnect"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="com.DAO.BookDAOImpl"%>
<%@page import="com.DB.BookDtls"%>
<%@page import="java.util.*"%>
<%@page import="com.entity.User"%>
<%@page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ebook: Index</title>
<%@include file="all_component/allCss.jsp"%>

<style type="text/css">
s.back-img {
    background: url("img/bc.jpg");
    height: 50vh;
    width: 100%;
    background-repeat: no-repeat;
    background-size: cover;
}

.crd-ho:hover {
    background-color: #fcf7f7;
}
body {
    background-color: #f7f6f7;
    font-family: Arial, sans-serif;
    text-align: center;
    color: #333; /* Text color */
}

.container {
    max-width: 400px;
    margin: 50px auto;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.message span {
    font-weight: bold;
    color: #007bff; /* Blue color */
}

.form-group {
    margin-bottom: 20px;
}

.form-group input[type="text"],
.form-group input[type="password"],
.form-group input[type="submit"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    outline: none; /* Remove default input focus outline */
}

.form-group input[type="submit"] {
    background-color: #007bff; /* Blue button color */
    color: #fff; /* Button text color */
    cursor: pointer;
}

.form-group input[type="submit"]:hover {
    background-color: #0056b3; /* Darker blue on hover */
}

.attempts {
    color: #ff0000; /* Error message color */
}

#passwordForm h3 {
    margin-top: 0;
    font-size: 20px;
    color: #007bff;
}

.password-toggle {
    position: relative;
}

.password-toggle .toggle-password {
    position: absolute;
    top: 50%;
    right: 10px;
    transform: translateY(-50%);
    cursor: pointer;
}
</style>
</head>
<body style="background-color: #f7f6f7;">

<%
// Get user information from session
User u = (User) session.getAttribute("user");
%>
<div class="container">
    <div class="message">
        <span>We have sent a verification code to your email.</span>
    </div>

    <form id="otpForm" class="form-group" onsubmit="verifyOTP(event)">
        <input type="text" id="authcode" name="authcode" required placeholder="Enter verification code">
        <input type="submit" value="Verify">
        <div class="attempts"></div>
    </form>

    <div id="passwordForm" style="display: none;">
        <h3>Update Password</h3>
        <form id="updatePasswordForm" method="post">
            <input type="hidden" id="email" name="email">
            <div class="form-group password-toggle">
                <input type="password" id="password" name="password" required placeholder="Enter new password">
                <i class="fa fa-eye toggle-password" onclick="togglePassword('password')"></i>
            </div>
            <div class="form-group password-toggle">
                <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Confirm new password">
                <i class="fa fa-eye toggle-password" onclick="togglePassword('confirmPassword')"></i>
            </div>
            <input type="submit" value="Update Password" onclick="updatePassword(event)">
            <small id="passwordError" class="text-danger"></small> <!-- Display password pattern error -->
        </form>
    </div>

    <div id="countdown" style="margin-top: 20px;"></div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" integrity="sha512-IGVflYh6Dl0PPjMfpnXZjUSC6+FdL9m3FTcH5BC0t0FJwIKmE0Ot9wYfNuf5P7Kb+Z83XfHsBYJyUcGo6+lKzA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
// Countdown timer from 5 to 0 minutes
var countdownElement = document.getElementById("countdown");
var minutes = 5;
var seconds = 0;

function updateCountdown() {
    countdownElement.innerHTML = minutes + " : " + (seconds < 10 ? "0" + seconds : seconds);

    if (minutes == 0 && seconds == 0) {
        clearInterval(countdownInterval);
        // Redirect to forgot_pass.jsp after 5 minutes
        window.location.href = "forgot_pass.jsp";
    } else {
        if (seconds == 0) {
            minutes--;
            seconds = 59;
        } else {
            seconds--;
        }
    }
}

// Update countdown every second
var countdownInterval = setInterval(updateCountdown, 1000);

function updatePassword(event) {
    event.preventDefault(); // Prevent form submission

    // Get email and password from form fields
    var email = document.getElementById("email").value;
    var password = document.getElementById("password").value;
    var confirmPassword = document.getElementById("confirmPassword").value;

    // Validate password pattern
    var passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%&*()-+=^])(?!.*\s).{8,20}$/;
    if (!passwordPattern.test(password)) {
        document.getElementById("passwordError").innerHTML = "Password must contain at least 8 characters, one digit, one uppercase letter, one lowercase letter, one special character, and no whitespace.";
        return false; // Prevent form submission
    }

    // Validate if passwords match
    if (password !== confirmPassword) {
        document.getElementById("passwordError").innerHTML = "Passwords do not match.";
        return false; // Prevent form submission
    }

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

function togglePassword(inputId) {
    var passwordField = document.getElementById(inputId);
    if (passwordField.type === "password") {
        passwordField.type = "text";
    } else {
        passwordField.type = "password";
    }
}
</script>

</body>
</html>