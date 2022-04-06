<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Login Check</title>
	</head>
	<body>
		<%
			if (session.getAttribute("user") == null) {
		%>
				Login was not successful. <a href="login.jsp">Please try again</a>
		<%
			} else {
		%>
			Welcome <%=session.getAttribute("user")%>
			<a href='logout.jsp'>Log out</a> <br>
			<a href='userHomePage.jsp'>Click here to go to your home page</a>
			<% } %>
	</body>
</html>