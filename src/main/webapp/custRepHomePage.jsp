<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Customer Rep Home Page</title>
	</head>
	<body>
		<a href="replyUserQuestions.jsp"> Reply to user questions</a>
		<br>
		<%=session.getAttribute("user")%>'s Home Page
		<a href='logout.jsp'>Log out</a>
		<br/> <br/>
		Customer Rep Home Page
	</body>
</html>