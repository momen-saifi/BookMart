<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Orders</title>
<%@include file="allCss.jsp"%>
<style type="text/css">
a {
	text-decoration: none;
	color: black;
}

a:hover {
	text-decoration: none;
	color: black;
}
</style>
</head>
<body>
	<%@include file="navbar.jsp"%>

	<c:if test="${empty userobj }">
		<c:redirect url="../login.jsp"></c:redirect>
	</c:if>

<div class="container">
		<div class="row p-5">
	<div class="col-md-3">

		<div class="card ">
			<a href="new_orders.jsp">
				<div class="card-body text-center ">
					<i class="fas fa-box-open fa-3x text-warning"></i>
					<h4>Orders</h4>
					-----------
				</div>
		</div>
		</a>

	</div>
	<div class="col-md-3">

		<div class="card ">
			<a href="cancled_order.jsp">
				<div class="card-body text-center ">
					<i class="fas fa-box-open fa-3x text-warning"></i>
					<h4>Cancled Orders</h4>
					-----------
				</div>
		</div>
		</a>
	</div>

	<div class="col-md-3">

		<div class="card ">
			<a href="shiped_order.jsp">
				<div class="card-body text-center ">
					<i class="fas fa-box-open fa-3x text-warning"></i>
					<h4>Shiped Orders</h4>
					-----------
				</div>
		</div>
		</a>
	</div>
	<div class="col-md-3">

		<div class="card ">
			<a href="dispatched_order.jsp">
				<div class="card-body text-center ">
					<i class="fas fa-box-open fa-3x text-warning"></i>
					<h4>Dispatched Orders</h4>
					-----------
				</div>
		</div>
		</a>
	</div>


</div>
	</div>
	

	<div style="margin-top: 220px;">
		<%@include file="footer.jsp"%></div>
</body>
</html>