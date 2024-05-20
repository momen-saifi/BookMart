<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<%@page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>EBook: Register</title>
<%@include file="all_component/allCss.jsp"%>
<script>
    function togglePassword(inputId, iconId) {
        var passwordField = document.getElementById(inputId);
        var passwordIcon = document.getElementById(iconId);

        if (passwordField.type === "password") {
            passwordField.type = "text";
            passwordIcon.className = "fas fa-eye-slash";
        } else {
            passwordField.type = "password";
            passwordIcon.className = "fas fa-eye";
        }
    }

    function validatePassword() {
        var password = document.getElementById("exampleInputPassword1").value;
        var confirmPassword = document.getElementById("confirmPassword").value;
        var passwordError = document.getElementById("passwordError");
        var confirmError = document.getElementById("confirmError");

        var passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%&*()-+=^])(?!.*\s).{8,20}$/;

        if (!passwordPattern.test(password)) {
            passwordError.innerHTML = "Password must contain at least 8 characters, one digit, one uppercase letter, one lowercase letter, one special character, and no whitespace.";
            return false;
        } else {
            passwordError.innerHTML = "";
        }

        if (password !== confirmPassword) {
            confirmError.innerHTML = "Passwords do not match.";
            return false;
        } else {
            confirmError.innerHTML = "";
        }

        return true;
    }

    function validateMobileNumber() {
        var mobileNumber = document.getElementById("mobileNumber").value;
        var mobileNumberPattern = /^(0|91)?[7-9][0-9]{9}$/;
        var mobileError = document.getElementById("mobileError");

        if (!mobileNumberPattern.test(mobileNumber)) {
            mobileError.innerHTML = "Please enter a valid mobile number.";
            return false;
        } else {
            mobileError.innerHTML = "";
        }

        return true;
    }
</script>
</head>
<body style="background-color: #f0f1f2;">

    <%@include file="all_component/navbar.jsp"%>
    <div class="container p-2">
        <div class="row">
            <div class="col-md-4 offset-md-4">
                <div class="card">
                    <div class="card-body">
                        <h4 class="text-center">Registration Page</h4>

                        <c:if test="${not empty failedMsg}">
                            <p class="text-center text-danger">${failedMsg}</p>
                            <c:remove var="failedMsg" scope="session"/>
                        </c:if>

                        <form action="register" method="post" onsubmit="return validatePassword() && validateMobileNumber()">
                            <div class="form-group">
                                <label for="exampleInputEmail1">Enter Full Name</label> 
                                <input type="text" class="form-control" id="exampleInputEmail1" 
                                    aria-describedby="emailHelp" required="required" name="fname">
                            </div>

                            <div class="form-group">
                                <label for="exampleInputEmail1">Email address</label> 
                                <input type="email" class="form-control" id="exampleInputEmail1" 
                                    aria-describedby="emailHelp" required="required" name="email">
                            </div>

                            <div class="form-group">
                                <label for="mobileNumber">Mobile Number</label> 
                                <input type="text" class="form-control" id="mobileNumber" 
                                    required="required" name="phno">
                                <small id="mobileError" class="text-danger"></small>
                            </div>

                            <div class="form-group">
                                <label for="exampleInputPassword1">Password</label> 
                                <div class="input-group">
                                    <input type="password" class="form-control" id="exampleInputPassword1" 
                                        required="required" name="password">
                                    <div class="input-group-append">
                                        <span class="input-group-text">
                                            <i id="passwordIcon1" class="fas fa-eye" onclick="togglePassword('exampleInputPassword1', 'passwordIcon1')"></i>
                                        </span>
                                    </div>
                                </div>
                                <small id="passwordError" class="text-danger"></small>
                            </div>

                            <div class="form-group">
                                <label for="confirmPassword">Confirm Password</label> 
                                <div class="input-group">
                                    <input type="password" class="form-control" id="confirmPassword" 
                                        required="required">
                                    <div class="input-group-append">
                                        <span class="input-group-text">
                                            <i id="passwordIcon2" class="fas fa-eye" onclick="togglePassword('confirmPassword', 'passwordIcon2')"></i>
                                        </span>
                                    </div>
                                </div>
                                <small id="confirmError" class="text-danger"></small>
                            </div>

                            <div class="form-group form-check">
                                <input type="checkbox" class="form-check-input" name="check" id="exampleCheck1"> 
                                <label class="form-check-label" for="exampleCheck1">Agree term & Condition</label>
                            </div>

                            <button type="submit" class="btn btn-primary">Submit</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@include file="all_component/footer.jsp"%>
</body>
</html>
