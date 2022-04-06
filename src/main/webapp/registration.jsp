<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
	String username = request.getParameter("username");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String reEnterPassword = request.getParameter("reEnterPassword");
	
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Statement statement = con.createStatement();
	
	// Check if the two password fields match
	// Check to see if the user exists and if email exists
	// If it does, the login name ot email is already taken. If not, add username, email and password to the database.
	
	int errorCount = 0;
	
	if (username.trim().equals("") || username.trim().equals("") || username.trim().equals("") || username.trim().equals("")) {
		out.println("Please fill in all fields");
		errorCount++; 
	}
	if (!password.equals(reEnterPassword)) {
		out.println("Passwords do not match");
		errorCount++;
	}
	ResultSet result = statement.executeQuery("select * from userLogin where username='" + username + "'");
	if (result.next()) {
		out.println("User name already exists");
		errorCount++;
	} 
	ResultSet resultEmail = statement.executeQuery("select * from userLogin where email='" + email + "'");
	if (resultEmail.next()) {
		out.println("Email is being used by another account");
		errorCount++;
	} 
	if (errorCount==0) {
		statement.executeUpdate("insert into userLogin values('" + username + "','" + email + "','" + password + "')");
		out.println("Registration successful!");
		out.println("<a href='login.jsp'> Click here to login </a>");
	} else {
		out.println("<a href='registerUserPage.jsp'> Click here to try again </a>");
	}
%>