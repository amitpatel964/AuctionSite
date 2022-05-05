<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<!-- This page is used to allow the user to create an alert for an item they are looking for -->

<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Create Alert</title>
	</head>
	<body>
		<div>
			<a href='userHomePage.jsp'>Home Page</a>
			<a href='logout.jsp'>Log out</a>
		</div>
		<br/>
		<div>
			<form action="processNewAlertForItem.jsp" method="POST">
				Vehicle Type: 
				<input type="radio" name="vehicleType" value="Car"/>Car
				<input type="radio" name="vehicleType" value="Suv"/>Suv
				<input type="radio" name="vehicleType" value="Van"/>Van
				<input type="radio" name="vehicleType" value="Truck"/>Truck
				<input type="radio" name="vehicleType" value="Motorcycle"/>Motorcycle
				<br/>
				Manufacturer: <input type="text" name="manufacturer"/> <br/>
				Model: <input type="text" name="model"/> <br/>
				Year: <input type="text" name="year"/> <br/>
				New or Used:
				<input type="radio" name="newOrUsed" value="New"/>New
				<input type="radio" name="newOrUsed" value="Used"/>Used
				<br/>
				Mileage: <input type="text" name="mileage"/> <br/>
				<input type="submit" value="Create Alert"/>
			</form>
		</div>
	</body>
</html>