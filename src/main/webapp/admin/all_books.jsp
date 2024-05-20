<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<%@page import="com.DB.DBConnect"%>
<%@page import="com.DAO.*"%>
<%@page import="com.DB.BookDtls"%>
<%@page import="com.entity.*"%>
<%@page errorPage="error_page.jsp"%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin: All Books</title>
<%@include file="allCss.jsp"%>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    <h3 class="text-center">Hello Admin</h3>

    <c:if test="${empty userobj}">
        <c:redirect url="../login.jsp"></c:redirect>
    </c:if>

   
    <c:if test="${not empty succMsg}">
        <h5 class="text-center text-success">${succMsg}</h5>
        <c:remove var="succMsg" scope="session" />
    </c:if>

    <c:if test="${not empty failedMsg}">
        <h5 class="text-center text-danger">${failedMsg}</h5>
        <c:remove var="failedMsg" scope="session" />
    </c:if>

    <table class="table table-striped">
        <thead class="bg-primary text-white">
            <tr>
                <th scope="col">ID</th>
                <th scope="col">Image</th>
                <th scope="col">Book Name</th>
                <th scope="col">Author</th>
                <th scope="col">Price</th>
                <th scope="col">Categories</th>
                <th scope="col">Quantity</th>
                <th scope="col">Status</th>
                <th scope="col">Profile Action</th>
                <th scope="col">Action</th>
            </tr>
        </thead>
        <tbody>
            <%
            BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());
            List<BookDtls> list = dao.getAllBooks();
            for (BookDtls b : list) {
            %>
            <tr>
                <td><%= b.getBookId() %></td>
                <td><img src="../book/<%= b.getPhotoName() %>" style="width: 50px; height: 50px;"></td>
                <td><%= b.getBookName() %></td>
                <td><%= b.getAuthor() %></td>
                <td><%= b.getPrice() %></td>
                <td><%= b.getBookCategory() %></td>
                <td><%= b.getQuantity() %></td>
                <td><%= b.getStatus() %></td>
                <td>
                   <a class="btn btn-success" href="#" onclick="loadBookOwnerProfile('<%= b.getEmail() %>')" data-toggle="modal" data-target="#profile-modal-admin">
    <i class="fa-solid fa-circle-user mr-1"></i>Book Owner
</a>

                </td>
                <td>
                    <a href="edit_books.jsp?id=<%= b.getBookId() %>" class="btn btn-sm btn-primary">
                        <i class="fas fa-edit"></i>Edit
                    </a>
                    <a href="../delete?id=<%= b.getBookId() %>" class="btn btn-sm btn-danger">
                        <i class="fas fa-trash-alt"></i>Delete
                    </a>
                </td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>

    <!-- Profile Modal -->
    <div class="modal fade" id="profile-modal-admin" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white text-center">
                <h5 class="modal-title">BookMart</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container text-center">
                    <h5 class="modal-title mt-3">${userobj.name}</h5>
                    <div id="profile-details-admin">
                        <!-- Profile details will be loaded here via AJAX -->
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- end profilr  -->
    <div style="margin-top: 200px;">
        <%@ include file="footer.jsp" %>
    </div>

    <!-- AJAX Function to Load User Profile -->
    
    
    
    
    
    <script>
    function loadBookOwnerProfile(email) {
        $.ajax({
            type: 'GET',
            url: 'book_owner_profile_data.jsp',
            data: {
                email: email
            },
            success: function(response) {
                $('#profile-details-admin').html(response);
            },
            error: function(xhr, status, error) {
                console.error('Error loading book owner profile:', error);
            }
        });
    }

    </script>
</body>
</html>