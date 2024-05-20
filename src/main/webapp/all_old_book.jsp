<%@page import="com.DB.DBConnect"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.DAO.BookDAOImpl"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.DB.BookDtls"%>
<%@page import="java.util.*"%>
<%@page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>All Recent Books</title> <!-- Corrected title -->
    <%@include file="all_component/allCss.jsp"%>
    <style type="text/css">
        .crd-ho:hover {
            background-color: #fcf7f7;
        }
        /* Adjusting image size */
        .book-image {
            width: 150px;
            height: 200px;
            object-fit: cover;
        }
        /* Adjusting card size */
        .card {
            height: 100%;
        }
    </style>
</head>
<body>


    <%@include file="all_component/navbar.jsp"%>
    <div class="container-fluid">
        <div class="row p-3">
            <%
            BookDAOImpl dao3 = new BookDAOImpl(DBConnect.getConn());

            List<BookDtls> list3 = dao3.getAllOldBook();
            for (BookDtls b : list3) {
            %>
            <div class="col-md-3">
                <div class="card crd-ho">
                    <div class="card-body text-center">
                        <%-- Using default image if book image is not available --%>
                        <img alt="<%=b.getBookName()%>" src="<%= b.getPhotoName() != null ? "book/" + b.getPhotoName() : "default.jpg" %>"
                            class="img-thumbnail book-image">
                        <p>Book Name: <%=b.getBookName()%></p> 
                        <p>Author: <%=b.getAuthor()%></p>
                        <p>Category: <%=b.getBookCategory()%></p>  
               	<div class="row mt-2">
							<div class="col-md-6">
								<a href="view_books.jsp?bid=<%=b.getBookId()%>"
									class="btn btn-success btn-sm btn-block">View Details</a>
							</div>
							<div class="col-md-6">
								<a href="" class="btn btn-danger btn-sm btn-block"><i
									class="fas fa-rupee-sign"></i> <%=b.getPrice()%>
								</a>
							</div>
						</div>
                    </div>
                </div>
            </div>
            <%
            }
            %>
        </div>
    </div>
</body>
</html>
