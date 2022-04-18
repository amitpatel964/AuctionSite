<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
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
	
	if (auctionName.trim().equals("") || initialPriceString.trim().equals("") || minimumSellingPriceString.trim().equals("") ||
			bidIncrementString.trim().equals("") || endingDate.trim().equals("") ||
			endingTime.trim().equals("")) {
		out.println("Please fill in all auction fields");
		out.println("<a href='createAuctionPage.jsp'> Click here to try again </a>");
		return;
	}
	
	int vin = 0;
	int numberOfDoors = 0;
	int numberOfSeats = 0;
	int mileage = 0;
	int milesPerGallon = 0;
	String fuelType = request.getParameter("fuelType");
	String newOrUsed = request.getParameter("newOrUsed");
	String manufacturer = request.getParameter("manufacturer");
	String model = request.getParameter("model");
	int year = 0;
	String color = request.getParameter("color");
	String wheelDriveType = request.getParameter("wheelDriveType");
	String transmissionType = request.getParameter("tranmissionType");
	
	try {
		vin = Integer.parseInt(request.getParameter("vin"));
		numberOfDoors = Integer.parseInt(request.getParameter("numberOfDoors"));
		numberOfSeats = Integer.parseInt(request.getParameter("numberOfSeats"));
		mileage = Integer.parseInt(request.getParameter("mileage"));
		milesPerGallon = Integer.parseInt(request.getParameter("milesPerGallon"));
		year = Integer.parseInt(request.getParameter("year"));
	} catch (NumberFormatException e) {
		out.println("Please fill in all vehicle fields");
		out.println("<a href='createAuctionPage.jsp'> Click here to try again </a>");
		return;
	}
	
	if (manufacturer.trim().equals("") || model.trim().equals("") || color.trim().equals("")) {
		out.println("Please fill in all vehicle fields");
		out.println("<a href='createAuctionPage.jsp'> Click here to try again </a>");
		return;
	}
	
	LocalDateTime startingDateTime = LocalDateTime.now();
	
	float initialPrice = 0;
	float minimumSellingPrice = 0;
	float bidIncrement = 0;
	
	try {
		initialPrice = Float.parseFloat(initialPriceString);
		minimumSellingPrice = Float.parseFloat(minimumSellingPriceString);
		bidIncrement = Float.parseFloat(bidIncrementString);
	} catch (NumberFormatException e) {
		out.println("Please fill in all vehicle fields");
		out.println("<a href='createAuctionPage.jsp'> Click here to try again </a>");
		return;
	}
	
	// VIN should be unique
	ResultSet vinCheck = statement.executeQuery("select * from vehicle where vin='" + vin + "'");
	
	if (vinCheck.next()) {
		out.println("VIN is already being used by another vehicle");
		out.println("<a href='createAuctionPage.jsp'> Click here to try again </a>");
		return;
	}
	String dateAndTime = endingDate + " " + endingTime;
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
	LocalDateTime endingDateTime = LocalDateTime.parse(dateAndTime, formatter);
	
	int auctionID = 1000;
	
	ResultSet amountOfAuctions = statement.executeQuery("select count(*) from auction");
	amountOfAuctions.next();
	int amount = amountOfAuctions.getInt(1);
	auctionID += amount;
	float currentPrice = initialPrice;
	float autoBidHighest = 0;
	String currentHighestBidder = "";
	String winner = "";
	
	statement.executeUpdate("insert into auction values('" + auctionID + "','" + creator + "','" + auctionName + "','" + 
			initialPrice + "','" + currentPrice + "','" + minimumSellingPrice + "','" + bidIncrement + "','" + vehicleType + "','" + 
			startingDateTime + "','" + endingDateTime + "','" + autoBidHighest + "','" + currentHighestBidder + "','" + winner + "')");
	statement.executeUpdate("insert into vehicle values('" + vin + "','" + numberOfDoors + "','" + 
			numberOfSeats + "','" + mileage + "','" + milesPerGallon + "','" + fuelType + "','" + newOrUsed + "','" + 
			manufacturer + "','" + model + "','" + year + "','" + color + "','" + wheelDriveType + "','" + transmissionType + "','" + auctionID + "')");
	out.println("Auction made!");
	out.println("<a href='userHomePage.jsp'> Click here to go to your home page </a>");
%>