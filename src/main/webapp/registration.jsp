<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String reEnterPassword = request.getParameter("reEnterPassword");
	
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Statement statement = con.createStatement();
	
	ResultSet result = statement.executeQuery("select * from userLogin where username='" + username + "'");
	
	// Check if the two password fields match
	// Check to see if the user exists
	// If it does, the login name is already taken. If not, data username and password to the database.
	if (!password.equals(reEnterPassword)) {
		out.println("Passwords do not match <a href='registerUserPage.jsp'> Click here to try again </a>");
	} else if (result.next()) {
		out.println("User name already exists <a href='registerUserPage.jsp'> Click here to try again </a>");
	} else {
		statement.executeUpdate("insert into userLogin values('" + username + "','" + password + "')");
		out.println("Registration successful!");
		out.println("<a href='login.jsp'> Click here to login </a>");
	}
%>