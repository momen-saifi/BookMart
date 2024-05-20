<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@page errorPage="error_page.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Forgot Password</title>
<%@include file="all_component/allCss.jsp"%>
<style>
    /* Style for the footer */
    .footer {
        position: fixed;
        left: 0;
        bottom: 0;
        width: 100%;
        background-color: #f8f9fa;
        text-align: center;
        padding: 10px 0;
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
                        <h3 class="text-center">Forgot Password</h3>

                        <c:if test="${not empty failedMsg}">
                            <h5 class="text-center text-danger">${failedMsg}</h5>
                            <c:remove var="failedMsg" scope="session" />
                        </c:if>

                        <form action="user_verify" method="post">
                            <div class="form-group">
                                <label for="exampleInputEmail1">Email address</label>
                                <input type="email" class="form-control" id="exampleInputEmail1"
                                    aria-describedby="emailHelp " required="required" name="email">
                            </div>

                            <div class="text-center">
                                <button type="submit" class="btn btn-primary">Forgot Password</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="footer">
        <%@include file="all_component/footer.jsp"%>
    </div>
</body>
</html>
