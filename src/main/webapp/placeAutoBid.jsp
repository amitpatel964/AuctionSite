<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!-- This file is responsible for processing a auto bid of a user.
	 The bid must be at least bidIncrement bigger than the current highest bid.
	 The user cannot bid on their own auction -->

<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Auto bid on an auction</title>
	</head>
	<body>
		<div>
			<a href='userHomePage.jsp'>Home Page</a>
			<a href='logout.jsp'>Log out</a>
		</div>
		<br/>
		<%
			int auctionID = Integer.parseInt(request.getParameter("idHelper"));
			float amount = Float.parseFloat(request.getParameter("amount"));
			String user = session.getAttribute("user").toString();
			Auction auction = HelperFunctions.getAuction(auctionID); 
		%>
		
		<form action="showAuctionDetails.jsp" method="POST">
		
		<input type="hidden" name="idHelper" value="<%= auctionID %>"/>
		
		<%
			// Auction is closed, no more bids can be placed
			if (auction.getStatus().equals("closed")) {
				out.println("This auction has ended and is no longer accepting bids");
				%>
				<input type="submit" value="Go back"/>
				<%
				return;
			}
		%>
		
		<%
		if (user.equals(auction.getCreator())) {
			out.println("You cannot bid on your own auction");
			%>
			<input type="submit" value="Go back"/>
			<%
			return;
		}
		
		float autoBidHighest = auction.getAutoBidHighest();
		float bidIncrement = auction.getBidIncrement();
		float currentPrice = auction.getCurrentPrice();
	
		float minimumBid = currentPrice + bidIncrement;
		
		if (amount - currentPrice < bidIncrement) {
			out.println("The bid amount should be at least " + minimumBid);
			%>
			<input type="submit" value="Go back"/>
			<%
			return;
		}
		
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		float amountForHistory = currentPrice + bidIncrement;
		
		statement.executeUpdate("insert into auctionBidHistory values('"+auctionID+"','"+user+"','"+amountForHistory+"','"+LocalDateTime.now()+"')");
		
		// Check if someone set an auto bid that is higher than the current bid
		if (autoBidHighest > amount + bidIncrement) {
			out.println("Someone has an auto bid placed. You have been outbid");
			float newCurrentPrice = amount + bidIncrement;
			statement.executeUpdate("update auction set currentPrice='" + newCurrentPrice + "' where auctionID='" + auctionID + "'");
			statement.executeUpdate("insert into auctionBidHistory values('"+auctionID+"','"+auction.getCurrentHighestBidder()+"','"+newCurrentPrice+"','"+LocalDateTime.now()+"')");
			%>
			<input type="submit" value="Go back"/>
			<%
			return;
		}
		
		// If autobid was placed by another user and the new auto bid amount is higher,
		// the current price is first set to the highest amount of the previous auto bid
		if (auction.getAutoBidHighest() > auction.getCurrentPrice()){
			currentPrice = autoBidHighest;
		}
		
		float initialBid = currentPrice + bidIncrement;
		
		statement.executeUpdate("update auction set currentPrice='" + initialBid + "' where auctionID='" + auctionID + "'");
		
		// Send out an update if needed
		String currentHighestBidder = auction.getCurrentHighestBidder();
		if (!currentHighestBidder.equals("") && !currentHighestBidder.equals(user)) {
			statement.executeUpdate("insert into alertForBidOrWinner values('outbid','"+currentHighestBidder+"','"+auctionID+"','no')");
		}
		
		statement.executeUpdate("update auction set currentHighestBidder='" + user + "' where auctionID='" + auctionID + "'");
		statement.executeUpdate("update auction set autoBidHighest='" + amount + "' where auctionID='" + auctionID + "'");
		out.println("Bid Placed!");
		
		statement.close();
		con.close();
		%>
		
		</form>
		
	</body>
</html>