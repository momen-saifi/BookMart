<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Address</title>
<%@include file="all_component/allCss.jsp"%>
</head>
<body style="background-color: #f0f1f2;">
	<%@page errorPage="error_page.jsp"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:if test="${ empty userobj }">
		<c:redirect url="login.jsp">
		</c:redirect>
	</c:if>

	<%@include file="all_component/navbar.jsp"%>
	<c:if test="${not empty succMsg }">
		<div class="alert alert-success text-center" role="alert">${succMsg }</div>
		<c:remove var="succMsg" scope="session" />
	</c:if>

	<c:if test="${not empty failedMsg }">
		<div class="alert alert-danger text-center" role="alert">${failedMsg }</div>
		<c:remove var="failedMsg" scope="session" />



	</c:if>

	<div class="container">
		<div class="row p-3">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-body">
						<h3 class="text-center text-primary p-1">Add Address for
							${userobj.name}</h3>
						<form action="user_address" method="post">
							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="address">Address</label> <input type="text"
										class="form-control" id="address" name="address"
										value="${userobj.address}">
								</div>
								<div class="form-group col-md-6">
									<label for="landmark">Landmark</label> <input type="text"
										class="form-control" id="landmark" name="landmark"
										value="${userobj.landmark}">
								</div>
							</div>
							<div class="form-row">
								<div class="form-group col-md-4">
									<label for="city">City</label> <input type="text"
										class="form-control" id="city" name="city"
										value="${userobj.city}">
								</div>
								<div class="form-group col-md-4">
									<label for="state">State</label> <input type="text"
										class="form-control" id="state" name="state"
										value="${userobj.state}">
								</div>
								<div class="form-group col-md-4">
									<label for="pincode">Pincode</label> <input type="number"
										class="form-control" id="pincode" name="pincode"
										value="${userobj.pincode}">
								</div>
							</div>
							<div class="text-center">
								<button type="submit" class="btn btn-warning text-white">Add
									Address</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
