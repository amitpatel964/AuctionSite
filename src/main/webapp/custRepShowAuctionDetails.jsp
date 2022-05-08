<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>

<!-- Shows auction details from a customer rep's perspective -->

<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Auction Details</title>
	</head>
	<body>
		<div>
			<a href='custRepHomePage.jsp'>Home Page</a>
			<a href='logout.jsp'>Log out</a>
		</div>
		<br/>
		
		<%
			// Check to see if any open auctions should be ending
			HelperFunctions.checkIfAnyAuctionHasEnded();
			
			int auctionID = Integer.parseInt(request.getParameter("idHelper"));
			Auction auction = HelperFunctions.getAuction(auctionID);
		%>
		
		<%
		// Check to see if the user has any alerts for this auction.
		// If they do, they were seen and do not need to be displayed again
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		statement.executeUpdate("update alertForBidOrWinner set wasSeen='yes' where auctionID='"+auctionID+"' and username='"+session.getAttribute("user")+"'");
		statement.executeUpdate("update alertForNewItems set wasSeen='yes' where auctionID='"+auctionID+"' and username='"+session.getAttribute("user")+"'");
		%>
		Auction for: <br/>
		Name: <%= auction.getAuctionName() %> <br/>
		Creator: <%= auction.getCreator() %> 
		<br/>
		Initial Price: <%= auction.getInitialPrice() %> <br/>
		Current Price: <%= auction.getCurrentPrice() %> <br/>
		<%
			if (auction.getStatus().equals("open")){
			%>
				Current Highest Bidder: <% 
				if (auction.getCurrentHighestBidder().equals("")){
					out.println("None");
				} else {
					out.println(auction.getCurrentHighestBidder());
				}
				%> 
			<%
			} else {
				%>
				Winner: <% 
				if (auction.getWinner().equals("")){
					out.println("None");
				} else {
					out.println(auction.getWinner());
				}
			}
		%> <br/>
		
		Bid Increment: <%= auction.getBidIncrement() %> <br/>
		<%
			String[] starting = auction.getStartingDateTime().toString().split("T");
			String[] ending = auction.getEndingDateTime().toString().split("T");
		%>
		Starting Date: <%= starting[0] %> <br/>
		Starting Time: <%= starting[1] %> <br/>
		Ending Date: <%= ending[0] %> <br/>
		Ending Time: <%= ending[1] %> <br/>
		Status: 
		<%
			LocalDateTime currentTime = LocalDateTime.now();
			if (auction.getStatus().equals("open")) {
				out.println("Open");
			} else {
				out.println("Closed");
			}
		%>
		<br/> <br/>
		
		<%
			Vehicle vehicle = HelperFunctions.getVehicleFromAuctionID(auctionID);
		%>
		Vehicle Details: <br/>
		Manufacturer: <%= vehicle.getManufacturer() %> <br/>
		Model: <%= vehicle.getModel() %> <br/>
		Type of Vehicle: <%= auction.getVehicleType() %> <br/>
		Number Of Doors: <%= vehicle.getNumberOfDoors() %> <br/>
		Number Of Seats: <%= vehicle.getNumberOfSeats() %> <br/>
		Mileage: <%= vehicle.getMileage() %> miles <br/>
		Miles Per Gallon: <%= vehicle.getMilesPerGallon() %> miles per gallon <br/>
		Fuel Type: <%= vehicle.getFuelType() %> <br/>
		Condition: <%= vehicle.getNewOrUsed() %> <br/>
		Year: <%= vehicle.getYear() %> <br/>
		Color: <%= vehicle.getColor() %> <br/>
		Transmission: <%= vehicle.getTransmissionType() %> <br/>
		<%
		if (auction.getVehicleType().equals("Car")) {
			Car car = HelperFunctions.getCarFromVin(vehicle.getVin());
			%>
			Type of Car: <%= car.getTypeOfCar() %> <br/>
			Is Convertible: <%= car.getIsConvertible() %> <br/>
			<%
		} else if (auction.getVehicleType().equals("Suv")) {
			Suv suv = HelperFunctions.getSuvFromVin(vehicle.getVin());
			%>
			Expandable Seats: <%= suv.getSeatsExpandable() %> <br/>
			<%
		} else if (auction.getVehicleType().equals("Van")) {
			Van van = HelperFunctions.getVanFromVin(vehicle.getVin());
			%>
			Mini or Full Van: <%= van.getVanMiniOrFull() %> <br/>
			<%
		} else if (auction.getVehicleType().equals("Truck")) {
			Truck truck = HelperFunctions.getTruckFromVin(vehicle.getVin());
			%>
			Is Pickup Truck: <%= truck.getIsPickUpTruck() %> <br/>
			Number Of Wheels: <%= truck.getNumberOfWheels() %> <br/>
			<%
		} else {
			Motorcycle motorcycle = HelperFunctions.getMotorcycleFromVin(vehicle.getVin());
			%>
			Type of Motorcycle: <%= motorcycle.getTypeOfMotorCycle() %> <br/>
			Has Storage: <%= motorcycle.getHasStorage() %> <br/>
			<%
		}
		%>
		<br/>
		
		View bid history and delete bids:
		<form action="custRepShowAuctionBids.jsp" method="POST">
			<input type="hidden" name="idHelper" value="<%= auctionID %>"/>
			<input type="submit" value="Go to Bid History"/>
		</form>
		<br/>
		Delete auction: <br/>
		<form action="custRepDeleteAuction.jsp" method="POST">
			<input type="hidden" name="idHelper" value="<%= auctionID %>"/>
			<input type="submit" value="Delete auction"/>
		</form>
		<br/>
		
	</body>
</html>