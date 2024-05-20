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
        <h3 class="text-center text-primary mt-4 mb-4">Your Order</h3>
        <table class="table table-striped mt-3">
            <thead class="bg-primary text-white">
                <tr>
                    <th scope="col">Order Id</th>
                    <th scope="col">Date</th>
                    <th scope="col">Price</th>
                    <th scope="col">Payment Type</th>
                    <th scope="col">Status</th>
                    <th scope="col">Action</th>
                </tr>
            </thead>
            <tbody>

                <%
                User u = (User) session.getAttribute("userobj");
                BookOrderImpl dao = new BookOrderImpl(DBConnect.getConn());
                List<Book_Order> blist = dao.getBook(u.getEmail());
				
                for (Book_Order b : blist)

                {
                %>
                <tr>
                    <td><%=b.getOrderId()%></td>
                    <td><%=b.getDate() %></td>
                    <td><%=b.getPrice()%></td>
                    <td><%=b.getPaymentType()%></td>
                    <td>
                        <%
                        if (b.isShipped()) {
                        %> 
                        <span class="badge badge-success">Shipped</span> <%
                        } else if (b.isDispatched()) {
                        %> 
                        <span class="badge badge-warning">Dispatched</span> <%
                        } else if (b.isCancel()) {
                        %> 
                        <span class="badge badge-danger">Canceled</span> <%
                        } else {
                        %> 
                        <span class="badge badge-info">Pending</span> <%
                        }
                        %>
                    </td>
                    <td>
                        <%
                        if (!b.isCancel() && !b.isDispatched() && !b.isShipped()) {
                        %> 
                        <a href="cancel_order?oid=<%=b.getOrderId()%>"
                            class="btn btn-sm btn-danger"><i class="fas fa-trash-alt"></i>
                                Cancel</a> <%
                        }
                        %>
                        <a href="view_order.jsp?order_id=<%=b.getOrderId()%>"
                            class="btn btn-sm btn-primary"><i class="fas fa-eye"></i> View</a>
                    </td>
                </tr>


                <%
                }
                %>

            </tbody>
        </table>
    </div>
     <%@include file="all_component/footer.jsp"%>
</body>
</html>
