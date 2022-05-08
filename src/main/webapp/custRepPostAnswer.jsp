<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
	int questionID = Integer.parseInt(request.getParameter("idHelper"));
	String answerBodyContent = request.getParameter("answerBodyContent");
	Question question = HelperFunctions.getQuestion(questionID);
	
	ApplicationDB db = new ApplicationDB();
	java.sql.Connection con = db.getConnection();
	
	java.sql.Statement statement = con.createStatement();
	
	statement.executeUpdate("update questionAndAnswer set usernameResponder='" + session.getAttribute("user").toString() + "', answerBodyContent='" + answerBodyContent + "', questionAnswered='1' where questionID='" + questionID + "'");
	
	statement.close();
	con.close();
	
	out.println("Answer posted!");
	out.println("<a href='custRepHomePage.jsp'> Click here to go to your home page </a>");
%>