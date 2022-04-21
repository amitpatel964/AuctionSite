<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>

<!-- This page generates the details for an auction for a vehicle. Users can place a bid or an auto bid here
	 In addition, if the user comes to this page from an alert, the alert is then seen and updated accordingly -->

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
		%>
		
		Name: <%= auction.getAuctionName() %> <br/>
		Creator: <%= auction.getCreator() %> <br/>
		Initial Price: <%= auction.getInitialPrice() %> <br/>
		Current Price: <%= auction.getCurrentPrice() %> <br/>
		Current Highest Bidder: <%= auction.getCurrentHighestBidder() %> <br/>
		Bid Increment: <%= auction.getBidIncrement() %> <br/>
		<%
			String[] starting = auction.getStartingDateTime().toString().split("T");
			String[] ending = auction.getEndingDateTime().toString().split("T");
		%>
		Starting Date: <%= starting[0] %> <br/>
		Starting Time: <%= starting[1] %> <br/>
		Ending Date: <%= ending[0] %> <br/>
		Ending Time: <%= ending[1] %> <br/>
		<%
			LocalDateTime currentTime = LocalDateTime.now();
			if (currentTime.isBefore(auction.getEndingDateTime())) {
				out.println("open");
			}
		%>
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
		
		View Bid History:
		<form action="showAuctionBidHistory.jsp" method="POST">
			<input type="hidden" name="idHelper" value="<%= auctionID %>"/>
			<input type="submit" value="Go to Bid History"/>
		</form>
		<br/>
		
		Place Bid: 
		<form action="placeBid.jsp" method="POST">
			<input type="hidden" name="idHelper" value="<%= auctionID %>"/>
			<input type="text" name="amount"/> <br/>
			<input type="submit" name="bidButton" value="Place Bid"/>
		</form>
		<br/>
		Place Auto Bid:
		<form action="placeAutoBid.jsp" method="POST">
			<input type="hidden" name="idHelper" value="<%= auctionID %>"/>
			<input type="text" name="amount"/> <br/>
			<input type="submit" name="bidButton" value="Place Auto Bid"/>
		</form>
		<br/>
	</body>
</html>