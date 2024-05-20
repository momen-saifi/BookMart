<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.DAO.*"%>
<%@page import="com.DB.DBConnect"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@page import="java.util.*"%>
<%@page import="com.entity.*"%>
<%@page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart Page</title>
<%@include file="all_component/allCss.jsp"%>
</head>
<body style="background-color: #f0f1f2;">
	<%@include file="all_component/navbar.jsp"%>
	<c:if test="${ empty userobj }">
		<c:redirect url="login.jsp">
		</c:redirect>
	</c:if>


	<c:if test="${not empty succMsg }">
		<div class="alert alert-success text-center" role="alert">${succMsg }</div>
		<c:remove var="succMsg" scope="session" />

	</c:if>

	<c:if test="${not empty failedMsg }">
		<div class="alert alert-danger text-center" role="alert">${failedMsg }</div>
		<c:remove var="failedMsg" scope="session" />

	</c:if>

	<div class="container">
		<div class="row p-2">
			<div class="col-md-12">

				<div class="card bg-white">

					<div class="card-body">
						<h3 class="text-center text-success">Your Selected Item</h3>
						<table class="table table-striped">
							<thead>
								<tr>
									<th scope="col">Image</th>
									<th scope="col">Book Name</th>
									<th scope="col">Author</th>
									<th scope="col">Price</th>
									<th scope="col">Action</th>
								</tr>
							</thead>
							<tbody>
								<%
								User u = (User) session.getAttribute("userobj");
								WishListDAOImpl dao = new WishListDAOImpl(DBConnect.getConn());
								List<WishList> wishlist = dao.getBookByUser(u.getId());

								for (WishList w : wishlist) {
								%>

								<tr>



									<td><img src="./book/<%=w.getPhotoName()%>"
										style="width: 50px; height: 50px;"></td>

									<th scope="row"><%=w.getBookName()%></th>
									<td><%=w.getAuthor()%></td>
									<td><%=w.getPrice()%></td>
									<td><a
										href="remove_book_wishlist?bid=<%=w.getBid()%>&uid=<%=w.getUserId()%>&wid=<%=w.getWid()%>"
										class="btn btn-sm btn-danger">Remove</a> <%
 if (w.getQuantity() == 0) {
 %>
										<button class="btn btn-secondary btn-sm ml-2" disabled>
											<i class="fas fa-cart-plus"></i> Sold Out
										</button> <%
 } else {
 %> <a
										href="cart?bid=<%=w.getBid()%>&uid=<%=w.getUserId()%>&loc=wishlist"
										class="btn btn-danger btn-sm ml-2"> <i
											class="fas fa-cart-plus"></i> Add Cart
									</a> <%
 }
 %></td>



								</tr>

								<%
								}
								%>



							</tbody>
						</table>
					</div>
				</div>
			</div>

		</div>
	</div>

</body>
</html>