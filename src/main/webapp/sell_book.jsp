<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sell Book</title>
<%@include file="all_component/allCss.jsp"%>
</head>
<body style="background-color: #f0f1f2;">

	<c:if test="${empty userobj }">
		<c:redirect url="login.jsp"></c:redirect>
	</c:if>
	<%@include file="all_component/navbar.jsp"%>
	<div class="container">

		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-body">
						<h5 class="text-center text-primary p-1">Sell Old Book</h5>
						<c:if test="${not empty succMsg }">
							<div class="alert alert-success" role="alert">${succMsg }</div>
							<c:remove var="succMsg" scope="session" />
						</c:if>

						<c:if test="${not empty failedMsg }">
							<div class="alert alert-danger" role="alert">${failedMsg }</div>
							<c:remove var="failedMsg" scope="session" />
						</c:if>

						<form action="add_old_book" method="post"
							enctype="multipart/form-data">
							<input type="hidden" value="${userobj.email }" name="user">
							<div class="form-group">
								<label for="exampleInputEmail">Book Name*</label><input
									name="bname" type="text" class="form-control"
									id="exampleInputEmail" aria-describedby="emailHelp">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail">Author Name*</label><input
									name="author" type="text" class="form-control"
									id="exampleInputEmail" aria-describedby="emailHelp">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail">Price*</label><input name="price"
									type="number" class="form-control" id="exampleInputEmail">
							</div>
							<div class="form-group">
								<label for="exampleFormControlFile1">Upload Photo</label><input
									name="bimg" type="file" class="form-control-file"
									id="exampleFormControlFile1">
							</div>
							<button type="submit" class="btn btn-primary">Sell</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
