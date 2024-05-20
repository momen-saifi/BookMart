
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<div class="container-fluid"
	style="height: 10px; background-color: #303f9f;"></div>

<div class="container-fluid p-3 bg-light">
	<div class="row">
		<div class="col-md-3 text-success">
			<h3>
				<i class="fa fa-book"></i> Ebook
			</h3>
		</div>

		<div class="col-md-3 offset-6 text-right">
			<c:if test="${not empty userobj }">
				<!-- Profile -->
				<a class="btn btn-info" href="#!" data-toggle="modal"
					data-target="#profile-modal-user"> <i
					class="fas fa-user-circle mr-1"></i>${userobj.name}
				</a>
				<!-- Profile -->
				<a data-toggle="modal" data-target="#exampleModalCenter"
					class="btn btn-warning text-white"> <i
					class="fas fa-sign-out-alt" aria-hidden="true"></i>Logout
				</a>
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
	<!-- Profile Modal -->
	<div class="modal fade" id="profile-modal-user" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header bg-primary text-white">
					<h5 class="modal-title">Profile</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<!-- Modal Body -->
				<div class="modal-body text-center">
					<h5 class="modal-title mb-3">${userobj.name }</h5>
					<!-- Profile Details -->
					<div id="profile-details">
						<table class="table mx-auto">
							<tbody>
								<tr>
									<th scope="row">ID:</th>
									<td>${userobj.id }</td>
								</tr>
								<tr>
									<th scope="row">Email:</th>
									<td>${userobj.email }</td>
								</tr>
								<tr>
									<th scope="row">Phone:</th>
									<td>${userobj.phno }</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- Modal Footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<a href="edit_profile.jsp" id="edit-profile-button"
						class="btn btn-primary">Edit</a>
				</div>
			</div>
		</div>
	</div>
	<!-- end profile modal -->
</c:if>

<!-- logout model -->
<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLongTitle"></h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="text-center">
					<h4>Do you want to logout?</h4>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<a href="../logout" type="button"
						class="btn btn-primary text-white">Logout</a>
				</div>
			</div>
			<div class="modal-footer"></div>
		</div>
	</div>
</div>
<!-- end logout model -->

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
			<li class="nav-item active"><a class="nav-link" href="home.jsp"><i
					class="fa fa-home"></i> Home</a></li>
			<li class="nav-item active"><a class="nav-link"
				href="add_books.jsp"><i class="fas fa-plus-circle"></i> Add
					Books</a></li>
			<li class="nav-item active"><a class="nav-link"
				href="all_books.jsp"><i class="fas fa-book"></i> All Books</a></li>
			<li class="nav-item active"><a class="nav-link disabled"
				href="orders.jsp"><i class="fas fa-clipboard-list"></i> Orders</a></li>
					<li class="nav-item active"><a class="nav-link disabled"
				href="users_list.jsp"><i class="fas fa-users"></i> Registered Users</a></li>

		</ul>

	</div>
</nav>
