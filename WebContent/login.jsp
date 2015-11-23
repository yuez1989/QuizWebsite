<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Please Login</title>
</head>
<body>
	<h1>Welcome to Quiz Website, please login using your username and password</h1>
	<form action="UserLoginServlet" method="post">
		<p>
			User Name: <input type="text" name="account" />
		</p>
		<p>
			Password: <input type="text" name="password" />
		</p>
		<input type="submit" value="Login" />
	</form>
	<form action="CreateAccountServlet" method="post">
		<input type="submit" value="Sign Up" />
	</form>
</body>
</html>