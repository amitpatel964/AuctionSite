<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>

<!-- Gets the list of users -->

<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>List of Users</title>
	</head>
	<body>
		<div>
			<a href='custRepHomePage.jsp'>Home Page</a>
			<a href='logout.jsp'>Log out</a>
		</div>
		<br/>
		
		<% 
			List<User> users = new ArrayList<>(); 
			users = HelperFunctions.getListOfUsers();
		%>
		
		<table>
			<tr>
				<th>Select Button</th>
				<th>Username</th>
				<th>Email</th>
			</tr>
			
			<% 
				for (int i = 0; i < users.size(); i++) {
					User user = users.get(i);
					%>
					<tr>
					<form action="custRepShowUserDetails.jsp" method="POST">
						<input type="hidden" name="idHelper" value="<%= user.getUsername() %>"/>
						<td> <input type="submit" value="Select this User"/> </td>
						<td> <%= user.getUsername() %> </td>
						<td> <%= user.getEmail() %> </td>
					</form>
					</tr>
					<%
				}
			%>
		
		</table>
	</body>
</html>