<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.entity.User"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.ServletException"%>
<%@ page import="javax.servlet.annotation.WebServlet"%>
<%@ page import="javax.servlet.http.HttpServlet"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Email Verification</title>
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
            width: calc(100% - 22px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none; /* Remove default input focus outline */
        }
        .form-group input[type="submit"] {
            background-color: #007bff; /* Blue button color */
            color: #fff; /* Button text color */
            cursor: pointer;
            width: 100%;
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
</style>
</head>
<body>

<%
    // Get user information from session
    User userdata = (User) session.getAttribute("userdata");
    User usercod = (User) session.getAttribute("usercod");
%>

	<c:if test="${ empty userdata }">
		<c:redirect url="login.jsp">
		</c:redirect>
	</c:if>
	
	<c:if test="${ empty usercod }">
		<c:redirect url="login.jsp">
		</c:redirect>
	</c:if>
<div class="container">
    <div class="message">
        <span>We have sent a verification code to your email.</span>
    </div>

    <form id="otpForm" class="form-group" onsubmit="verifyOTP(event)">
        <input type="text" id="authcode" name="authcode" required placeholder="Enter verification code">
        <input type="submit" value="Verify">
        <div class="attempts"></div>
    </form>

    <div id="countdown" style="margin-top: 20px;"></div>
</div>

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
            window.location.href = "register.jsp";
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

    var incorrectAttempts = 0;

    document.getElementById("otpForm").addEventListener("submit", function(event) {
        event.preventDefault(); // Prevent form submission

        var enteredOTP = document.getElementById("authcode").value;

        // Compare the entered OTP with the session code
         var sessionCode = "<%= usercod.getCode() %>";
         console.log("v"+enteredOTP,"    ",sessionCode);
        if (enteredOTP === sessionCode) {
            // OTP verification successful, show password update form
            var form = document.createElement("form");
            form.setAttribute("action", "VerifyCode");
            form.setAttribute("method", "post");
            form.style.display = "none"; // Hide the form
            console.log(sessionCode);

            var authcodeInput = document.createElement("input");
            authcodeInput.setAttribute("type", "hidden");
            authcodeInput.setAttribute("name", "userdata");
            authcodeInput.setAttribute("value", enteredOTP);
            form.appendChild(authcodeInput);

            document.body.appendChild(form);
            form.submit();
        } else {
            // Increment the number of incorrect attempts
            incorrectAttempts++;

            // Display error message for the first three attempts
            if (incorrectAttempts <= 3) {
                alert("Invalid OTP. Please try again.");
            }

            // If more than three attempts, redirect to forgot_pass.jsp
            if (incorrectAttempts > 3) {
                window.location.href = "register.jsp";
            }
        }
    });
</script>

</body>
</html>
