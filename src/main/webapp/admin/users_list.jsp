<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<%@page import="com.DAO.UserDAOImpl"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="java.util.*"%>
<%@page import="com.entity.User"%>
<%@page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin: All Orders</title>
    <%@include file="allCss.jsp"%>
</head>
<body>
    <%@include file="navbar.jsp"%>

    <c:if test="${empty userobj}">
        <c:redirect url="../login.jsp"></c:redirect>
    </c:if>

    <div class="container">
        <h3 class="text-center">Hello Admin</h3>

        <table class="table table-striped">
            <thead class="bg-primary text-white">
                <tr>
                    <th scope="col">User Id</th>
                    <th scope="col">Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Phone No</th>
                    <th scope="col">Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                UserDAOImpl dao = new UserDAOImpl(DBConnect.getConn());
                List<User> ulist = dao.findUserlist();

                for (User u : ulist) {
                %>
                <tr>
                    <td><%= u.getId() %></td>
                    <td><%= u.getName() %></td>
                    <td><%= u.getEmail()%></td>
                    <td><%= u.getPhno()%></td>
                    <td>
                        <% if(u.getStatus().equals("Active")) { %>
                         <a href="../user_status?email=<%= u.getEmail() %>&status=Block" class="btn btn-sm btn-success">
                                <i class="fas fa-check"></i> Active
                            </a>
                           
                        <% } else { %>
                            <a href="../user_status?email=<%= u.getEmail() %>&status=Active" class="btn btn-sm btn-danger">
                                <i class="fas fa-ban"></i> Blocked
                            </a>
                        <% } %>
                    </td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </div>

    <div style="margin-top: 40px;">
        <%@include file="footer.jsp"%>
    </div>
</body>
</html>
