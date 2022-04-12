<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
	String auctionName = request.getParameter("auctionName");
	String initialPriceString = request.getParameter("initialPrice");
	String minimumSellingPriceString = request.getParameter("minimumSellingPrice");
	String bidIncrementString = request.getParameter("bidIncrement");
	String vehicleType = request.getParameter("vehicleType");
	String endingDate = request.getParameter("endingDate");
	String endingTime = request.getParameter("endingTime");
	
	int errorCount = 0;
	
	if (auctionName.trim().equals("") || initialPriceString.trim().equals("") || minimumSellingPriceString.trim().equals("") ||
			bidIncrementString.trim().equals("") || vehicleType.trim().equals("") || endingDate.trim().equals("") ||
			endingTime.trim().equals("")) {
		out.println("Please fill in all fields");
		errorCount++;
	}
%>