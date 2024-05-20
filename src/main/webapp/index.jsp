<%@page import="com.DB.DBConnect"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="com.DAO.BookDAOImpl"%>
<%@page import="com.DB.BookDtls"%>
<%@page import="java.util.*"%>
<%@page import="com.entity.User"%>
<%@page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ebook: Index</title>
<%@include file="all_component/allCss.jsp"%>

<style type="text/css">



.crd-ho:hover {
	background-color: #fcf7f7;
}

.card-body {
	padding: 15px;
}

.card {
	margin-bottom: 20px;
	border: 1px solid #ddd;
	border-radius: 5px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.book-image {
	width: 150px;
	height: 200px;
	object-fit: cover;
}

.btn i {
	color: white;
}

.btn-sm {
	font-size: 14px;
}

.btn-view-details {
	background-color: #28a745;
	border-color: #28a745;
	color: white; /* Adjusted button text color */
}

.btn-view-details:hover {
	background-color: #218838;
	border-color: #1e7e34;
}

.btn-add-cart, .btn-wishlist, .btn-sold-out {
	color: white; /* Button text color */
}

.btn-add-cart:hover, .btn-wishlist:hover, .btn-sold-out:hover {
	color: white; /* Adjusted button text color on hover */
}

.btn-add-cart {
	background-color: #dc3545;
	border-color: #dc3545;
}

.btn-add-cart:hover {
	background-color: #c82333;
	border-color: #bd2130;
}

.btn-wishlist {
	background-color: #007bff;
	border-color: #007bff;
}

.btn-wishlist:hover {
	background-color: #0056b3;
	border-color: #0056b3;
}

.btn-sold-out {
	background-color: #6c757d;
	border-color: #6c757d;
	pointer-events: none;
}

.btn-sold-out:hover {
	background-color: #5a6268;
	border-color: #545b62;
}

/* Text Color Adjustment */
.text-primary {
	color: #007bff;
}
</style>
</head>
<body>

	<%
	User u = (User) session.getAttribute("userobj");
	%>


	<%@include file="all_component/navbar.jsp"%>
	<div class="container-fluid back-img">
		<h2 class="text-center text-danger"></h2>
	</div>

	<!-- Start Recent Book -->
	<div class="container-fluid">
		<h3 class="text-center">Recent Book</h3>

		<div class="row p-3">
			<%
			BookDAOImpl dao2 = new BookDAOImpl(DBConnect.getConn());
			List<BookDtls> list2 = dao2.getRecentBooks();
			for (BookDtls b : list2) {
			%>
			<div class="col-md-3">
				<div class="card book-card">
					<div class="card-body text-center">
						<img alt="" src="book/<%=b.getPhotoName()%>" class="book-image">
						<p><%=b.getBookName()%></p>
						<p><%=b.getAuthor()%></p>
						<p>
							Categories:
							<%=b.getBookCategory()%></p>
						<div class="row">
							<%
							if (b.getBookCategory().equals("Old")) {
							%>
							<div class="col-md-12">
								<a href="#" class="btn  btn-sm btn-block hidden"></a>
							</div>
							<div class="col-md-12 mt-2">
								<a href="#" class="btn  btn-sm btn-block hidden"> </a>
							</div>
							<%
							} else {
							%>
							<div class="col-md-6">
								<%
								if (u == null) {
								%>
								<a href="login.jsp" class="btn btn-add-cart btn-sm btn-block"><i class="fas fa-cart-plus"></i> Add
									Cart</a> 
								<%
								} else {
								%>
								<%
								if (b.getQuantity() == 0) {
								%>
								<button class="btn btn-sold-out btn-sm btn-block" disabled>
									<i class="fas fa-cart-plus"></i> Sold Out
								</button>
								<%
								} else {
								%>
								<a href="cart?bid=<%=b.getBookId()%>&&uid=<%=u.getId()%>"
									class="btn btn-add-cart btn-sm btn-block"><i
									class="fas fa-cart-plus"></i> Add Cart</a>
								<%
								}
								%>
								<%
								}
								%>
							</div>
							<div class="col-md-6">
								<%
								if (u == null) {
								%>
								<a href="login.jsp" class="btn btn-wishlist btn-sm btn-block"><i
									class="fas fa-heart"></i> Wishlist</a>
								<%
								} else {
								%>
								<a href="wish_list?bid=<%=b.getBookId()%>&&uid=<%=u.getId()%>"
									class="btn btn-wishlist btn-sm btn-block"><i
									class="fas fa-heart"></i> Wishlist</a>
								<%
								}
								%>
							</div>
							<%
							}
							%>
						</div>


						<div class="row mt-2">
							<div class="col-md-6">
								<a href="view_books.jsp?bid=<%=b.getBookId()%>"
									class="btn btn-view-details btn-sm btn-block">View Details</a>
							</div>
							<div class="col-md-6">
								<a href="#" class="btn btn-danger btn-sm btn-block"><i class="fas fa-rupee-sign"></i> <%=b.getPrice()%>
									<i class="fa fa-money"></i></a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
		<div class="text-center mt-1">
			<a href="all_recent_book.jsp"
				class="btn btn-danger btn-sm text-white">View All</a>
		</div>
	</div>
	<!-- End Recent Book -->
	<hr>

	<!-- Start New Book -->
	<div class="container-fluid">
		<h3 class="text-center">New Book</h3>
		<div class="row p-3">
			<%
			BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());
			List<BookDtls> list = dao.getNewBook();
			for (BookDtls b : list) {
			%>
			<div class="col-md-3">
				<div class="card book-card">
					<div class="card-body text-center">
						<img alt="" src="book/<%=b.getPhotoName()%>" class="book-image">
						<p><%=b.getBookName()%></p>
						<p><%=b.getAuthor()%></p>
						<p>
							Categories:
							<%=b.getBookCategory()%></p>
						<div class="row">
							<%
							if (b.getBookCategory().equals("Old")) {
							%>
							<div class="col-md-12">
								<a href="view_books.jsp?bid=<%=b.getBookId()%>"
									class="btn btn-view-details btn-sm btn-block">View Details</a>
							</div>
							<div class="col-md-12 mt-2">
								<a href="#" class="btn btn-danger btn-sm btn-block"><i
									class="fas fa-rupee-sign"></i> <%=b.getPrice()%>
								</a>
							</div>
							<%
							} else {
							%>
							<div class="col-md-6">
								<%
								if (u == null) {
								%>
								<a href="login.jsp" class="btn btn-add-cart btn-sm btn-block">
									<i class="fas fa-cart-plus"></i> Add Cart
								</a>
								<%
								} else {
								%>
								<%
								if (b.getQuantity() == 0) {
								%>
								<button class="btn btn-sold-out btn-sm btn-block" disabled>
									<i class="fas fa-cart-plus"></i> Sold Out
								</button>
								<%
								} else {
								%>
								<a href="cart?bid=<%=b.getBookId()%>&&uid=<%=u.getId()%>"
									class="btn btn-add-cart btn-sm btn-block"> <i
									class="fas fa-cart-plus"></i> Add Cart
								</a>
								<%
								}
								%>
								<%
								}
								%>
							</div>
							<div class="col-md-6">
								<%
								if (u == null) {
								%>
								<a href="login.jsp" class="btn btn-wishlist btn-sm btn-block">
									<i class="fas fa-heart"></i> Add Wishlist
								</a>
								<%
								} else {
								%>
								<a href="wish_list?bid=<%=b.getBookId()%>&&uid=<%=u.getId()%>"
									class="btn btn-wishlist btn-sm btn-block"> <i
									class="fas fa-heart"></i> Add Wishlist
								</a>
								<%
								}
								%>
							</div>
							<%
							}
							%>
						</div>
						<div class="row mt-2">
							<div class="col-md-6">
								<a href="view_books.jsp?bid=<%=b.getBookId()%>"
									class="btn btn-view-details btn-sm btn-block">View Details</a>
							</div>
							<div class="col-md-6">
								<a href="#" class="btn btn-danger btn-sm btn-block"><i
									class="fas fa-rupee-sign"></i> <%=b.getPrice()%>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
		<div class="text-center mt-1">
			<a href="all_new_book.jsp" class="btn btn-danger btn-sm text-white">View
				All</a>
		</div>
	</div>
	<!-- End New Book -->
	<hr>

	<!-- Start Old Book -->
	<div class="container-fluid">
		<h3 class="text-center">Old Book</h3>
		<div class="row p-3">
			<%
			BookDAOImpl dao3 = new BookDAOImpl(DBConnect.getConn());
			List<BookDtls> list3 = dao3.getOldBooks();
			for (BookDtls b : list3) {
			%>
			<div class="col-md-3">
				<div class="card book-card">
					<div class="card-body text-center">
						<img alt="" src="book/<%=b.getPhotoName()%>" class="book-image">
						<p><%=b.getBookName()%></p>
						<p><%=b.getAuthor()%></p>
						<p>
							Categories:
							<%=b.getBookCategory()%></p>
						<div class="row mt-2">
							<div class="col-md-6">
								<a href="view_books.jsp?bid=<%=b.getBookId()%>"
									class="btn btn-view-details btn-sm btn-block">View Details</a>
							</div>
							<div class="col-md-6">
								<a href="#" class="btn btn-danger btn-sm btn-block"><i
									class="fas fa-rupee-sign"></i> <%=b.getPrice()%>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
		<div class="text-center mt-1">
			<a href="all_old_book.jsp"
				class="btn btn-danger btn-sm text-white">View All</a>
		</div>
	</div>
	<!-- End Old Book -->
	<%@include file="all_component/footer.jsp"%>



</body>
</html>
