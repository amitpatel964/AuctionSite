<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!-- This file shows all of the auctions created at the time of the search. -->

<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Search</title>
	</head>
	
	<body>
		<div>
			<a href='userHomePage.jsp'>Home Page</a>
			<a href='logout.jsp'>Log out</a>
		</div>
		</br>
		<form action="searchAuctionPage.jsp" method="POST">
				Search for specifications:</br></br>
				<label for="vehicleType">Vehicle Specifications</label> </br>
					<select name="vehicleType" id="vehicleType">
						<option value="">--Choose Vehicle Type--</option>
						<option value="Car">Car</option>
						<option value="Suv">Suv</option>
						<option value="Van">Van</option>
						<option value="Truck">Truck</option>
						<option value="Motorcycle">Motorcycle</option>
					</select>
				</br> </br>
				<label for="newOrUsed">Vehicle Condition</label> </br>
					<select name="newOrUsed" id="newOrUsed">
						<option value="">--Choose Vehicle Conditions--</option>
						<option value="New">New</option>
						<option value="Used">Used</option>
					</select>
				</br> </br>
				Max Current Price </br> 
				<input type="text" name="maxCurrentPrice"/> <br/><br/>
			<input type="submit" value="Filter Auctions"/>
			</br></br>
		</form>
		<%
			String vehicleType;
			try {
				vehicleType = request.getParameter("vehicleType");
			} catch (NumberFormatException e) {
				vehicleType = "";
			}
			String newOrUsed;
			try {
				newOrUsed = request.getParameter("newOrUsed");
			} catch (NumberFormatException e) {
				newOrUsed = "";
			}
			float maxCurrentPrice;
			String maxCurrentPriceString = "";
			try {
				maxCurrentPriceString = request.getParameter("maxCurrentPrice");
			} catch (NumberFormatException e) {
				maxCurrentPriceString = "";
			}
			// Check to see if any open auctions should be ending
			HelperFunctions.checkIfAnyAuctionHasEnded();
			List<Auction> allAuctions = HelperFunctions.getListOfAuctions();
			
			for (int i = 0; i < allAuctions.size(); i++) {
				Vehicle vehicle = HelperFunctions.getVehicleFromAuctionID(allAuctions.get(i).getAuctionID());
				if (vehicleType != null && !vehicleType.equals("")){
					if (!vehicleType.equals(allAuctions.get(i).getVehicleType())) {
						continue;
					}
				}
				if (newOrUsed != null && !newOrUsed.equals("")){
					if (!newOrUsed.equals(vehicle.getNewOrUsed())) {
						continue;
					}
				}
				if (maxCurrentPriceString != null && !maxCurrentPriceString.equals("")){
					maxCurrentPrice = Float.parseFloat(maxCurrentPriceString);
					if (maxCurrentPrice < 0) {
						maxCurrentPrice = 0;
					}
					if (maxCurrentPrice < allAuctions.get(i).getCurrentPrice()) {
						continue;
					}
				}
				
				%>
				<form action="showAuctionDetails.jsp" method="POST">
					<input type="hidden" name="idHelper" value="<%= allAuctions.get(i).getAuctionID() %>"/>
					<input type="submit" value="Select this Auction"/>
					Auction: <%= allAuctions.get(i).getAuctionID() %>
					Auction Name: <%= allAuctions.get(i).getAuctionName() %>
					Creator: <%= allAuctions.get(i).getCreator() %>
					Current Price: <%= allAuctions.get(i).getCurrentPrice() %>
					Bid Increment: <%= allAuctions.get(i).getBidIncrement() %>
					Vehicle Type: <%= allAuctions.get(i).getVehicleType() %>
					Ending on: <%= allAuctions.get(i).getEndingDateTime() %>
				</form>
				<br/>
				<%
			}
		%>
	</body>
</html>