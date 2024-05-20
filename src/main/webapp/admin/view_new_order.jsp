<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ page import="com.DAO.BookOrderImpl"%>
<%@ page import="com.DB.DBConnect"%>
<%@ page import="java.util.*"%>
<%@ page import="com.entity.Book_Order"%>
<%@page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin: All Orders</title>
<%@include file="allCss.jsp"%>
</head>
<body>
	<%@include file="navbar.jsp"%>

	<c:if test="${empty userobj}">
		<c:redirect url="../login.jsp"></c:redirect>
	</c:if>
	<h3 class="text-center">Hello Admin</h3>

	<table class="table table-striped">
		<thead class="bg-primary text-white">
			<tr>
				<th scope="col">Book Id</th>
				<th scope="col">Book Name</th>
				<th scope="col">Author</th>
				<th scope="col">Quantity</th>
				<th scope="col">Price</th>

			</tr>
		</thead>
		<tbody>
			<%
			BookOrderImpl dao = new BookOrderImpl(DBConnect.getConn());
			String order_id = request.getParameter("order_id");
			List<Book_Order> blist = dao.getNewOrderDetails(order_id);

			for (Book_Order b : blist) {
			%>
			<tr>
				<th scope="row"><%=b.getBid()%></th>
				<td><%=b.getBookName()%></td>
				<td><%=b.getAuthor()%></td>
				<td><%=b.getQuantity()%></td>
				<td><%=b.getPrice()%></td>

			</tr>
			<%
			}
			%>
			<tr>

				<th scope="col">Action</th>
				<th scope="col"></th>
				<th scope="col"></th>
				<th scope="col"></th>




				<th><a href="../order_dispatch?oid=order_id"
					class="btn btn-sm btn-primary"> <i class="fas fa-truck"></i>
						Dispatch
				</a> <a href="../cancel_order_admin?oid=order_id" class="btn btn-sm btn-danger"><i
						class="fas fa-times-circle"></i> Cancel</a></th>
			</tr>
		</tbody>
	</table>
	<div style="margin-top: 200px;">
		<%@include file="footer.jsp"%>
	</div>
</body>
</html>
