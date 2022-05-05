<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!-- This page handles the process of registration of a new user.
	 If there are any problems, the user is directed back to the register page. -->

<%
	String username = request.getParameter("username");
	String email = request.getParameter("email");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String password = request.getParameter("password");
	String reEnterPassword = request.getParameter("reEnterPassword");
	
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Statement statement = con.createStatement();
	
	// Check if the two password fields match
	// Check to see if the user exists and if email exists
	// If it does, the login name ot email is already taken. If not, add username, email and password to the database.
	
	int errorCount = 0;
	
	if (username.trim().equals("") || username.trim().equals("") || username.trim().equals("") || username.trim().equals("")
			|| firstName.trim().equals("") || lastName.trim().equals("")) {
		out.println("Please fill in all fields");
		errorCount++; 
	}
	if (!password.equals(reEnterPassword)) {
		out.println("Passwords do not match");
		errorCount++;
	}
	ResultSet result = statement.executeQuery("select * from user where username='" + username + "'");
	if (result.next() || username.toLowerCase().equals("admin")) {
		out.println("User name already exists");
		errorCount++;
	} 
	ResultSet resultEmail = statement.executeQuery("select * from user where email='" + email + "'");
	if (resultEmail.next()) {
		out.println("Email is being used by another account");
		errorCount++;
	} 
	if (errorCount==0) {
		statement.executeUpdate("insert into user values('" + username + "','" + email + "','" + firstName + "','" + lastName + "','" + password + "','" + 0 + "')");
		out.println("Registration successful!");
		out.println("<a href='login.jsp'> Click here to login </a>");
	} else {
		out.println("<a href='registerUserPage.jsp'> Click here to try again </a>");
	}
%>