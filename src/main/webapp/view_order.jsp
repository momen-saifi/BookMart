<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.DAO.BookOrderImpl"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="java.util.*"%>
<%@page import="com.entity.Book_Order"%>
<%@include file="all_component/allCss.jsp"%>
<%@page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
</head>
<body style="background-color: #f0f1f2;">
    <%@include file="all_component/navbar.jsp"%>

    <c:if test="${ empty userobj }">
        <c:redirect url="login.jsp">
        </c:redirect>
    </c:if>

    <div class="container p-1">
        <h3 class="text-center text-primary">Your Order</h3>
        <table class="table table-striped mt-3">
            <thead class="bg-primary text-white">
                <tr>
                    <th scope="col">Book Id</th>
                    <th scope="col">Book Name</th>
                    <th scope="col">Author</th>
                    <th scope="col">Price</th>
                    <th scope="col">Quantity</th>
                </tr>
            </thead>
            <tbody>

                <%
                User u = (User) session.getAttribute("userobj");
                String order_id = request.getParameter("order_id");
                BookOrderImpl dao = new BookOrderImpl(DBConnect.getConn());
                List<Book_Order> blist = dao.getBookByOrderId(order_id);
                boolean s = blist.get(0).isShipped();
                boolean d = blist.get(0).isDispatched();
                boolean c = blist.get(0).isCancel();

                for (Book_Order b : blist) {
                %>
                <tr>
                    <td><%=b.getBid() %></td>
                    <td><%=b.getBookName()%></td>
                    <td><%=b.getAuthor()%></td>
                    <td><%=b.getPrice()%></td>
                    <td><%=b.getQuantity() %></td>
                </tr>
                <% } %>

                <tr>
                    <%if(s || d || c) {%>
                    <th scope="col">Status</th>
                    <%} else{%>
                  <th scope="col">Action</th>
                  <%} %>
				<th scope="col"></th>
				<th scope="col"></th>
				<th scope="col"></th>
                    <th >
                        <%
                        if (s) {
                        %>
                            <span class="badge badge-success">Shipped</span>
                        <%
                        } else if (d) {
                        %>
                            <span class="badge badge-warning">Dispatched</span>
                        <%
                        } else if (c) {
                        %>
                            <span class="badge badge-danger">Canceled</span>
                        <%
                        } else {
                        %>
                            <a href="cancel_order?oid=<%= order_id %>" class="btn btn-sm btn-danger"><i class="fas fa-trash-alt"></i> Cancel</a>
                        <%
                        }
                        %>
                    </th>
                </tr>

            </tbody>
        </table>
    </div>

</body>
</html>
