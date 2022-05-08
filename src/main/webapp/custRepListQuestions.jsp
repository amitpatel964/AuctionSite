<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>

<!-- Gets the list of questions from a customer rep view -->

<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Questions</title>
	</head>
	<body>
		<div>
			<a href='custRepHomePage.jsp'>Home Page</a>
			<a href='logout.jsp'>Log out</a>
		</div>
		<br/>
		
		Search Questions by keyword in title:
		<br/>
		<form action="custRepListQuestionsPage.jsp" method="POST">
			Keyword:
			<input type="text" name="keyword"/> <br/><br/>
			<input type="submit" value="Search Questions"/>
		</form>
		<br/>
		List of Questions </br>
		</br>
		
		<% 
			List<Question> questions = new ArrayList<>(); 
			questions = HelperFunctions.getListOfQuestions();
			
			String keyword;
			try {
				keyword = request.getParameter("keyword");
			} catch (NumberFormatException e) {
				keyword = "";
			}
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
					if (keyword != null && !keyword.equals("")) {
						if (!question.getQuestionTitle().toLowerCase().contains(keyword.toLowerCase())) {
							continue;
						}
					}
					%>
					<tr>
					<form action="custRepShowQuestionDetails.jsp" method="POST">
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