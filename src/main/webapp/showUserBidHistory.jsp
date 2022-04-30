<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
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
			String username = session.getAttribute("user").toString();
			
			List<BidHistory> history = new ArrayList<>();
			history = HelperFunctions.getBidHistoryForUser(username);
		%>
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
						<th><%=history.get(i).getAuctionID()%></th>
						<th><%=history.get(i).getBidAmount()%></th>
						<th><%=splitter[0]%></th>
						<th><%=splitter[1]%></th>
					</tr>
					<%
				}
			%>
		</table>
	</body>
</html>