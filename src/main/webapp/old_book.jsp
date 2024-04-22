<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@page import="com.DAO.BookDAOImpl"%>
<%@page import="com.DB.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User : Old Book</title>
<%@include file="all_component/allCss.jsp"%>
</head>
<body style="background-color: #f0f1f2;">
	<%@include file="all_component/navbar.jsp"%>
	<c:if test="${ not empty succMsg }">
		<div class="alert alert-success">
			<p class="text-center text-success">${succMsg }</p>
		</div>
		<c:remove var="succMsg" scope="session" />
	</c:if>

	<c:if test="${ not empty failedMsg }">
		<div class="alert alert-danger">

			<p class="text-center text-danger">${failedMsg }</p>
		</div>
		<c:remove var="failedMsg" scope="session" />
	</c:if>

	<div class="container p-5">
		<table class="table table-striped">
			<thead class="bg-primary text-white">
				<tr>
					<th scope="col">Book Name</th>
					<th scope="col">Author</th>
					<th scope="col">Price</th>
					<th scope="col">Category</th>
					<th scope="col">Action</th>
				</tr>
			</thead>
			<tbody>


				<%
				User u = (User) session.getAttribute("userobj");
				BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());
				String email = u.getEmail();
				String category = "Old";
				List<BookDtls> list = dao.getBookByOld(email, category);
				for (BookDtls b : list) {
				%>

				<tr>
					<th scope="row"><%=b.getBookName()%></th>
					<td><%=b.getAuthor()%></td>
					<td><%=b.getPrice()%></td>
					<td><%=b.getBookCategory()%></td>
					<td><a
						href="delete_old_book?email=<%=email%>&&category=<%=category%>&&bid=<%=b.getBookId()%>"
						class="btn btn-sm btn-danger">Delete</a></td>
				</tr>
				<%
				}
				%>


			</tbody>
		</table>
	</div>

</body>
</html>