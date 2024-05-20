<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sorry! Something went wrong</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
    crossorigin="anonymous">

<!-- Font Awesome CSS -->
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
    integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- Custom CSS -->
<style>
    .error-img {
        max-width: 300px;
        height: auto;
        margin-bottom: 20px;
    }

    .error-message {
        font-size: 24px;
        margin-bottom: 30px;
    }

    .btn-primary-background {
        background-color: #007bff;
        border-color: #007bff;
    }

    .btn-primary-background:hover {
        background-color: #0056b3;
        border-color: #0056b3;
    }
</style>
</head>
<body>
    <div class="container text-center">
        <img alt="" src="./img/error.png" class="error-img">
        <h3 class="error-message">Sorry! Something went wrong...</h3>

        <a href="index.jsp" class="btn btn-primary btn-lg btn-primary-background text-white mt-3">Home</a>
    </div>
</body>
</html>
