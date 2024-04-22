<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.DAO.BookDAOImpl"%>
<%@page import="com.DB.BookDtls"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin: Add Books</title>
<%@include file="allCss.jsp"%>
</head>
<body style="background-color: #f0f2f2">
	<%@include file="navbar.jsp"%>
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
						%>


						<form action="../editbooks" method="post">
						<input type="hidden" name="id" value="<%=b.getBookId() %>">
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
								<label for="inputState">Book Status</label><select
									id="inputState" name="status" class="form-control">

									<%
										if ("Active".equals(b.getStatus())) {
									%>

									<option value="Active">Active</option>

									<%
										} else {
									%>

									<option value="Inactive">Inactive</option>


									<%
										}
									%>



								</select>

								<button type="submit" class="btn btn-primary">Update</button>

							</div>

						</form>
					</div>
				</div>

			</div>
		</div>
	</div>

	<div style="margin-top: 40px;">
		<%@include file="footer.jsp"%></div>
</body>
</html>