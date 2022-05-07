<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!-- This file lets the user see the list of questions. It also lets them filter the question by keyword
	 and create a new question. -->

<!DOCTYPE html>

<html>
	<head>
	<meta charset="ISO-8859-1">
		<title>Questions</title>
		</head>
	<body>
		<div>
			<a href='userHomePage.jsp'>Home Page</a>
			<a href='logout.jsp'>Log out</a>
		</div>
		<br/>
		
		<form action="createQuestionPage.jsp" method="POST">
			<p>
				Click the create question button to create a new question
			</p>
			<input type="submit" value="Create Question"/>
		</form>
		<br/>
		List of Questions </br>
		</br>
		
		<% 
			List<Question> questions = new ArrayList<>(); 
			questions = HelperFunctions.getListOfQuestions();
		%>
		
		<table>
			<tr>
				<th>Select Button</th>
				<th>Question ID</th>
				<th>Asker</th>
				<th>Question Title</th>
				<th>Was Question Answered</th>
			</tr>
			
			<% 
				for (int i = 0; i < questions.size(); i++) {
					Question question = questions.get(i);
					%>
					<tr>
					<form action="showQuestionDetails.jsp" method="POST">
						<input type="hidden" name="idHelper" value="<%= question.getQuestionID() %>"/>
						<td> <input type="submit" value="Select this Question"/> </td>
						<td> <%= question.getQuestionID() %> </td>
						<td> <%= question.getUsernameAsker() %> </td>
						<td> <%= question.getQuestionTitle() %> </td>
						<td> <% int wasAnswered = question.getQuestionAnswered();
								if (wasAnswered == 0) {
									out.println("No"); 
								} else {
									out.println("Yes"); 
								} %> </td>	
					</form>
					</tr>
					<%
				}
			%>
		
		</table>
		
	</body>
</html>