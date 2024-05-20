<%@page import="com.DB.DBConnect"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.DAO.BookDAOImpl"%>
<%@ page import="com.DB.BookDtls"%>
<%@ page import="java.util.*"%>
<%@ page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Book Details</title>
<%@include file="all_component/allCss.jsp"%>
<style>
.book-image-card {
    height: auto;
    display: flex;
    align-items: center;
    justify-content: center;
}

.book-image {
    width: 150px;
    height: 238px;
}

</style>
</head>
<body>

    <%@include file="all_component/navbar.jsp"%>

    <%
    User u = (User) session.getAttribute("userobj");
    int bid = Integer.parseInt(request.getParameter("bid"));
    BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());
    BookDtls b = dao.getBookById(bid);
    %>
    <div class="container py-4">
        <div class="row">
            <!-- Left column for book details -->
            <div class="col-md-6">
                <div class="card mb-4 book-image-card">
                    <!-- Add a custom class for the card -->
                    <div class="card-body text-center">
                        <img src="book/<%=b.getPhotoName()%>" class="book-image"
                            alt="Book Image">
                    </div>
                </div>
                <% if ("Old".equals(b.getBookCategory())) { %>
                <!-- Additional details for old books -->
                <div class="card mb-4">
                    <div class="card-body">
                        <h5 class="text-primary">Contact To Seller</h5>
                        <h5 class="text-primary">
                            <i class="fas fa-envelope"></i> Email:
                            <%=b.getEmail()%></h5>
                        <div class="row">
                            <div class="col-md-4 text-danger text-center p-2">
                                <i class="fas fa-money-bill-wave fa-2x border"></i>
                                <p>Cash On Delivery</p>
                            </div>
                            <div class="col-md-4 text-danger text-center p-2">
                                <i class="fas fa-undo-alt fa-2x"></i>
                                <p>Return Available</p>
                            </div>
                            <div class="col-md-4 text-danger text-center p-2">
                                <i class="fas fa-truck-moving fa-2x"></i>
                                <p>Free Shipping</p>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>

            <!-- Right column for book details -->
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-body">
                        <h2><%=b.getBookName()%></h2>
                        <p class="text-muted">
                            Author: <span class="text-success"><%=b.getAuthor()%></span>
                        </p>
                        <p class="text-muted">
                            Price: <span class="text-success"><i
                                    class="fas fa-rupee-sign"></i> <%=b.getPrice()%></span>
                        </p>
                        <p class="text-muted">
                            Category: <span class="text-success"><%=b.getBookCategory()%></span>
                        </p>
                        <p class="text-muted">
                            Quantity: <span class="text-success"><%=b.getQuantity()%></span>
                        </p>
                        <div class="text-center">
                            <%
                            if ("Old".equals(b.getBookCategory())) {
                            %>
                            <a href="index.jsp" class="btn btn-success btn-sm"><i
                                class="fas fa-cart-plus"></i> Continue Shopping</a>
                            <%
                            } else {
                            %>
                            <%
                            if (u == null) {
                            %>
                            <!-- Redirect to login page if not logged in -->
                            <a href="login.jsp" class="btn btn-add-cart btn-sm"><i
                                class="fas fa-cart-plus"></i> Add Cart</a> <a href="login.jsp"
                                class="btn btn-wishlist btn-sm"><i class="fas fa-heart"></i>
                                Add Wishlist</a>
                            <%
                            } else {
                            %>
                            <%
                            if (b.getQuantity() == 0) {
                            %>
                            <!-- Sold out if quantity is 0 -->
                            <button class="btn btn-sold-out btn-sm" disabled>
                                <i class="fas fa-cart-plus"></i> Sold Out
                            </button>
                            <%
                            } else {
                            %>
                            <!-- Add to cart if quantity available -->
                            <a href="cart?bid=<%=b.getBookId()%>&&uid=<%=u.getId()%>"
                                class="btn btn-add-cart btn-sm"><i class="fas fa-cart-plus"></i>
                                Add Cart</a>
                            <%
                            }
                            %>
                            <!-- Add to wishlist -->
                            <a href="wish_list?bid=<%=b.getBookId()%>&&uid=<%=u.getId()%>"
                                class="btn btn-wishlist btn-sm"><i class="fas fa-heart"></i>
                                Add Wishlist</a>
                            <%
                            }
                            %>
                            <%
                            }
                            %>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</body>
</html>
