<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!-- This file is responsible for processing a regular bid of a user.
	 The bid must be at least bidIncrement bigger than the current highest bid
	 The user cannot bid on their own auction -->

<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Bidding on an auction</title>
	</head>
	
	<body>
		<div>
			<a href='userHomePage.jsp'>Home Page</a>
			<a href='logout.jsp'>Log out</a>
		</div>
		<br/>
		<%
			int auctionID = Integer.parseInt(request.getParameter("idHelper"));
			String amountString = request.getParameter("amount");
			float amount;
			try {
				amount = Float.parseFloat(request.getParameter("amount"));
			} catch (Exception e) {
				amount = 0;
			}
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
		
			float minimumBid = auction.getCurrentPrice() + auction.getBidIncrement();
			
			if (amount - auction.getCurrentPrice() < auction.getBidIncrement()) {
				out.println("The bid amount should be at least " + minimumBid);
				%>
				<input type="submit" value="Go back"/>
				<%
				return;
			}
			
			ApplicationDB db = new ApplicationDB();
			java.sql.Connection con = db.getConnection();
			
			java.sql.Statement statement = con.createStatement();
			
			statement.executeUpdate("insert into auctionBidHistory values('"+auctionID+"','"+user+"','"+amount+"','"+LocalDateTime.now()+"')");
			
			// Check if someone set an auto bid that is higher than the current bid
			if (auction.getAutoBidHighest() > amount + auction.getBidIncrement()) {
				out.println("Someone has an auto bid placed. You have been outbid");
				float newCurrentPrice = amount + auction.getBidIncrement();
				statement.executeUpdate("update auction set currentPrice='" + newCurrentPrice + "' where auctionID='" + auctionID + "'");
				statement.executeUpdate("insert into auctionBidHistory values('"+auctionID+"','"+auction.getCurrentHighestBidder()+"','"+newCurrentPrice+"','"+LocalDateTime.now()+"')");
				%>
				<input type="submit" value="Go back"/>
				<%
				return;
			}
				
			statement.executeUpdate("update auction set currentPrice='" + amount + "' where auctionID='" + auctionID + "'");
			
			String shouldNotify = request.getParameter("wantAlertIfOutbid");
			
			statement.executeUpdate("insert into alertNotifyIfOutbid values('" + shouldNotify + "','" + user + "','" + auctionID + "')");
			
			// Send out an alert if needed
			String currentHighestBidder = auction.getCurrentHighestBidder();
			if (!currentHighestBidder.equals("") && !currentHighestBidder.equals(user)) {
				ResultSet result = statement.executeQuery("select * from alertNotifyIfOutbid where username = '"+ currentHighestBidder +"' and auctionID ='" + auctionID + "'");
				result.next();
				String shouldNotifyResult = result.getString("shouldNotify");
				if (shouldNotifyResult.equals("Yes")) {
					statement.executeUpdate("insert into alertForBidOrWinner values('outbid','"+currentHighestBidder+"','"+auctionID+"','no')");
				}
				statement.executeUpdate("delete from alertNotifyIfOutbid where username = '"+ currentHighestBidder +"' and auctionID ='" + auctionID + "'");
			}
			
			ResultSet result = statement.executeQuery("select * from alertNotifyIfOutbid where auctionID ='" + auctionID + "'");
			
			statement.executeUpdate("update auction set currentHighestBidder='" + user + "' where auctionID='" + auctionID + "'");
			out.println("Bid Placed!");
			
			statement.close();
			con.close();
		%>
		
		</form>
		
	</body>
</html>