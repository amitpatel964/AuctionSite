<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>

<!-- Show the auction's bid history from the customer rep's perspective -->

<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Bids for Auction</title>
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
			List<BidHistory> history = new ArrayList<>();
			history = HelperFunctions.getBidHistoryForAuction(auctionID);
		%>
		
		<form action="custRepShowAuctionDetails.jsp" method="POST">
			<input type="hidden" name="idHelper" value="<%= auctionID %>"/>
			<input type="submit" value="Go back to Auction Details"/>
		</form>
		<br/>
		<table>
			<tr>
				<th>Username</th>
				<th>Bid amount</th>
				<th>Date</th>
				<th>Time</th>
			</tr>
			<%
				for (int i = 0; i < history.size(); i++) {
					String dateTime = history.get(i).getBidDateTime().toString();
					String[] splitter = dateTime.split("T");
					%>
					<tr>
						<td><%=history.get(i).getUsername()%></td>
						<td><%=history.get(i).getBidAmount()%></td>
						<td><%=splitter[0]%></td>
						<td><%=splitter[1]%></td>
						<td>
							<form action="custRepDeleteBid.jsp" method="POST">
								<input type="hidden" name="idHelper" value="<%= auctionID %>"/>
								<input type="hidden" name="username" value="<%= history.get(i).getUsername() %>"/>
								<input type="hidden" name="bidAmount" value="<%= history.get(i).getBidAmount() %>"/>
								<input type="submit" value="Delete Bid"/>
							</form>
						</td>
					</tr>
					<%
				}
			%>
		</table>
	</body>
</html>