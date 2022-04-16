<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
	String auctionName = request.getParameter("auctionName");
	String initialPriceString = request.getParameter("initialPrice");
	String minimumSellingPriceString = request.getParameter("minimumSellingPrice");
	String bidIncrementString = request.getParameter("bidIncrement");
	String vehicleType = request.getParameter("vehicleType");
	String endingDate = request.getParameter("endingDate");
	String endingTime = request.getParameter("endingTime");
	String creator = session.getAttribute("user").toString();
	
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Statement statement = con.createStatement();
	
	int errorCount = 0;
	
	if (auctionName.trim().equals("") || initialPriceString.trim().equals("") || minimumSellingPriceString.trim().equals("") ||
			bidIncrementString.trim().equals("") || vehicleType.trim().equals("") || endingDate.trim().equals("") ||
			endingTime.trim().equals("")) {
		out.println("Please fill in all fields");
		errorCount++;
	}
	
	String[] monthDayYear = endingDate.split("/");
	String[] monthDayTime = endingTime.split(":");
	
	LocalDateTime startingDateTime = LocalDateTime.now();
	
	float initialPrice = Float.parseFloat(initialPriceString);
	float minimumSellingPrice = Float.parseFloat(minimumSellingPriceString);
	float bidIncrement = Float.parseFloat(bidIncrementString);
	
	//int month = Integer.parseInt(monthDayYear[0]);
	//int day = Integer.parseInt(monthDayYear[1]);
	//int year = Integer.parseInt(monthDayYear[2]);
	//int hour = Integer.parseInt(monthDayTime[0]);
	//int minute = Integer.parseInt(monthDayTime[1]);
	
	String dateAndTime = endingDate + " " + endingTime;
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
	LocalDateTime endingDateTime = LocalDateTime.parse(dateAndTime, formatter);
	
	int auctionID = 1000;
	
	ResultSet amountOfAuctions = statement.executeQuery("select count(*) from auction");
	amountOfAuctions.next();
	int amount = amountOfAuctions.getInt(1);
	auctionID += amount;
	
	if (errorCount==0) {
		statement.executeUpdate("insert into auction values('" + auctionID + "','" + creator + "','" + auctionName + "','" + 
			initialPrice + "','" + initialPrice + "','" + minimumSellingPrice + "','" + bidIncrement + "','" + vehicleType + "','" + 
			startingDateTime + "','" + endingDateTime + "')");
		out.println("Auction made!");
		out.println("<a href='userHomePage.jsp'> Click here to go to your home page </a>");
	} else {
		out.println("<a href='createAuctionPage.jsp'> Click here to try again </a>");
	}
%>