<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>

<%
	String username = request.getParameter("idHelper");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	
	ApplicationDB db = new ApplicationDB();
	java.sql.Connection con = db.getConnection();
	
	java.sql.Statement statement = con.createStatement();
	
	statement.executeUpdate("update user set email='" + email + "', password='" + password + "', firstName='" + firstName + "', lastName='" + lastName + "' where username='" + username + "'");
	
	statement.close();
	con.close();
	
	out.println("Changes saved!");
	out.println("<a href='custRepHomePage.jsp'> Click here to go to your home page </a>");
%>