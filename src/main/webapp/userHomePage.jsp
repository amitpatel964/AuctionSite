<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>

<!-- This file is used to show the home page for the user.
From here, the user is able to create an auction, search of an auction, and view their previous auctions. -->

<html>
	<head>
	<meta charset="ISO-8859-1">
		<title>Home Page</title>
	</head>
	
	<body>
		<%=session.getAttribute("user")%>'s Home Page
		<a href='logout.jsp'>Log out</a>
		
		<br>
		Work in progress. <br>
		The home page should allow the user to search for auctions and see what auctions they bidded on. <br>
		Auctions created by the user and the ability for the user to create an auction should also be added. <br>
		It should also have a history of bids and items they sold.
		
		<form action="createAuctionPage.jsp" method="POST">
			<p>
				Click the button below to create a new auction.
			</p>
			<input type="submit" value="Create New Auction"/>
		</form>
		<form action="searchAuctionPage.jsp" method="POST">
			<p>
				Click the button below to search for auctions.
			</p>
			<input type="submit" value="Search Auctions"/>
		</form>
		
		<h1>Alerts</h1><br/>
		<form action="showAuctionDetails.jsp" method="POST">
			<%
				// Check to see if any open auctions should be ending
				HelperFunctions.checkIfAnyAuctionHasEnded();
			
				// Check if the user was outbid or if they won or lost any auctions
				List<Alert> alertsForUser = HelperFunctions.getAlertsForBidOrWinner(session.getAttribute("user").toString());
				if (alertsForUser.size() == 0) {
					out.println("No alerts at the moment. Please refresh the page if you want to double check");
				} else {
					for (int i = 0; i < alertsForUser.size(); i++) {
						Alert currentAlert = alertsForUser.get(i);
						if (currentAlert.getAlertType().equals("outbid")) {
							out.println("You have been outbid in the auction for " + currentAlert.getAuctionID());
							out.println("Click the button below to go to the auction"); %>
							<input type="hidden" name="idHelper" value="<%= currentAlert.getAuctionID() %>"/>
							<input type="submit" value="Go to auction"/> <%
						} else if (currentAlert.getAlertType().equals("auctionWinner")) {
							out.println("Congratulations, you won the auction for " + currentAlert.getAuctionID());
							out.println("Click the button below to go to the auction"); %>
							<input type="hidden" name="idHelper" value="<%= currentAlert.getAuctionID() %>"/>
							<input type="submit" value="Go to auction"/> <%	
						}
					}
				}
			%>
		</form>
	</body>
</html>