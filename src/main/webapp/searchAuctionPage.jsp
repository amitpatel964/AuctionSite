<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
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
		
		<%
			// Check to see if any open auctions should be ending
			HelperFunctions.checkIfAnyAuctionHasEnded();
			List<Auction> allAuctions = HelperFunctions.getListOfAuctions();
			
			for (int i = 0; i < allAuctions.size(); i++) {
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