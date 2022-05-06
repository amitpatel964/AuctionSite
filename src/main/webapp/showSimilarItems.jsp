<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>

<!-- This page is used to show similar items in the preceding month for a given item -->

<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Show similar items</title>
	</head>
	<body>
		<div>
			<a href='userHomePage.jsp'>Home Page</a>
			<a href='logout.jsp'>Log out</a>
		</div>
		<br/> Similar Items
		<br/> <br/>
		<%
			// Check to see if any open auctions should be ending
			HelperFunctions.checkIfAnyAuctionHasEnded();
			
			int auctionID = Integer.parseInt(request.getParameter("idHelper"));
			Auction auction = HelperFunctions.getAuction(auctionID);
			Vehicle vehicleForCheck = HelperFunctions.getVehicleFromAuctionID(auctionID);
			String vehicleType = auction.getVehicleType();
			String manufacturer = vehicleForCheck.getManufacturer();
			String model = vehicleForCheck.getModel();
			
			List<Auction> similarAuctions = new ArrayList<>();
			similarAuctions = HelperFunctions.getSimilarItems(vehicleType, manufacturer, model);
			
			for (int i = 0; i < similarAuctions.size(); i++) {
				Vehicle vehicle = HelperFunctions.getVehicleFromAuctionID(similarAuctions.get(i).getAuctionID());
				
				%>
				<form action="showAuctionDetails.jsp" method="POST">
					<input type="hidden" name="idHelper" value="<%= similarAuctions.get(i).getAuctionID() %>"/>
					<input type="submit" value="Select this Auction"/>
					<strong> Auction: </strong> <%= similarAuctions.get(i).getAuctionID() %>,
					<strong> Auction Name: </strong> <%= similarAuctions.get(i).getAuctionName() %>
					<strong> Creator: </strong> <%= similarAuctions.get(i).getCreator() %>,
					<strong> Manufacturer: </strong> <%= vehicle.getManufacturer() %>,
					<strong> Model: </strong> <%= vehicle.getModel() %>,
					<strong> Current Price: </strong> <%= similarAuctions.get(i).getCurrentPrice() %>,
					<strong> Vehicle Type: </strong> <%= similarAuctions.get(i).getVehicleType() %>,
					<strong> Vehicle Condition: </strong> <%= vehicle.getNewOrUsed() %>,
					<strong> Vehicle Fuel Type: </strong> <%= vehicle.getFuelType() %>,
					<strong> Mileage: </strong> <%= vehicle.getMileage() %>,
					<strong> Miles Per Gallon: </strong> <%= vehicle.getMilesPerGallon() %>,
					<strong> Status: </strong> <%= similarAuctions.get(i).getStatus() %>
				</form>
				<br/>
				<%
			}
		%>
		
		
	</body>
</html>