<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
	int auctionID = Integer.parseInt(request.getParameter("idHelper"));
	
	ApplicationDB db = new ApplicationDB();
	java.sql.Connection con = db.getConnection();
	
	java.sql.Statement statement = con.createStatement();
	
	// Delete all bids for auction since the auction is being deleted
	statement.executeUpdate("delete from auctionBidHistory where auctionID='"+auctionID+"'");
	
	// Delete vehicle associated with auction
	Vehicle vehicle = HelperFunctions.getVehicleFromAuctionID(auctionID);
	int vin = vehicle.getVin();
	
	statement.executeUpdate("delete from car where vin='"+vin+"'");
	statement.executeUpdate("delete from suv where vin='"+vin+"'");
	statement.executeUpdate("delete from van where vin='"+vin+"'");
	statement.executeUpdate("delete from truck where vin='"+vin+"'");
	statement.executeUpdate("delete from motorcycle where vin='"+vin+"'");
	statement.executeUpdate("delete from vehicle where auctionID='"+auctionID+"'");
	
	// Delete alerts assocaited with auction
	statement.executeUpdate("delete from alertForBidOrWinner where auctionID='"+auctionID+"'");
	statement.executeUpdate("delete from alertNotifyIfOutbid where auctionID='"+auctionID+"'");
	statement.executeUpdate("delete from alertForNewItems where auctionID='"+auctionID+"'");
			
	// Now delete auction
	statement.executeUpdate("delete from auction where auctionID='"+auctionID+"'");
	
	out.println("Auction deleted!");
	out.println("<a href='custRepHomePage.jsp'> Click here to go to your home page </a>");
%>