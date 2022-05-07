<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Create Question</title>
	</head>
	<body>
		<div>
			<a href='userHomePage.jsp'>Home Page</a>
			<a href='logout.jsp'>Log out</a>
		</div>
		<br/> <br/>
		Please enter a question title and provide details about the question.
		<br/>
		<br/>
		<form action="processNewQuestion.jsp" method="POST">
			Question Title: <input type="text" name="questionTitle"/> <br/>
			Question Details: <input type="text" name="questionBodyContent"/> <br/>
			<br/>
			<input type="submit" value="Submit"/>
		</form>
	</body>
</html>