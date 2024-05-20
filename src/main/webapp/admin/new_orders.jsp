<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<%@page import="com.DAO.BookOrderImpl"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="java.util.*"%>
<%@page import="com.entity.Book_Order"%>
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

    <c:if test="${empty userobj }">
        <c:redirect url="../login.jsp"></c:redirect>
    </c:if>
    <h3 class="text-center">Hello Admin</h3>

    <table class="table table-striped">
        <thead class="bg-primary text-white">
            <tr>
                <th scope="col">Order Id</th>
                <th scope="col">Name</th>
                <th scope="col">Email</th>
                <th scope="col">Address</th>
                <th scope="col">Landmark</th>
                <th scope="col">City</th>
                <th scope="col">Pincode</th>
                <th scope="col">Phone No</th>
                <th scope="col">Total Price</th>
                <th scope="col">Payment type</th>
                <th scope="col">Date</th>
                <th scope="col">Action</th>
            </tr>
        </thead>
        <tbody>
            <%
            BookOrderImpl dao = new BookOrderImpl(DBConnect.getConn());
            List<Book_Order> blist = dao.getNewOrder();

            for (Book_Order b : blist) {
            %>
            <tr>
                <td><%=b.getOrderId()%></td>
                <td><%=b.getUserName()%></td>
                <td><%=b.getEmail()%></td>
                <td><%=b.getAddress()%></td>
                <td><%=b.getLandmark()%></td>
                <td><%=b.getCity()%></td>
                <td><%=b.getPincode()%></td>
                <td><%=b.getPhno()%></td>
                <td><%=b.getTotalPrice()%></td>
                <td><%=b.getPaymentType()%></td>
                <td><%=b.getDate()%></td>
                <td>
                    <a href="view_new_order.jsp?order_id=<%=b.getOrderId()%>" class="btn btn-sm btn-primary">
                        <i class="fas fa-eye"></i> View
                    </a>
                    <a href="../order_dispatch?oid=<%=b.getOrderId()%>" class="btn btn-sm btn-primary">
                        <i class="fas fa-truck"></i> Dispatch
                    </a>
                    <a href="../cancel_order_admin?oid=<%=b.getOrderId()%>" class="btn btn-sm btn-danger">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                </td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>
    <div style="margin-top: 200px;">
        <%@include file="footer.jsp"%>
    </div>
</body>
</html>
