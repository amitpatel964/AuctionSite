<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>

<!-- This file is used to show all of the bids a user has made and which auctions they made and bid on -->

<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Bid History</title>
	</head>
	<body>
		<div>
			<a href='userHomePage.jsp'>Home Page</a>
			<a href='logout.jsp'>Log out</a>
		</div>
		<%
			// Check to see if any open auctions should be ending
			HelperFunctions.checkIfAnyAuctionHasEnded();
			String username = request.getParameter("username").toString();
			
			List<BidHistory> history = new ArrayList<>();
			history = HelperFunctions.getBidHistoryForUser(username);
		%>
		History for <% out.println(username); %>
		<br/> <br/>
		Bid History <br/>
		<table>
			<tr>
				<th>AuctionID</th>
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
						<td><%=history.get(i).getAuctionID()%></td>
						<td><%=history.get(i).getBidAmount()%></td>
						<td><%=splitter[0]%></td>
						<td><%=splitter[1]%></td>
						<td>
							<form action="showAuctionDetails.jsp" method="POST">
								<input type="hidden" name="idHelper" value="<%= history.get(i).getAuctionID() %>"/>
								<input type="submit" value="Go to Auction"/>
							</form>
						</td>
					</tr>
					<%
				}
			%>
		</table>
		<br/><br/>
		Unique Auctions Bid on <br/>
		<table>
			<tr>
				<th>AuctionID</th>
			</tr>
			<%
				List<Integer> uniqueAuctions = new ArrayList<>();
				for (int i = 0; i < history.size(); i++) {
					int currentAuctionID = history.get(i).getAuctionID();
					if (!uniqueAuctions.contains(currentAuctionID)) {
						uniqueAuctions.add(currentAuctionID);
					}
				}
					for (int i = 0; i < uniqueAuctions.size(); i++) {
					%>
					<tr>
						<td><%=uniqueAuctions.get(i)%></td>
						<td>
							<form action="showAuctionDetails.jsp" method="POST">
								<input type="hidden" name="idHelper" value="<%= uniqueAuctions.get(i) %>"/>
								<input type="submit" value="Go to Auction"/>
							</form>
						</td>
					</tr>
					<%
				}
			%>
		</table>
		<br/><br/>
		Auctions Created <br/>
		<table>
			<tr>
				<th>AuctionID</th>
			</tr>
			<%
				List<Integer> auctionsCreated = new ArrayList<>();
				auctionsCreated = HelperFunctions.getAuctionsMadeByUser(username);
					for (int i = 0; i < auctionsCreated.size(); i++) {
					%>
					<tr>
						<td><%=auctionsCreated.get(i)%></td>
						<td>
							<form action="showAuctionDetails.jsp" method="POST">
								<input type="hidden" name="idHelper" value="<%= auctionsCreated.get(i) %>"/>
								<input type="submit" value="Go to Auction"/>
							</form>
						</td>
					</tr>
					<%
				}
			%>
		</table>
	</body>
</html>