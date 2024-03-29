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
		Welcome to our auction site! We let users buy and sell vehicles. <br>
		
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
		<form action="showUserBidHistory.jsp" method="POST">
			<p>
				Click the button below to see auctions you have participated in.
			</p>
			<input type="hidden" name="username" value="<%= session.getAttribute("user") %>"/>
			<input type="submit" value="View Auction History"/>
		</form>
		<form action="createAlertForItem.jsp" method="POST">
			<p>
				Click the button below to create an alert for an item you are looking for.
			</p>
			<input type="hidden" name="username" value="<%= session.getAttribute("user") %>"/>
			<input type="submit" value="Create Alert"/>
		</form>
		<form action="searchQuestionsPage.jsp" method="POST">
			<p>
				Click the button below to see and create questions
			</p>
			<input type="submit" value="Go to Questions Page"/>
		</form>
		
		<h1>Alerts</h1><br/>
		<form action="showAuctionDetails.jsp" method="POST">
			<%
				// Check to see if any open auctions should be ending
				HelperFunctions.checkIfAnyAuctionHasEnded();
				
				// Check if the user was outbid or if they won or lost any auctions
				List<Alert> alertsForUser = HelperFunctions.getAlertsForBidOrWinner(session.getAttribute("user").toString());
				List<Alert> alertsForUserNewItem = HelperFunctions.getAlertsForNewItem(session.getAttribute("user").toString());
				if (alertsForUser.size() == 0 && alertsForUserNewItem.size() == 0) {
					out.println("No alerts at the moment. Please refresh the page if you want to double check");
				} else {
					for (int i = 0; i < alertsForUser.size(); i++) {
						Alert currentAlert = alertsForUser.get(i);
						if (currentAlert.getAlertType().equals("outbid")) {
							out.println("You have been outbid in the auction for " + currentAlert.getAuctionID());
							out.println("Click the button to the right to go to the auction"); %>
							<input type="hidden" name="idHelper" value="<%= currentAlert.getAuctionID() %>"/>
							<input type="submit" value="Go to auction"/> <br/> <%
						} else if (currentAlert.getAlertType().equals("auctionWinner")) {
							out.println("Congratulations, you won the auction for " + currentAlert.getAuctionID());
							out.println("Click the button to the right to go to the auction"); %>
							<input type="hidden" name="idHelper" value="<%= currentAlert.getAuctionID() %>"/>
							<input type="submit" value="Go to auction"/> <br/> <%
						} else if (currentAlert.getAlertType().equals("auctionLost")) {
							out.println("Unfortunately, you lost the auction for " + currentAlert.getAuctionID());
							out.println("Click the button to the right to go to the auction"); %>
							<input type="hidden" name="idHelper" value="<%= currentAlert.getAuctionID() %>"/>
							<input type="submit" value="Go to auction"/> <br/> <%	
						} 
					}
					
					for (int i = 0; i < alertsForUserNewItem.size(); i++) {
						Alert currentAlert = alertsForUserNewItem.get(i);
						if (true) {
							out.println("A new auction was made matching your item requirements!");
							out.println("Click the button to the right to go to the auction"); %>
							<input type="hidden" name="idHelper" value="<%= currentAlert.getAuctionID() %>"/>
							<input type="submit" value="Go to auction"/> <br/> <%
						}
					}
				}
			%>
		</form>
	</body>
</html>