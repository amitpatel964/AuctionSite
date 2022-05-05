<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!-- This page is used to process a new alert for an item -->

<% 
	String vehicleType = "";
	String manufacturer = request.getParameter("manufacturer");
	String model = request.getParameter("model");
	String yearString = request.getParameter("year");
	int year = -1;
	String newOrUsed = "";
	String mileageString = request.getParameter("mileage");
	int mileage = -1;
	
	try {
		vehicleType = request.getParameter("vehicleType");
	} catch (NumberFormatException e) {
		vehicleType = "";
	}
	
	try {
		newOrUsed = request.getParameter("newOrUsed");
	} catch (NumberFormatException e) {
		newOrUsed = "";
	}
	
	try {
		yearString = request.getParameter("year");
		year = Integer.parseInt(yearString);
	} catch (NumberFormatException e) {
		yearString = "";
	}
	
	try {
		mileageString = request.getParameter("mileage");
		mileage = Integer.parseInt(mileageString);
	} catch (NumberFormatException e) {
		mileageString = "";
	}
	
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Statement statement = con.createStatement();
	String wasSeen = "no";
	
	int alertID = 0;
	
	ResultSet amountOfAlerts = statement.executeQuery("select count(*) from alertForNewItems");
	amountOfAlerts.next();
	int amount = amountOfAlerts.getInt(1);
	if (amount > 0) {
		ResultSet maxIDSearch = statement.executeQuery("select MAX(alertID) AS biggest from alertForNewItems");
		maxIDSearch.next();
		int maxID = maxIDSearch.getInt(1);
		alertID += amount;
	}
	
	int placeholder = 0;
	
	statement.executeUpdate("insert into alertForNewItems values('" + alertID + "','" + 
			session.getAttribute("user").toString() + "','" + placeholder + "','" + vehicleType + "','" + manufacturer 
			+ "','" + model + "','" + year + "','" + newOrUsed + "','" + mileage + "','" + wasSeen  + "')");
	
	statement.close();
	con.close();
	
	out.println("Alert made!");
	out.println("<a href='userHomePage.jsp'> Click here to go to your home page </a>");
%>