<%@page import="com.DB.DBConnect"%>
<%@page import="java.sql.*"%>
<%@page import="com.DAO.BookDAOImpl"%>
<%@page import="com.DB.BookDtls"%>
<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>All Recent Book</title>
    <%@ include file="all_component/allCss.jsp"%>
    <style type="text/css">
    .crd-ho:hover {
        background-color: #fcf7f7;
    }

    .card-body {
        padding: 15px;
    }

    .card {
        margin-bottom: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .book-image {
        width: 150px;
        height: 200px;
        object-fit: cover;
    }

    .btn i {
        color: white;
    }

    .btn-sm {
        font-size: 14px;
    }

    .btn-view-details {
        background-color: #28a745;
        border-color: #28a745;
        color: white; /* Adjusted button text color */
    }

    .btn-view-details:hover {
        background-color: #218838;
        border-color: #1e7e34;
    }

    .btn-add-cart,
    .btn-wishlist,
    .btn-sold-out {
        color: white; /* Button text color */
    }

    .btn-add-cart:hover,
    .btn-wishlist:hover,
    .btn-sold-out:hover {
        color: white; /* Adjusted button text color on hover */
    }

    .btn-add-cart {
        background-color: #dc3545;
        border-color: #dc3545;
    }

    .btn-add-cart:hover {
        background-color: #c82333;
        border-color: #bd2130;
    }

    .btn-wishlist {
        background-color: #007bff;
        border-color: #007bff;
    }

    .btn-wishlist:hover {
        background-color: #0056b3;
        border-color: #0056b3;
    }

    .btn-sold-out {
        background-color: #6c757d;
        border-color: #6c757d;
        pointer-events: none;
    }

    .btn-sold-out:hover {
        background-color: #5a6268;
        border-color: #545b62;
    }

    /* Text Color Adjustment */
    .text-primary {
        color: #007bff;
    }
    
    #toast {
	min-width: 300px;
	position: fixed;
	bottom: 30px;
	left: 50%;
	margin-left: -125px;
	background: #333;
	padding: 10px;
	color: white;
	text-align: center;
	z-index: 1;
	font-size: 18px;
	visibility: hidden;
	box-shadow: 0px 0px 100px #000;
}

#toast.display {
	visibility: visible;
	animation: fadeIn 0.5, fadeOut 0.5s 2.5s;
}

@
keyframes fadeIn {from { bottom:0;
	opacity: 0;
}

to {
	bottom: 30px;
	opacity: 1;
}

}
@
keyframes fadeOut {form { bottom:30px;
	opacity: 1;
}

to {
	bottom: 0;
	opacity: 0;
}
}
</style>
</head>
<body>


    <% User u = (User) session.getAttribute("userobj"); %>

    <!-- Toast Notification -->
 <c:if test="${not empty addCart }">

		<div id="toast">${addCart }</div>

		<script type="text/javascript">
		showToast();
		function showToast(content)
		{
		    $('#toast').addClass("display");
		    $('#toast').html(content);
		    setTimeout(()=>{
		        $("#toast").removeClass("display");
		    },2000)
		}	
</script>
		<c:remove var="addCart" scope="session" />
	</c:if>

    <!-- Navbar -->
    <%@include file="all_component/navbar.jsp"%>

    <!-- Recent Books -->
    <div class="container-fluid">
        <div class="row p-3">
            <% BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());
            List<BookDtls> list = dao.getAllNewBook();
            for (BookDtls b : list) { %>
            <div class="col-md-3">
                <div class="card crd-ho">
                    <div class="card-body text-center">
                        <!-- Adding a default image if book image is not available -->
                        <img alt="" src="book/<%=b.getPhotoName()%>"
                            class="img-thumbnail book-image"
                            onerror="this.src='default.jpg';">
                        <p><%=b.getBookName()%></p>
                        <p><%=b.getAuthor()%></p>
                        <p>Categories: <%=b.getBookCategory()%></p>
                        <div class="row">
                            <% if (b.getBookCategory().equals("Old")) { %>
                                <div class="col-md-12">
                                    <a href="view_books.jsp?bid=<%=b.getBookId()%>"
                                        class="btn btn-view-details btn-sm btn-block">View Details</a>
                                </div>
                                <div class="col-md-12 mt-2">
                                    <a href="" class="btn btn-danger btn-sm btn-block">
                                       <i class="fas fa-rupee-sign"></i> <%=b.getPrice()%>
                                    </a>
                                </div>
                            <% } else { %>
                                <div class="col-md-6">
                                    <% if (u == null) { %>
                                        <a href="login.jsp" class="btn btn-add-cart btn-sm btn-block">
                                            <i class="fas fa-cart-plus"></i> Add Cart
                                        </a>
                                    <% } else { %>
                                        <% if (b.getQuantity() == 0) { %>
                                            <button class="btn btn-sold-out btn-sm btn-block" disabled>
                                                <i class="fas fa-cart-plus"></i> Sold Out
                                            </button>
                                        <% } else { %>
                                            <a href="cart?bid=<%=b.getBookId()%>&&uid=<%=u.getId()%>"
                                                class="btn btn-add-cart btn-sm btn-block">
                                                <i class="fas fa-cart-plus"></i> Add Cart
                                            </a>
                                        <% } %>
                                    <% } %>
                                </div>
                                <div class="col-md-6">
                                    <% if (u == null) { %>
                                        <a href="login.jsp" class="btn btn-wishlist btn-sm btn-block">
                                            <i class="fas fa-heart"></i> Add Wishlist
                                        </a>
                                    <% } else { %>
                                        <a href="wish_list?bid=<%=b.getBookId()%>&&uid=<%=u.getId()%>"
                                            class="btn btn-wishlist btn-sm btn-block">
                                            <i class="fas fa-heart"></i> Add Wishlist
                                        </a>
                                    <% } %>
                                </div>
                            <% } %>
                        </div>
                        <div class="row mt-2">
                            <div class="col-md-6">
                                <a href="view_books.jsp?bid=<%=b.getBookId()%>"
                                    class="btn btn-success btn-sm btn-block">View Details</a>
                            </div>
                            <div class="col-md-6">
                                <a href="" class="btn btn-danger btn-sm btn-block">
                                  <i class="fas fa-rupee-sign"></i> <%=b.getPrice()%>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>

 
</body>
</html>