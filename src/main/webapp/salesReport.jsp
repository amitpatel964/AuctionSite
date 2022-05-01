<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>

<!-- This page is where the admin can see the sales report. -->

<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales Report</title>
</head>
	<%	Float totalEarnings = (Float)request.getAttribute("totalEarnings");
		Float earningsPerVehicle[] = (Float[])request.getAttribute("earningsPerVehicle");
		Float earningsPerType[] = (Float[])request.getAttribute("earningsPerType");
		Float earningsPerUser[] = (Float[])request.getAttribute("earningsPerUser");
		List<Vehicle> bestVehicles = (List<Vehicle>)request.getAttribute("bestItems");
		List<User> bestBuyers = (List<User>)request.getAttribute("bestBuyers");
		List<User> users = (List<User>)request.getAttribute("id");
		String vehicleType[] = new String[] {"Car", "Motorcycle", "SUV", "Truck", "Van"};
	%>
<body>
	<h2>Sales Report</h2>
		<div>
			<h3>Total Earnings:<h3>
			<%=totalEarnings%>
			<h3>Earnings Per Vehicle</h3>
			<% for (int i = 0; i < earningsPerVehicle.length; i++){%>
			<%= %> Earnings: <%=earningsPerVehicle[i]%><br/>
			<%}%>
			<h3>Earnings Per Vehicle Type</h3>
			<% for (int i = 0; i < earningsPerType.length; i++){%>
			<%=vehicleType[i] %> Earnings: <%=earningsPerType[i]%><br/>
			<%}%>
			<h3>Earnings Per User</h3>
			<% for (int i = 0; i < earningsPerUser.length; i++){%>
			User: <%=users.get(i).getId()%><br/> Earnings: <%=earningsPerUser[i]%><br/>
			<%}%>
			<h3>Best Vehicles</h3>
			<% for (int i = 0; i < bestVehicles.size(); i++){%>
			Vehicle: <%=bestVehicles.get(i).getVin()%><br/>
			<%}%>
			<h3>Best Buyers</h3>
			<% for (int i = 0; i < bestBuyers.size(); i++){%>
			User: <%=bestBuyers.get(i).getId()%><br/>
			<%}%>
		</div>
</body>
</html>