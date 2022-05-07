<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

 <%
	String questionTitle = request.getParameter("questionTitle");
	String questionBodyContent = request.getParameter("questionBodyContent");
	String creator = session.getAttribute("user").toString();
	
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Statement statement = con.createStatement();
	
	if (questionTitle.trim().equals("") || questionBodyContent.trim().equals("")) {
		out.println("Please fill in both question fields");
		out.println("<a href='createAuctionPage.jsp'> Click here to try again </a>");
		return;
	}
	
	int questionID = 1;
	
	ResultSet amountOfQuestionss = statement.executeQuery("select count(*) from questionAndAnswer");
	amountOfQuestionss.next();
	int amount = amountOfQuestionss.getInt(1);
	questionID += amount;
	
	String responder = "";
	String answer = "";
	int questionAnswered = 0;
	
	statement.executeUpdate("insert into questionAndAnswer values('" + questionID + "','" + creator + "','" + 
			questionTitle + "','" + questionBodyContent + "','" + responder + "','" + answer + "','" + questionAnswered + "')");
	
	out.println("Question made!");
	out.println("<a href='userHomePage.jsp'> Click here to go to your home page </a>");
 %>   