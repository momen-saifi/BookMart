<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@page errorPage="error_page.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:if test="${ empty userobj }">
		<c:redirect url="login.jsp">
		</c:redirect>
	</c:if>
<div class="container-fluid"
	style="height: 10px; background-color: #303f9f"></div>

<div class="container-fluid p-3 bg-light">
	<div class="row">

		<div class="col-md-3">
			<c:if test="${not empty userobj }">

				<a class="btn btn-success text-white"><i
					class="fas fa-user"></i>${ userobj.name }</a>
					
						<!-- profile  -->


				<a class="btn btn-success" href="href="profile.jsp" data-toggle="modal"
					data-target="#profile-modal"><i
					class="fa-solid fa-circle-user mr-1"></i>${ userobj.name } </a>

				<!-- profile -->
					
				<a data-toggle="modal" data-target="#exampleModalCenter"
					class="btn btn-primary text-white"><i
					class="fas fa-sign-in-alt" aria-hidden="true"></i>Logout</a>


			</c:if>

			<c:if test="${ empty userobj }">
				<a href="../login.jsp" class="btn btn-success"><i
					class="fas fa-sign-in-alt"></i>Login</a>
				<a href="../register.jsp" class="btn btn-primary text-white"><i
					class="fas fa-user-plus" aria-hidden="true"></i>Register</a>
			</c:if>
		</div>
	</div>
</div>


		<c:if test="${not empty userobj }">
			<!-- start profile modal -->
			<!-- Button trigger modal -->

			<!-- Modal -->
			<div class="modal fade" id="profile-modal" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div
							class="modal-header primary-background text-white text-center">
							<h5 class="modal-title" id="exampleModalLabel">BookMart</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<div class="container text-center">


								<h5 class="modal-title mt-3" id="exampleModalLabel">${ userobj.name }</h5>

								<!-- details -->
								<div id="profile-details">
									<table class="table">

										<tbody>
											<tr>
												<th scope="row">ID :</th>
												<td>${ userobj.id }</td>
											</tr>

											<tr>
												<th scope="row">Email :</th>
												<td>${ userobj.email }</td>
											</tr>

											<tr>
												<th scope="row">Phno :</th>
												<td>${ userobj.phno }</td>
											</tr>


										</tbody>
									</table>
								</div>

								<!-- profile edit -->
								<div id="profile-edit" style="display: none;">
									<h2 class="mt-2">Please Edit Carefully</h2>
									<form action="../update_profile" method="post">
										<table class="table">
											<tbody>
												<tr>
													<th scope="row">ID :</th>
													<td><input type="text" class="form-control" name="id"
														value="${ userobj.id }" /></td>
												</tr>
												<tr>
													<th scope="row">Email :</th>
													<td><input type="email" class="form-control"
														name="email" value="${ userobj.email }" /></td>
												</tr>
												<tr>
													<th scope="row">Name :</th>
													<td><input type="text" class="form-control"
														name="fname" value="${ userobj.name }" /></td>
												</tr>
												<tr>
													<th scope="row">Phno :</th>
													<td><input type="text" class="form-control"
														name="phno" value="${ userobj.phno }" /></td>
												</tr>
												<tr>
													<th scope="row">Password :</th>
													<td><input type="password" class="form-control"
														name="password" value="${ userobj.password }" /></td>
												</tr>
											</tbody>
										</table>
										<div class="container">
											<button type="submit" class="btn btn-outline-primary">Save</button>
										</div>
									</form>

								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
							<button id="edit-profile-button" type="button"
								class="btn btn-primary">Edit</button>
						</div>
					</div>
				</div>
			</div>

			<!-- end profile modal -->



		</c:if>







<nav class="navbar navbar-expand-lg navbar-dark bg-custom">
	<a class="navbar-brand" href="#"><i class="fa fa-home"></i></a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" href="home.jsp">Home
					<span class="sr-only">(current)</span>
			</a></li>
			</form>
	</div>
</nav>


<c:if test="${not empty userobj }">
	<script type="text/javascript">
		$(document).ready(function() {

			let editStatus = false;

			$('#edit-profile-button').click(function() {
				if (editStatus == false) {

					$('#profile-details').hide();

					$('#profile-edit').show();

					editStatus = true;

					$(this).text("Back")
				} else {
					$('#profile-details').show();

					$('#profile-edit').hide();

					editStatus = false;
					$(this).text("Edit")
				}

			})
		})
	</script>


</c:if>