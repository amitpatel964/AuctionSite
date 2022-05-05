<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!-- This file handles processing a new customer representative account
	 If all of the information was filled in properly, the account for customer representative is created.
	 Otherwise, the user is directed back to fill in the relevant information. -->

<%
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Statement statement = con.createStatement();
	
	if (firstName.trim().equals("") || lastName.trim().equals("") || id.trim().equals("") ||
			email.trim().equals("") || password.trim().equals("")){
		out.println("Please fill in all auction fields");
		out.println("<a href='createCustReps.jsp'> Click here to try again </a>");
		return;
	}else{
		HelperFunctions.createCustomReps(Integer.parseInt(id), firstName, lastName, password, email, true, false);
	}
	
	out.println("Customer Representative made!");
	out.println("<a href='adminHomePage.jsp'> Click here to go to your home page </a>");
