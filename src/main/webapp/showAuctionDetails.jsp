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
		<br/>
		<%
			int auctionID = Integer.parseInt(request.getParameter("idHelper"));
			Auction auction = HelperFunctions.getAuction(auctionID);
		%>
		Name: <%= auction.getAuctionName() %> <br/>
		Creator: <%= auction.getCreator() %> <br/>
		Initial Price: <%= auction.getInitialPrice() %> <br/>
		Current Price: <%= auction.getCurrentPrice() %> <br/>
		Bid Increment: <%= auction.getBidIncrement() %> <br/>
		<%
			String[] starting = auction.getStartingDate().toString().split("T");
			String[] ending = auction.getEndingDate().toString().split("T");
		%>
		Starting Date: <%= starting[0] %> <br/>
		Starting Time: <%= starting[1] %> <br/>
		Ending Date: <%= ending[0] %> <br/>
		Ending Time: <%= ending[1] %> <br/>
		<br/>
		
		Auction for: 
		<%
			Vehicle vehicle = HelperFunctions.getVehicleFromAuctionID(auctionID);
		%>
		Vehicle Details: <br/>
		Number Of Doors: <%= vehicle.getNumberOfDoors() %> <br/>
		Number Of Seats: <%= vehicle.getNumberOfSeats() %> <br/>
		Mileage: <%= vehicle.getMileage() %> miles <br/>
		Miles Per Gallon: <%= vehicle.getMilesPerGallon() %> miles per gallon <br/>
		Fuel Type: <%= vehicle.getFuelType() %> <br/>
		Condition: <%= vehicle.getNewOrUsed() %> <br/>
		Manufacturer: <%= vehicle.getManufacturer() %> <br/>
		Model: <%= vehicle.getModel() %> <br/>
		Year: <%= vehicle.getYear() %> <br/>
		Color: <%= vehicle.getColor() %> <br/>
		Drive Type: <%= vehicle.getWheelDriveType() %> <br/>
		Transmission: <%= vehicle.getTransmissionType() %> <br/>
		<br/>
		
		Place bid: 
		<form action="placeBid.jsp" method="POST">
			<input type="hidden" name="idHelper" value="<%= auctionID %>"/>
			<input type="text" name="amount"/> <br/>
			<input type="submit" value="Place Bid"/>
		</form>
	</body>
</html>