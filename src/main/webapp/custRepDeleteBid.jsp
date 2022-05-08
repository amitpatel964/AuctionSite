<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
	int auctionID = Integer.parseInt(request.getParameter("idHelper"));
	String username = request.getParameter("username");
	float bidAmount = Float.parseFloat(request.getParameter("bidAmount"));
	Auction auction = HelperFunctions.getAuction(auctionID);
	
	ApplicationDB db = new ApplicationDB();
	java.sql.Connection con = db.getConnection();
	
	java.sql.Statement statement = con.createStatement();
	
	statement.executeUpdate("delete from auctionBidHistory where auctionID='"+auctionID+"' and username='"+username+"' and bidAmount = '"+bidAmount+"'");
	
	ResultSet amountOfBids = statement.executeQuery("select count(*) from auctionBidHistory where auctionID='"+auctionID+"'");
	amountOfBids.next();
	
	int numberOfBidsLeft = amountOfBids.getInt(1);
	if (numberOfBidsLeft == 0) {
		float initialPrice = auction.getInitialPrice();
		statement.executeUpdate("update auction set currentPrice='" + initialPrice + "' where auctionID='" + auctionID + "'");
		statement.executeUpdate("update auction set currentHighestBidder='' where auctionID='" + auctionID + "'");
		statement.executeUpdate("update auction set autoBidHighest='0' where auctionID='" + auctionID + "'");
	} else {
		ResultSet maxBidAmount = statement.executeQuery("select MAX(bidAmount) AS biggest from auctionBidHistory where auctionID='" + auctionID + "'");
		maxBidAmount.next();
		int largestBidLeft = maxBidAmount.getInt(1);
		ResultSet userOfBid = statement.executeQuery("select username from auctionBidHistory where auctionID='" + auctionID + "' and bidAmount='"+largestBidLeft+"'");
		userOfBid.next();
		String newHighestBidder = userOfBid.getString(1);
		statement.executeUpdate("update auction set currentPrice='" + largestBidLeft + "' where auctionID='" + auctionID + "'");
		statement.executeUpdate("update auction set currentHighestBidder='" + newHighestBidder + "' where auctionID='" + auctionID + "'");
	}
	
	statement.close();
	con.close();
	
	out.println("Bid deleted!");
	out.println("<a href='custRepHomePage.jsp'> Click here to go to your home page </a>");
%>