<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>

<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Question Details</title>
	</head>
	<body>
		<div>
			<a href='userHomePage.jsp'>Home Page</a>
			<a href='logout.jsp'>Log out</a>
		</div>
		<br/> <br/>
		
		<%
			// Check to see if any open auctions should be ending
			HelperFunctions.checkIfAnyAuctionHasEnded();
			
			int questionID = Integer.parseInt(request.getParameter("idHelper"));
			Question question = HelperFunctions.getQuestion(questionID);
		%>
		
		Asker: <%=question.getUsernameAsker() %> <br/>
		Question Title: <%=question.getQuestionTitle() %> <br/>
		Question Details: <%=question.getQuestionBodyContent() %> <br/>
		</br>
		Responder: <%=question.getUsernameResponder() %> <br/>
		Answer Details: <%=question.getAnswerBodyContent() %> <br/>
	</body>
</html>