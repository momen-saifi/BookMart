<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@page errorPage="error_page.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Setting</title>
<%@include file="all_component/allCss.jsp"%>
<style type="text/css">
a {
	text-decoration: none;
	color: black;
}

a:hover {
	text-decoration: none;
}
</style>
</head>
<body style="background-color: #f7f6f7;">


	<c:if test="${ empty userobj }">
		<c:redirect url="login.jsp">
		</c:redirect>
	</c:if>

	<%@include file="all_component/navbar.jsp"%>

	<div class="container">


		<h3 class="text-center">Hello, ${userobj.name }</h3>
		<div class="row p-5">
<div class="col-md-4">
    <a href="sell_book.jsp">
        <div class="card">
            <div class="card-body text-center">
                <div class="text-success">
                    <i class="fas fa-book fa-3x"></i>
                </div>
                <h4>Sell Old Book</h4>
            </div>
        </div>
    </a>
</div>


<div class="col-md-4">
    <a href="old_book.jsp">
        <div class="card">
            <div class="card-body text-center">
                <div class="text-warning">
                    <i class="fas fa-edit fa-3x"></i>
                </div>
                <h4>Update Old Book</h4>
            </div>
        </div>
    </a>
</div>


			<div class="col-md-4">
    <a href="edit_profile.jsp">
        <div class="card">
            <div class="card-body text-center">
                <div class="text-info">
                    <i class="fas fa-user-edit fa-3x"></i>
                </div>
                <h4>Edit Profile</h4>
            </div>
        </div>
    </a>
</div>

	<div class="col-md-4 mt-3">
    <a href="order.jsp">
        <div class="card">
            <div class="card-body text-center">
                <div class="text-success">
                    <i class="fas fa-shopping-bag fa-3x"></i>
                </div>
                <h4>My Order</h4>
                <p>Track Your Order</p>
            </div>
        </div>
    </a>
</div>

			<div class="col-md-4 mt-3">
    <a href="user_address.jsp">
        <div class="card">
            <div class="card-body text-center">
                <div class="text-info">
                    <i class="fas fa-address-card fa-3x"></i>
                </div>
                <h4>User Address</h4>
                <p>Add or Update Address</p>
            </div>
        </div>
    </a>
</div>
			
			
	<div class="col-md-4 mt-3">
    <a href="helpline.jsp">
        <div class="card">
            <div class="card-body text-center">
                <div class="text-purple">
                    <i class="fas fa-question-circle fa-3x"></i>
                </div>
                <h4>Help Center</h4>
                <p>24 * 7 Service</p>
            </div>
        </div>
    </a>
</div>

		</div>
	</div>
	<%@include file="all_component/footer.jsp"%>
</body>
</html>