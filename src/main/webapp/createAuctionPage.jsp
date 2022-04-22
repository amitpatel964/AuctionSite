<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<!-- This page will allow the user to create a new auction based on the information that they enter. -->

<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Create Auction Page</title>
	</head>
	
	<body>
		<div>
			<a href='userHomePage.jsp'>Home Page</a>
			<a href='logout.jsp'>Log out</a>
		</div>
		<div>
			Please enter the following information to create an auction.
		</div>
		<div>
			<form action="processNewAuction.jsp" method="POST">
				Auction Name: <input type="text" name="auctionName"/> <br/>
				Starting Price: <input type="text" name="initialPrice"/> <br/>
				Minimum Selling Price: <input type="text" name="minimumSellingPrice"/> <br/>
				Bid Increment: <input type="text" name="bidIncrement"/> <br/>
				Vehicle Type: 
				<input type="radio" name="vehicleType" value="Car" checked="checked"/>Car
				<input type="radio" name="vehicleType" value="Suv"/>Suv
				<input type="radio" name="vehicleType" value="Van"/>Van
				<input type="radio" name="vehicleType" value="Truck"/>Truck
				<input type="radio" name="vehicleType" value="Motorcycle"/>Motorcycle
				<br/>
				Please format the date like this: YYYY-MM-DD
				Ending Date: <input type="text" name="endingDate"/> <br/>
				Please format the time like this: HH:MM (12 AM should be put in as 00, 1 PM and after should have 12 added
				to the number)
				Ending Time: <input type="text" name="endingTime"/> <br/>
				<br/>
				
				<!-- Enter information for the vehicle -->
				Vehicle details <br/>
				VIN (Vehicle Identification Number): <input type="text" name="vin"/> <br/>
				Number of doors: <input type="text" name="numberOfDoors"/> <br/>
				Number of seats: <input type="text" name="numberOfSeats"/> <br/>
				Mileage: <input type="text" name="mileage"/> <br/>
				Miles Per Gallons: <input type="text" name="milesPerGallon"/> <br/>
				Fuel Type:
				<input type="radio" name=fuelType value="Gasoline" checked="checked"/>Gasoline
				<input type="radio" name="fuelType" value="Electric"/>Electric
				<input type="radio" name=fuelType value="Hybrid"/>Hybrid
				<br/>
				New or Used:
				<input type="radio" name="newOrUsed" value="New"/>New
				<input type="radio" name="newOrUsed" value="Used" checked="checked"/>Used
				<br/>
				Manufacturer: <input type="text" name="manufacturer"/> <br/>
				Model: <input type="text" name="model"/> <br/>
				Year: <input type="text" name="year"/> <br/>
				Color: <input type="text" name="color"/> <br/>
				Transmission Type:
				<input type="radio" name=tranmissionType value="Automatic" checked="checked"/>Automatic
				<input type="radio" name=tranmissionType value="Manual"/>Manual
				<br/>
				<br/>
				<!-- Additional details for cars -->
				Car Details: <br/>
				Type of Car: <input type="radio" name="typeOfCar" value="Sedan" checked="checked"/>Sedan
				<input type="radio" name="typeOfCar" value="Coupe"/>Coupe
				<input type="radio" name="typeOfCar" value="Hatchback"/>Hatchback
				<input type="radio" name="typeOfCar" value="Station Wagon"/>Station Wagon
				<input type="radio" name="typeOfCar" value="Sports"/>Sports
				<input type="radio" name="typeOfCar" value="Other"/>Other <br/>
				Is your car a convertible? <input type="radio" name="isConvertible" value="Yes"/>Yes
				<input type="radio" name="isConvertible" value="No" checked="checked"/>No
				<br/>
				<br/>
				<!-- Additional details for suvs -->
				SUV Details: <br/>
				Can you add more seats to your SUV? <input type="radio" name="seatsExpandable" value="Yes"/>Yes
				<input type="radio" name="seatsExpandable" value="No" checked="checked"/>No
				<br/>
				<br/>
				<!-- Additional details for vans -->
				Van Details: <br/>
				Is your van a minivan or a full van? <input type="radio" name="vanMiniOrFull" value="Mini" checked="checked"/>Mini
				<input type="radio" name="vanMiniOrFull" value="Full"/>Full
				<br/>
				<br/>
				<!-- Additional details for trucks -->
				Truck Details: <br/>
				Is your a pickup truck? <input type="radio" name="isPickUpTruck" value="Yes"/>Yes
				<input type="radio" name="isPickUpTruck" value="No" checked="checked"/>No <br/>
				Number of Wheels: <input type="text" name="numberOfWheels"/> 
				<br/>
				<br/>
				<!-- Additional details for Motorcycles -->
				Motorcycle Details: <br/>
				Has storage? <input type="radio" name="hasStorage" value="Yes"/>Yes
				<input type="radio" name="hasStorage" value="No" checked="checked"/>No <br/>
				Type of Motorcycle: <input type="radio" name="typeOfMotorCycle" value="Standard"/>Standard
				<input type="radio" name="typeOfMotorCycle" value="Cruiser"/>Cruiser
				<input type="radio" name="typeOfMotorCycle" value="Sport"/>Sport
				<input type="radio" name="typeOfMotorCycle" value="Other"/>Other <br/>
				<br/>
				<br/>
				<input type="submit" value="Create Auction"/>
			</form>
		</div>
	</body>
</html>