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
				<label for="fuelType">Vehicle Fuel Type</label> </br>
					<select name="fuelType" id="fuelType">
						<option value="">--Choose Vehicle Fuel Type--</option>
						<option value="New">Gasoline</option>
						<option value="Used">Electric</option>
						<option value="Used">Hybrid</option>
					</select>
				</br> </br>
				Maximum Current Price </br> 
				<input type="text" name="maxCurrentPrice"/> <br/><br/>
				Manufacturer </br> 
				<input type="text" name="manufacturer"/> <br/><br/>
				Model </br> 
				<input type="text" name="model"/> <br/><br/>
				Maximum Mileage </br> 
				<input type="text" name="maxMileage"/> <br/><br/>
				Minimum Miles Per Gallon </br> 
				<input type="text" name="minimumMPG"/> <br/><br/>
				<label for="status">Auction Status</label> </br>
					<select name="status" id="status">
					<option value="">--Choose Auction Status--</option>
						<option value="">Open and Closed</option>
						<option value="open">Open only</option>
					</select>
				</br> </br>
				<label for="sortAuctions">Sort Auctions</label> </br>
					<select name="sortAuctions" id="sortAuctions">
						<option value="">--Choose how to Sort Auctions--</option>
						<option value="Manufacturer">Manufacturer</option>
						<option value="VehicleType">Vehicle Type</option>
						<option value="MilesPerGallon">Miles Per Gallon - Descending</option>
						<option value="Mileage">Mileage - Ascending</option>
						<option value="CurrentPrice">Current Price - Ascending</option>
					</select>
				</br> </br>
			<input type="submit" value="Filter and/or Sort Auctions"/>
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
			
			String manufacturer;
			try {
				manufacturer = request.getParameter("manufacturer");
			} catch (NumberFormatException e) {
				manufacturer = "";
			}
			
			String model;
			try {
				model = request.getParameter("model");
			} catch (NumberFormatException e) {
				model = "";
			}
			
			String minimumMPGString;
			int minimumMPG = 0;
			try {
				minimumMPGString = request.getParameter("minimumMPG");
			} catch (NumberFormatException e) {
				minimumMPGString = "";
			}
			
			String fuelType;
			try {
				fuelType = request.getParameter("fuelType");
			} catch (NumberFormatException e) {
				fuelType = "";
			}
			
			String maxMileageString;
			int maxMileage = 0;
			try {
				maxMileageString = request.getParameter("maxMileage");
			} catch (NumberFormatException e) {
				maxMileageString = "";
			}
			
			String status;
			try {
				status = request.getParameter("status");
			} catch (NumberFormatException e) {
				status = "";
			}
			
			String sortType;
			try {
				sortType = request.getParameter("sortAuctions");
			} catch (NumberFormatException e) {
				sortType = "";
			}
			// Check to see if any open auctions should be ending
			HelperFunctions.checkIfAnyAuctionHasEnded();
			List<Auction> allAuctions = HelperFunctions.getListOfAuctions();
			
			if (sortType != null && !sortType.equals("")){
				if (sortType.equals("Manufacturer")){
					List<Auction> sortedList = HelperFunctions.sortAuctionsByManufacturer(allAuctions);
					allAuctions = sortedList;
				} else if (sortType.equals("VehicleType")) {
					List<Auction> sortedList = HelperFunctions.sortAuctionsByVehicleType(allAuctions);
					allAuctions = sortedList;
				} else if (sortType.equals("MilesPerGallon")) {
					List<Auction> sortedList = HelperFunctions.sortAuctionsByMilesPerGallon(allAuctions);
					allAuctions = sortedList;
				} else if (sortType.equals("Mileage")) {
					List<Auction> sortedList = HelperFunctions.sortAuctionsByMileage(allAuctions);
					allAuctions = sortedList;
				} else if (sortType.equals("CurrentPrice")) {
					List<Auction> sortedList = HelperFunctions.sortAuctionsByCurrentPrice(allAuctions);
					allAuctions = sortedList;
				}
			}
			
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
				if (manufacturer != null && !manufacturer.equals("")){
					if (!manufacturer.equals(vehicle.getManufacturer())) {
						continue;
					}
				}
				if (model != null && !model.equals("")){
					if (!model.equals(vehicle.getModel())) {
						continue;
					}
				}
				if (minimumMPGString != null && !minimumMPGString.equals("")){
					minimumMPG = Integer.parseInt(minimumMPGString);
					if (minimumMPG < 0) {
						minimumMPG = 0;
					}
					if (minimumMPG > vehicle.getMilesPerGallon()) {
						continue;
					}
				}
				if (fuelType != null && !fuelType.equals("")){
					if (!fuelType.equals(vehicle.getFuelType())) {
						continue;
					}
				}
				if (maxMileageString != null && !maxMileageString.equals("")){
					maxMileage = Integer.parseInt(maxMileageString);
					if (maxMileage < 0) {
						maxMileage = 0;
					}
					if (maxMileage < vehicle.getMileage()) {
						continue;
					}
				}
				if (status != null && !status.equals("")){
					if (!status.equals(allAuctions.get(i).getStatus())) {
						continue;
					}
				}
				
				%>
				<form action="showAuctionDetails.jsp" method="POST">
					<input type="hidden" name="idHelper" value="<%= allAuctions.get(i).getAuctionID() %>"/>
					<input type="submit" value="Select this Auction"/>
					<strong> Auction: </strong> <%= allAuctions.get(i).getAuctionID() %>,
					<strong> Auction Name: </strong> <%= allAuctions.get(i).getAuctionName() %>
					<strong> Creator: </strong> <%= allAuctions.get(i).getCreator() %>,
					<strong> Manufacturer: </strong> <%= vehicle.getManufacturer() %>,
					<strong> Model: </strong> <%= vehicle.getModel() %>,
					<strong> Current Price: </strong> <%= allAuctions.get(i).getCurrentPrice() %>,
					<strong> Vehicle Type: </strong> <%= allAuctions.get(i).getVehicleType() %>,
					<strong> Vehicle Condition: </strong> <%= vehicle.getNewOrUsed() %>,
					<strong> Vehicle Fuel Type: </strong> <%= vehicle.getFuelType() %>,
					<strong> Mileage: </strong> <%= vehicle.getMileage() %>,
					<strong> Miles Per Gallon: </strong> <%= vehicle.getMilesPerGallon() %>,
					<strong> Status: </strong> <%= allAuctions.get(i).getStatus() %>
				</form>
				<br/>
				<%
			}
		%>
	</body>
</html>