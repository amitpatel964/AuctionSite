<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Auction Details</title>
	</head>
	
	<body>
		<div>
			<a href='userHomePage.jsp'>Home Page</a>
			<a href='logout.jsp'>Log out</a>
		</div>
		<%= request.getParameter("idHelper") %> <br/>
		<%
			int auctionID = Integer.parseInt(request.getParameter("idHelper"));
			Vehicle vehicle = HelperFunctions.getVehicleFromAuctionID(auctionID);
		%>
		<%= vehicle.getVin() %> <br/>
		Number Of Doors: <%= vehicle.getNumberOfDoors() %> <br/>
		Number Of Wheels: <%= vehicle.getNumberOfWheels() %> <br/>
		Number Of Seats: <%= vehicle.getNumberOfSeats() %> <br/>
	</body>
</html>