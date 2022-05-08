<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Customer Rep Home Page</title>
	</head>
	<body>
		<%=session.getAttribute("user")%>'s Home Page
		<a href='logout.jsp'>Log out</a>
		<br/> <br/>
		Customer Rep Home Page <br/>
		<br/>
		<form action="custRepListUsers.jsp" method="POST">
			Click the button below to view, edit and delete a user's information <br/>
			<input type="submit" value="Change User Information"/>
		</form>
		<br/>
		<form action="custRepListQuestions.jsp" method="POST">
			Click the button below to view and answer questions <br/>
			<input type="submit" value="Go to Questions"/>
		</form>
		<br/>
		<form action="custRepListAuctions.jsp" method="POST">
			Click the button below to view auctions and bids and delete them <br/>
			<input type="submit" value="Search Auctions"/>
		</form>
		<br/>
	</body>
</html>