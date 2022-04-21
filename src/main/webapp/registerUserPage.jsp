<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!-- This is the page that lets a user register for an account.
	 Username and emails must be unique. -->

<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Register Page</title>
	</head>
	
	<body>
		<form action="registration.jsp" method="POST">
			<div>
				Registration page. Please enter your login name and password.
			</div>
			<div>
				Username: <input type="text" name="username"/> <br/>
				Email: <input type="text" name="email"/> <br/>
				Password: <input type="text" name="password"/> <br/>
				Re-enter password: <input type="text" name="reEnterPassword"/> <br/>
				<input type="submit" value="Login"/>
			</div>
		</form>
	</body>
</html>