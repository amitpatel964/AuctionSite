package javaClasses;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

// All helper functions are in this class

public class HelperFunctions {
	
	/**
	 * This function gets all of the auctions made in the SQL database and converts them into a list.
	 * This function is used when the user is searching for an auction to bid on.
	 * 
	 * @return	List of all auctions
	 * @throws SQLException
	 */
	public static List<Auction> getListOfAuctions() throws SQLException {
		List<Auction> auctions = new ArrayList<>();
		
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		ResultSet auctionsSet = statement.executeQuery("select * from auction");
		
		while(auctionsSet.next()) {
			int auctionID = auctionsSet.getInt("auctionID");
			String creator = auctionsSet.getString("creator");
			String auctionName = auctionsSet.getString("auctionName");
			float initialPrice = auctionsSet.getFloat("initialPrice");
			float currentPrice = auctionsSet.getFloat("currentPrice");
			float minimumSellingPrice = auctionsSet.getFloat("minimumSellingPrice");
			float bidIncrement = auctionsSet.getFloat("bidIncrement");
			String vehicleType = auctionsSet.getString("vehicleType");
			LocalDateTime startingDate = auctionsSet.getTimestamp("startingDate").toLocalDateTime();
			LocalDateTime endingDate = auctionsSet.getTimestamp("endingDate").toLocalDateTime();
			float autoBidHighest = auctionsSet.getFloat("autoBidHighest");
			String currentHighestBidder = auctionsSet.getString("currentHighestBidder");
			String winner = auctionsSet.getString("winner");
			String status = auctionsSet.getString("status");
			Auction auctionToAddToList = new Auction(auctionID, creator, auctionName, initialPrice, currentPrice, 
					minimumSellingPrice, bidIncrement, vehicleType, startingDate, endingDate, autoBidHighest,
					currentHighestBidder, winner, status);
			auctions.add(auctionToAddToList);
		}
		
		statement.close();
		con.close();
		
		return auctions;
	}
	
	/**
	 * Gets the auction that matches with the given auction ID
	 * 
	 * @param auctionID
	 * @return auction
	 * @throws SQLException
	 */
	public static Auction getAuction(int auctionID) throws SQLException {
		List<Auction> auctions = getListOfAuctions();
		Auction auction = null;
		
		for (int i = 0; i < auctions.size(); i++) {
			if (auctions.get(i).getAuctionID() == auctionID) {
				auction = auctions.get(i);
			}
		}
		
		return auction;
	}
	
	/**
	 * Given an auctionID, this function searches for the vehicle associated with the aucitonID in the database.
	 * 
	 * @param auctionID
	 * @return Vehicle associated with auctionID
	 * @throws SQLException
	 */
	public static Vehicle getVehicleFromAuctionID(int auctionID) throws SQLException {
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		ResultSet vehicles = statement.executeQuery("select * from vehicle where auctionID='" + auctionID + "'");
		
		vehicles.next();
		int vin = vehicles.getInt("vin");
		int numberOfDoors = vehicles.getInt("numberOfDoors");
		int numberOfSeats = vehicles.getInt("numberOfSeats");
		int mileage = vehicles.getInt("mileage");
		int milesPerGallon = vehicles.getInt("milesPerGallon");
		String fuelType = vehicles.getString("fuelType");
		String newOrUsed = vehicles.getString("newOrUsed");
		String manufacturer = vehicles.getString("manufacturer");
		String model = vehicles.getString("model");
		int year = vehicles.getInt("year");
		String color = vehicles.getString("color");
		String wheelDriveType = vehicles.getString("wheelDriveType");
		String transmissionType = vehicles.getString("transmissionType");
		
		Vehicle vehicle = new Vehicle(vin, numberOfDoors, numberOfSeats, mileage, milesPerGallon, 
				fuelType, newOrUsed, manufacturer, model, year, color, wheelDriveType, transmissionType, auctionID);
		return vehicle;
	}
	
	/**
	 * Gets any unseen alerts for the current user
	 * The alerts from this function is for when the user is outbid, the user wins an auction,
	 * or the user loses an auction.
	 * 
	 * @param currentUser	The user that is currently logged in
	 * @return	List of unseen alerts for the current user
	 * @throws SQLException
	 */
	public static List<Alert> getAlertsForBidOrWinner(String currentUser) throws SQLException {
		List<Alert> alertsForUser = new ArrayList<>();
		
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
	
		ResultSet alertsForUserSet = statement.executeQuery("select * from alertForBidOrWinner where username ='" + currentUser + "' and wasSeen = 'no'");
		
		while (alertsForUserSet.next()) {
			String alertType = alertsForUserSet.getString("alertType");
			int auctionID = alertsForUserSet.getInt("auctionID");
			String wasSeen = alertsForUserSet.getString("wasSeen");
			Alert alertToAdd = new Alert(alertType, currentUser, auctionID, wasSeen);
			alertsForUser.add(alertToAdd);
		}
		
		return alertsForUser;
	}
	
	/**
	 * This methods check to see if the current date/time is after any of the closing dates of all
	 * of the auctions. If it is, a winner is set if the current highest bid is higher than the minimum
	 * threshold if there is one and alerts are sent out.
	 * @throws SQLException 
	 * 
	 */
	public static void checkIfAnyAuctionHasEnded() throws SQLException {
		// TODO when bidding history is made for an auction, send out alerts to those that have lost
		
		List<Auction> auctions = getListOfAuctions();
		
		for (int i = 0; i < auctions.size(); i++) {
			Auction currentAuction = auctions.get(i);
			if (LocalDateTime.now().isAfter(currentAuction.getEndingDateTime()) && currentAuction.getStatus().equals("open")) {
				// Set status for auction to closed if the ending date/time has passed
				ApplicationDB db = new ApplicationDB();
				java.sql.Connection con = db.getConnection();
				java.sql.Statement statement = con.createStatement();
				statement.executeUpdate("update auction set status = 'closed' where auctionID='"+currentAuction.getAuctionID()+"'");
				
				// Check to see if there is a winner
				if (currentAuction.getCurrentPrice() > currentAuction.getMinimumSellingPrice()) {
					statement.executeUpdate("update auction set winner = '"+currentAuction.getCurrentHighestBidder()+"' where auctionID='"+currentAuction.getAuctionID()+"'");
					statement.executeUpdate("insert into alertForBidOrWinner values('auctionWinner','"+currentAuction.getCurrentHighestBidder()+"','"+currentAuction.getAuctionID()+"','no')");
				}
			}
		}
	}
}
