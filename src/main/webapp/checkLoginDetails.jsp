<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>

<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String path = "jdbc:mysql://localhost3306/auctionSitedb";
	Class.forName("com.mysql.jdbc.Driver");
	Connection connection = DriverManager.getConnection(path,"root","Paratrooper99");
	
	Statement statement = connection.createStatement();
	ResultSet result = statement.executeQuery("select * from users where username='" + username 
			+ "' and password='" + password + "'");
	
	// Chcek to see if the user exists and if the password is correct
	if (result.next()) {
		session.setAttribute("user", username);
		out.println("Welcome " + username);
		out.println("<a href='logout.jsp'> Logout </a>");
		response.sendRedirect("successLogin.jsp");
	} else {
		out.println("User name or password are incorrect <a href='login.jsp'> Click here to try again </a>");
	}
%>