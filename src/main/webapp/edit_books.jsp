<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.DAO.BookDAOImpl"%>
<%@page import="com.DB.BookDtls"%>
<%@page import="java.util.*"%>
<%@page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>
<%@include file="all_component/allCss.jsp"%>
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

				<div class="card ">
					<div class="card-body">
						<h4 class="text-center">Edit Books</h4>


						<%
						int id = Integer.parseInt(request.getParameter("id"));
						BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());
						BookDtls b = dao.getBookById(id);
						out.print(id);
						%>


						<form action="edit_old_books" method="post">
							<input type="hidden" name="id" value="<%=b.getBookId()%>">
							<div class="form-group">
								<label for="exampleInputEmail">Book Name*</label><input
									name="bname" type="text" class="form-control"
									id="exampleInputEmail" aria-describedby="emailHelp"
									value="<%=b.getBookName()%>">
							</div>
							
							<div class="form-group">
								<label for="exampleInputEmail">Author Name*</label><input
									name="author" type="text" class="form-control"
									id="exampleInputEmail" aria-describedby="emailHelp"
									value="<%=b.getAuthor()%>">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail">Price*</label><input name="price"
									type="text" class="form-control" id="exampleInputEmail"
									value="<%=b.getPrice()%>">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail">Quantity</label><input
									name="quantity" type="number" class="form-control"
									id="exampleInputEmail" value="<%=b.getQuantity()%>">
							</div>
							<div class="form-group">

								<button type="submit" class="btn btn-primary">Update</button>

							</div>

						</form>
					</div>
				</div>

			</div>
		</div>
	</div>

	<div style="margin-top: 40px;">
		<%@include file="all_component/footer.jsp"%></div>
</body>
</html>