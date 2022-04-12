<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<!-- This file is used to show the home page for the user.
From here, the user is able to create an auction, search of an auction, and view their previous auctions. -->

<html>
	<head>
	<meta charset="ISO-8859-1">
		<title>Home Page</title>
	</head>
	
	<body>
		<%=session.getAttribute("user")%>'s Home Page
		<a href='logout.jsp'>Log out</a>
		
		<br>
		Work in progress. <br>
		The home page should allow the user to search for auctions and see what auctions they bidded on. <br>
		Auctions created by the user and the ability for the user to create an auction should also be added. <br>
		It should also have a history of bids and items they sold.
		
		<form action="createAuctionPage.jsp" method="POST">
			<p>
				Click the button below to create a new auction.
			</p>
			<input type="submit" value="Create New Auction"/>
		</form>
	</body>
</html>