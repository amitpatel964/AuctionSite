<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

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
			float amount = Float.parseFloat(request.getParameter("amount"));
			String user = session.getAttribute("user").toString();
			Auction auction = HelperFunctions.getAuction(auctionID); 
		%>
		
		<form action="showAuctionDetails.jsp" method="POST">
		
		<input type="hidden" name="idHelper" value="<%= auctionID %>"/>
			
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
			
			String string = "update auction set currentPrice=? where auctionID=" + auctionID;
			statement = con.prepareStatement(string);
			out.println("Bid Placed!");
			
			statement.close();
			con.close();
		%>
		
		</form>
		
	</body>
</html>