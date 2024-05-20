<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@page errorPage="error_page.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ebook: Login</title>
<%@include file="all_component/allCss.jsp"%>

<!-- JavaScript to show password -->
<script>
function togglePasswordVisibility() {
    var passwordInput = document.getElementById("exampleInputPassword1");
    if (passwordInput.type === "password") {
        passwordInput.type = "text";
    } else {
        passwordInput.type = "password";
    }
}
</script>

<style>
.show-password-btn {
    position: absolute;
    right: 10px;
    top: 10px;
    cursor: pointer;
}
</style>

</head>
<body style="background-color: #f0f1f2;">

<%@include file="all_component/navbar.jsp"%>
<div class="container p-2">
    <div class="row mt-2">
        <div class="col-md-4 offset-md-4">
            <div class="card">
                <div class="card-body">
                    <h3 class="text-center">Login Page</h3>

                    <c:if test="${not empty succMsg}">
                        <p class="text-center text-success">${succMsg}</p>
                        <c:remove var="succMsg" scope="session"/>
                    </c:if>
                    
                    <c:if test="${not empty failedMsg}">
                        <h5 class="text-center text-danger">${failedMsg}</h5>
                        <c:remove var="failedMsg" scope="session" />
                    </c:if>

                    <form action="login" method="post">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Email address</label>
                            <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" required="required" name="email">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">Password</label>
                            <div class="position-relative">
                                <input type="password" class="form-control" id="exampleInputPassword1" required="required" name="password">
                                <i class="fas fa-eye show-password-btn" onclick="togglePasswordVisibility()"></i>
                            </div>
                        </div>

                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">Login</button>
                            <br> <a href="register.jsp">Create Account</a>
                        </div>
                        <br> <a href="forgot_pass.jsp">Forgot Password</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="all_component/footer.jsp"%>
</body>
</html>
