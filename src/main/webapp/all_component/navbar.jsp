<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@page import="com.entity.User"%>

<%
User user = (User) session.getAttribute("userobj");
%>
<div class="container-fluid"
	style="height: 10px; background-color: #303f9f"></div>

<div class="container-fluid p-3 bg-light">
	<div class="row">
		<div class="col-md-3 text-success">
			<h3>
				<i class="fa fa-book"></i> Ebook
			</h3>
		</div>
		<div class="col-md-6">
			<form action="search.jsp" method="post"
				class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search" name="ch"
					placeholder="Search" aria-label="Search">
				<button class="btn btn-primary my-2 my-sm-0" type="submit">Search</button>
			</form>

		</div>

		<c:if test="${not empty userobj }">


			<div class="col-md-3">

				<a href="checkout.jsp"><i
					class="fa-solid fa-cart-plus fa-2x mt-2x"></i></a> <span id="bookCount"
					class="badge badge-pill bg-primary"></span> <a href="login.jsp"
					class="btn btn-success"><i class="fas fa-user-plus"
					aria-hidden="true"></i>${userobj.name  }</a> <a href="logout"
					class="btn btn-primary text-white"><i
					class="fas fa-sign-in-alt"></i>Logout</a>
			</div>
		</c:if>

		<c:if test="${empty userobj }">

			<div class="col-md-3">
				<i class="fa fas-cart-plus"></i> <a href="login.jsp"
					class="btn btn-success"><i class="fas fa-sign-in-alt"></i>Login</a>
				<a href="register.jsp" class="btn btn-primary text-white"><i
					class="fas fa-user-plus" aria-hidden="true"></i>Register</a>
			</div>
		</c:if>

	</div>
</div>
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
			<li class="nav-item active"><a class="nav-link" href="index.jsp">Home
					<span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item active"><a class="nav-link"
				href="all_recent_book.jsp"><i class="fa fa-book-open"></i>Recent
					Book</a></li>
			<li class="nav-item active"><a class="nav-link"
				href="all_new_book.jsp"><i class="fa fa-book"></i>New Book</a></li>
			<li class="nav-item active"><a class="nav-link disabled"
				href="all_old_book.jsp"><i class="fa fa-book"></i>Old Book</a></li>
		</ul>
		<form class="form-inline my-2 my-lg-0">

			<!--  <a href="setting.jsp"
				class="btn btn-light bg-lighttext-dark text-decoration-none my-2 my-sm-0"
				type="submit"> <i class="fa fa-cog"></i> Setting
			</a>-->



			<a href="setting.jsp"
				class="btn btn-light-success my-2 my-sm-0  btn-light" type="submit">
				<i class="fa fa-cog"></i>Setting
			</a>
			<button class="btn btn-light-success my-2 my-sm-0 ml-1" type="submit">
				<i class="fa fa-phone-square-alt"></i>Contact Us
			</button>
		</form>
	</div>
</nav>
<c:if test="${not empty userobj }">
	<script>
		function updateBookCount(userId) {
			// Make an AJAX request to the servlet to get the updated book count
			var xhr = new XMLHttpRequest();
			xhr.open("GET", "count_book?uid=" + userId, true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					// Update the book count on the page
					document.getElementById("bookCount").innerText = xhr.responseText;
				}
			};
			xhr.send();
		}

		function deleteBookNill() {
			// Make an AJAX request to the servlet to delete books with zero quantity
			var xhr = new XMLHttpRequest();
			xhr.open("GET", "delete_nill_book", true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					// Update the UI or do something else if needed
				}
			};
			xhr.send();
		}

		window.onload = function() {
			var userId =
	<%=user.getId()%>
		; // You need to define the user id here
			updateBookCount(userId);
			deleteBookNill();
		};
	</script>


</c:if>