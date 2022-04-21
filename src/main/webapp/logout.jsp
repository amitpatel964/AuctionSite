<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!-- This file handles logging the user out -->

<% 
	session.getAttribute("username");
	session.invalidate();
	response.sendRedirect("login.jsp");
%>