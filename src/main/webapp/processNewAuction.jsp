<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!-- Thie file handles processing a new auction for the user.
	 If all of the information was filled in properly, the auction is created.
	 Otherwise, the user is directed back to fill in the relevant information. -->

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
	String transmissionType = request.getParameter("tranmissionType");
	
	// Make sure fields are filled in properly
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
	DateTimeFormatter formatter;
	LocalDateTime endingDateTime;
				
	try {
		formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		endingDateTime = LocalDateTime.parse(dateAndTime, formatter);
	} catch(NumberFormatException e) {
		out.println("Please type in the ending date and time correctly");
		out.println("<a href='createAuctionPage.jsp'> Click here to try again </a>");
		return;
	}
	
	int auctionID = 1000;
	
	ResultSet amountOfAuctions = statement.executeQuery("select count(*) from auction");
	amountOfAuctions.next();
	int amount = amountOfAuctions.getInt(1);
	if (amount > 0) {
		ResultSet maxIDSearch = statement.executeQuery("select MAX(auctionID) AS biggest from auction");
		maxIDSearch.next();
		int maxID = maxIDSearch.getInt(1);
		auctionID += amount;
	}
	
	// Placeholder values. These columns will be filled in as people put in bids.
	float currentPrice = initialPrice;
	float autoBidHighest = 0;
	String currentHighestBidder = "";
	String winner = "";
	String status = "open";
	
	// Check to see number of wheels is filled in properly if vehicle is a truck
	if (vehicleType.equals("Truck")) {
		try {
			int numberOfWheels = Integer.parseInt(request.getParameter("numberOfWheels"));
		} catch (NumberFormatException e) {
			out.println("Please fill in the text box for the number of wheels under truck details");
			out.println("<a href='createAuctionPage.jsp'> Click here to try again </a>");
			return;
		}
	}
	
	statement.executeUpdate("insert into auction values('" + auctionID + "','" + creator + "','" + auctionName + "','" + 
			initialPrice + "','" + currentPrice + "','" + minimumSellingPrice + "','" + bidIncrement + "','" + vehicleType + "','" + 
			startingDateTime + "','" + endingDateTime + "','" + autoBidHighest + "','" + currentHighestBidder + "','" + winner + "','" + status + "')");
	statement.executeUpdate("insert into vehicle values('" + vin + "','" + numberOfDoors + "','" + 
			numberOfSeats + "','" + mileage + "','" + milesPerGallon + "','" + fuelType + "','" + newOrUsed + "','" + 
			manufacturer + "','" + model + "','" + year + "','" + color + "','" + transmissionType + "','" + auctionID + "')");
	
	// Fill in details for vehicle type
	if (vehicleType.equals("Car")) {
		String typeOfCar = request.getParameter("typeOfCar");
		String isConvertible = request.getParameter("isConvertible");
		statement.executeUpdate("insert into car values('" + typeOfCar + "','" + isConvertible + "','" + vin + "')");
	} else if (vehicleType.equals("Suv")) {
		String seatsExpandable = request.getParameter("seatsExpandable");
		statement.executeUpdate("insert into suv values('" + seatsExpandable + "','" + vin + "')");
	} else if (vehicleType.equals("Van")) {
		String vanMiniOrFull = request.getParameter("vanMiniOrFull");
		statement.executeUpdate("insert into van values('" + vanMiniOrFull + "','" + vin + "')");
	} else if (vehicleType.equals("Truck")) {
		String isPickUpTruck = request.getParameter("isPickUpTruck");
		int numberOfWheels = Integer.parseInt(request.getParameter("numberOfWheels"));
		statement.executeUpdate("insert into truck values('" + isPickUpTruck + "','" + numberOfWheels + "','" + vin + "')");
	} else {
		String hasStorage = request.getParameter("hasStorage");
		String typeOfMotorCycle = request.getParameter("typeOfMotorCycle");
		statement.executeUpdate("insert into motorcycle values('" + hasStorage + "','" + typeOfMotorCycle + "','" + vin + "')");
	}
	
	// Check if this item matches any item alerts
	HelperFunctions.checkForMatchingItemAlert(auctionID, vehicleType, manufacturer, model, year, newOrUsed, mileage, session.getAttribute("user").toString());
	
	out.println("Auction made!");
	out.println("<a href='userHomePage.jsp'> Click here to go to your home page </a>");
%>