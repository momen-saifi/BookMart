<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Orders</title>
<%@include file="allCss.jsp"%>
<style type="text/css">
a {
    text-decoration: none;
    color: black;
}

a:hover {
    text-decoration: none;
    color: black;
}

.card {
    height: 100%;
}

.card-body {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}

.card-body h4 {
    margin-top: 10px;
}

.card-body i {
    margin-bottom: 10px;
}

/* Add hover effect for the entire card */
.card:hover {
    background-color: #f0f0f0; /* Change background color on hover */
}
</style>
</head>
<body>
    <%@include file="navbar.jsp"%>

    <c:if test="${empty userobj }">
        <c:redirect url="../login.jsp"></c:redirect>
    </c:if>

    <div class="container">
    <div class="row p-5">
        <div class="col-md-3">
            <div class="card">
                <a href="new_orders.jsp">
                    <div class="card-body">
                        <i class="fas fa-box-open fa-3x text-warning"></i>
                        <h4>Orders</h4>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <a href="canceled_order.jsp">
                    <div class="card-body">
                        <i class="fas fa-ban fa-3x text-danger"></i>
                        <h4>Canceled Orders</h4>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <a href="dispatched_order.jsp">
                    <div class="card-body">
                        <i class="fas fa-truck fa-3x text-primary"></i>
                        <h4>Ready to Ship Orders</h4>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <a href="shipped_order.jsp">
                    <div class="card-body">
                        <i class="fas fa-check-circle fa-3x text-success"></i>
                        <h4>Delivered Orders</h4>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>

    <div style="margin-top: 220px;">
        <%@include file="footer.jsp"%>
    </div>
</body>
</html>
