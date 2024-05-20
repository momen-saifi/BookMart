<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>
<%@include file="all_component/allCss.jsp"%>

<!-- Add custom CSS for eye toggle -->
<style>
.eye-icon {
	cursor: pointer;
	position: absolute;
	right: 10px;
	top: 50%;
	transform: translateY(-50%);
}
</style>

</head>
<body style="background-color: #f0f1f2;">
	<%@include file="all_component/navbar.jsp"%>
	<c:if test="${ empty userobj }">
		<c:redirect url="login.jsp">
		</c:redirect>
	</c:if>
	<div class="container">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-body">
						<h5 class="text-center text-primary p-1">Edit Profile</h5>
						<c:if test="${not empty succMsg}">
							<h5 class="text-center text-success">${succMsg}</h5>
							<c:remove var="succMsg" scope="session" />
						</c:if>

						<c:if test="${not empty failedMsg}">
							<h5 class="text-center text-danger">${failedMsg}</h5>
							<c:remove var="failedMsg" scope="session" />
						</c:if>

						<form action="update_profile" method="post"
							onsubmit="return validatePassword()">
							<input type="hidden" value="${userobj.id}" name="id"> <input
								type="hidden" value="normal" name="user_type">
							<div class="form-group">
								<label for="exampleInputEmail1">Enter Full Name</label> <input
									type="text" class="form-control" id="exampleInputEmail1"
									aria-describedby="emailHelp" required="required" name="fname"
									value="${userobj.name}">
							</div>

							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input
									type="email" class="form-control" id="exampleInputEmail1"
									aria-describedby="emailHelp" required="required" name="email"
									value="${userobj.email}" readonly>
							</div>

							<div class="form-group">
								<label for="exampleInputEmail1">Phone No</label> <input
									type="number" class="form-control" id="exampleInputEmail1"
									aria-describedby="emailHelp" required="required" name="phno"
									value="${userobj.phno}">
							</div>

							<div class="form-group">
								<label for="exampleInputPassword1">Password</label>
								<div class="position-relative">
									<input type="password" class="form-control"
										id="exampleInputPassword1" name="password"
										value="${userobj.password }"> <i
										class="fas fa-eye eye-icon" id="togglePassword"></i>
								</div>
								<small id="passwordError" class="text-danger"></small>
							</div>

							<button type="submit" class="btn btn-primary">Update</button>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="all_component/footer.jsp"%>

	<!-- Add Font Awesome for eye icon -->
	<script src="https://kit.fontawesome.com/a076d05399.js"></script>

	<script>
		// Function to toggle password visibility
		document.getElementById('togglePassword').addEventListener(
				'click',
				function() {
					const passwordInput = document
							.getElementById('exampleInputPassword1');
					if (passwordInput.type === 'password') {
						passwordInput.type = 'text';
					} else {
						passwordInput.type = 'password';
					}
				});

		// Function to validate password pattern
		function validatePassword() {
			var password = document.getElementById("exampleInputPassword1").value;
			var passwordError = document.getElementById("passwordError");

			// Password pattern regex
			var passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%&*()-+=^])(?!.*\s).{8,20}$/;

			if (!passwordPattern.test(password)) {
				passwordError.innerHTML = "Password must contain at least 8 characters, one digit, one uppercase letter, one lowercase letter, one special character, and no whitespace.";
				return false; // Prevent form submission
			} else {
				passwordError.innerHTML = ""; // Clear error message
				return true; // Allow form submission
			}
		}
	</script>
</body>
</html>
