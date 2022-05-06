<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!-- This file verifies that the login information that the user entered is in the database. -->

<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Statement statement = con.createStatement();
	
	ResultSet result = statement.executeQuery("select * from user where username='" + username 
			+ "' and password='" + password + "'");
	
	// Chcek to see if the user exists and if the password is correct
	if (result.next()) {
		
		int isCustRep = result.getInt("isCustRep");
		
		if (isCustRep == 0) {
			session.setAttribute("user", username);
			out.println("Welcome " + username);
			out.println("<a href='logout.jsp'> Logout </a>");
			response.sendRedirect("successLogin.jsp");
			return;
		} else {
			session.setAttribute("user", username);
			out.println("Welcome " + username);
			out.println("<a href='logout.jsp'> Logout </a>");
			response.sendRedirect("successLoginCustRep.jsp");
		}
	}
	
	ResultSet resultAdmin = statement.executeQuery("select * from admin where username='" + username 
			+ "' and password='" + password + "'");
	
	// Chcek to see if the admin is trying to log in
		if (resultAdmin.next()) {
			session.setAttribute("user", username);
			out.println("Welcome " + username);
			out.println("<a href='logout.jsp'> Logout </a>");
			response.sendRedirect("successLoginAdmin.jsp");
			return;
		}
	
	out.println("User name or password are incorrect <a href='login.jsp'> Click here to try again </a>");
	
%>