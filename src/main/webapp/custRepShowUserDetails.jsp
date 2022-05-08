<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>

<!-- This page let a customer rep change a user's info -->

<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Change user info</title>
	</head>
	<body>
		<div>
			<a href='custRepHomePage.jsp'>Home Page</a>
			<a href='logout.jsp'>Log out</a>
		</div>
		<br/>
		
		<%
			String username = request.getParameter("idHelper");
			User user = HelperFunctions.getUser(username);
		%>
		
		Change a user's first name, last name, email, and password.
		<br/>
		
		<form action="custRepProcessUserChanges.jsp" method="POST">
			<input type="hidden" name="idHelper" value="<%= username %>"/>
			Email: <input type="text" name="email" value="<%= user.getEmail() %>"/> <br/>
			Password: <input type="text" name="password" value="<%= user.getPassword() %>"/> <br/>
			First Name: <input type="text" name="firstName" value="<%= user.getFirstName() %>"/> <br/>
			Last Name: <input type="text" name="lastName" value="<%= user.getLastName() %>"/> <br/>
			<input type="submit" value="Submit"/>
		</form>
		
	</body>
</html>