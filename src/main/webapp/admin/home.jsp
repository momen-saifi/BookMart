<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Admin: Home</title>
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
            <a href="add_books.jsp">
                <div class="card">
                    <div class="card-body text-center">
                        <i class="fas fa-plus-circle fa-3x text-success"></i>
                        <h4>Add Books</h4>
                        -----------
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-3">
            <a href="all_books.jsp">
                <div class="card">
                    <div class="card-body text-center">
                        <i class="fas fa-book fa-3x text-primary"></i>
                        <h4>All Books</h4>
                        -----------
                    </div>
                </div>
            </a>

        </div>




        <div class="col-md-3">

            <div class="card">
                <a href="users_list.jsp">
                    <div class="card-body text-center">
                        <i class="fas fa-users fa-3x text-primary"></i>
                        <h4 >Registered Users</h4>
                        -----------
                    </div>
                </a>
            </div>

        </div>





        <div class="col-md-3">

            <div class="card">
                <a href="orders.jsp">
                    <div class="card-body text-center">
                        <i class="fas fa-clipboard-list fa-3x text-warning"></i>
                        <h4>Orders</h4>
                        -----------
                    </div>
                </a>
            </div>

        </div>

  <!-- 
  
  
  
  
  
        <div class="col-md-3">
            <a data-toggle="modal" data-target="#exampleModalCenter">
                <div class="card">
                    <div class="card-body text-center">
                        <i class="fas fa-sign-out-alt fa-3x text-danger"></i>
                        <h4>Logout</h4>
                        -----------
                    </div>
                </div>
            </a>
        </div>
    </div>
  
  
  
   -->
   
</div>

<!-- logout model -->


<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1"
     role="dialog" aria-labelledby="exampleModalCenterTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle"></h5>
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4>Do you want to logout?</h4>
                    <button type="button" class="btn btn-secondary"
                            data-dismiss="modal">Close</button>
                    <a href="../logout" type="button"
                       class="btn btn-primary text-white">Logout</a>
                </div>
            </div>
            <div class="modal-footer"></div>
        </div>
    </div>
</div>

<!--  end logout model-->

<div style="margin-top: 220px;">
    <%@include file="footer.jsp"%></div>
</body>
</html>
