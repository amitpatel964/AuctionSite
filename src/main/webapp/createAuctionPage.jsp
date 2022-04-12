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
				Vehicle Type: <input type="text" name="vehicleType"/> <br/>
				Please format the date like this: MM/DD/YYYY
				Ending Date: <input type="text" name="endingDate"/> <br/>
				Please format the time like this: HH:MM:AM or HH:MM:PM
				Ending Time: <input type="text" name="endingTime"/> <br/>
				<input type="submit" value="Create Auction"/>
			</form>
		</div>
	</body>
</html>