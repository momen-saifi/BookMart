<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<span>We already send a verifaction code to your email.</span>
	<form action="VerifyCode" method="post">
		<input type="text" name="authcode"> <input type="submit"
			value="verify">
	</form>
</body>
</html>