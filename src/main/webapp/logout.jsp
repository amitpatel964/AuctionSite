<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% 
	session.invalidate();
	session.getAttribute("user");
	response.sendRedirect("login.jsp");
%>