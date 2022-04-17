<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Login Page</title>
	</head>
	
	<body>
		<form action="checkLoginDetails.jsp" method="POST">
			<div>
				Welcome to our Auction Site!
			</div>
			<div>
				Username: <input type="text" name="username"/> <br/>
				Password: <input type="text" name="password"/> <br/>
				<input type="submit" value="Login"/>
			</div>
		</form>
		<br>
		<form action="registerUserPage.jsp" method="POST">
			<p>
				Click register if you are a new user
			</p>
			<input type="submit" value="Register"/>
		</form>
	</body>
</html>