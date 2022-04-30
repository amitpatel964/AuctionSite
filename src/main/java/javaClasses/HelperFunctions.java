package javaClasses;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

/**
 * This class contains all helper functions that are used throughout various files in the project.
 * All methods should be static in this class.
 * 
 * @author Amit
 *
 */

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
		String transmissionType = vehicles.getString("transmissionType");
		
		Vehicle vehicle = new Vehicle(vin, numberOfDoors, numberOfSeats, mileage, milesPerGallon, 
				fuelType, newOrUsed, manufacturer, model, year, color, transmissionType, auctionID);
		
		statement.close();
		con.close();
		
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
		
		statement.close();
		con.close();
		
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
		List<Auction> auctions = new ArrayList<>();
		auctions = getListOfAuctions();
		
		for (int i = 0; i < auctions.size(); i++) {
			Auction currentAuction = auctions.get(i);
			if (LocalDateTime.now().isAfter(currentAuction.getEndingDateTime()) && currentAuction.getStatus().equals("open")) {
				// Set status for auction to closed if the ending date/time has passed
				ApplicationDB db = new ApplicationDB();
				java.sql.Connection con = db.getConnection();
				java.sql.Statement statement = con.createStatement();
				statement.executeUpdate("update auction set status = 'closed' where auctionID='"+currentAuction.getAuctionID()+"'");
				
				String winner = "";
				
				// Check to see if there is a winner
				if (currentAuction.getCurrentPrice() > currentAuction.getMinimumSellingPrice() && !currentAuction.getCurrentHighestBidder().equals("")) {
					winner = currentAuction.getCurrentHighestBidder();
					statement.executeUpdate("update auction set winner = '"+currentAuction.getCurrentHighestBidder()+"' where auctionID='"+currentAuction.getAuctionID()+"'");
					statement.executeUpdate("insert into alertForBidOrWinner values('auctionWinner','"+currentAuction.getCurrentHighestBidder()+"','"+currentAuction.getAuctionID()+"','no')");
				}
				
				// Send out an alert to the other bidders that they lost the auction
				List<String> bidders = new ArrayList<>();
				bidders = getListOfBiddersForAuction(currentAuction.getAuctionID());
				
				for (int j = 0; j < bidders.size(); j++) {
					String currentBidder = bidders.get(j);
					if (!currentBidder.equals(winner)) {
						statement.executeUpdate("insert into alertForBidOrWinner values('auctionLost','"+currentBidder+"','"+currentAuction.getAuctionID()+"','no')");
					}
				}
				
			}
		}
	}
	
	/**
	 * This method is used to help build the bid history for a certain auction given an auctionID.
	 * 
	 * @param auctionID
	 * @return
	 * @throws SQLException
	 */
	public static List<BidHistory> getBidHistoryForAuction(int auctionID) throws SQLException {
		List<BidHistory> history = new ArrayList<>();
		
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
	
		ResultSet bids = statement.executeQuery("select * from auctionBidHistory where auctionID ='" + auctionID + "'");
		
		while(bids.next()) {
			String username = bids.getString("username");
			float bidAmount = bids.getFloat("bidAmount");
			LocalDateTime bidDateTime = bids.getTimestamp("bidDateTime").toLocalDateTime();
			BidHistory toAddToList = new BidHistory(auctionID,username,bidAmount,bidDateTime);
			history.add(toAddToList);
		}
		
		statement.close();
		con.close();
		
		return history;
	}
	
	public static List<BidHistory> getBidHistoryForUser(String username) throws SQLException {
		List<BidHistory> history = new ArrayList<>();
		
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		ResultSet bids = statement.executeQuery("select * from auctionBidHistory where username ='" + username + "'");
		
		while(bids.next()) {
			int auctionID = bids.getInt("auctionID");
			float bidAmount = bids.getFloat("bidAmount");
			LocalDateTime bidDateTime = bids.getTimestamp("bidDateTime").toLocalDateTime();
			BidHistory toAddToList = new BidHistory(auctionID,username,bidAmount,bidDateTime);
			history.add(toAddToList);
		}
		
		statement.close();
		con.close();
		
		return history;
	}
	
	/**
	 * This method will return the list of unique bidders for an auction given an auctionID
	 * 
	 * @param auctionID
	 * @return	A list of usernames as strings
	 * @throws SQLException
	 */
	public static List<String> getListOfBiddersForAuction(int auctionID) throws SQLException {
		List<String> bidders = new ArrayList<>();
		
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		ResultSet users = statement.executeQuery("select distinct(username) from auctionBidHistory where auctionID ='" + auctionID + "'");
		
		while(users.next()) {
			bidders.add(users.getString("username"));
		}
		
		statement.close();
		con.close();
		
		return bidders;
	}
	
	/**
	 * Gets car specific details from a vin if that vehicle is a car
	 * 
	 * @param vin
	 * @return Car details as a Car class
	 * @throws SQLException
	 */
	public static Car getCarFromVin(int vin) throws SQLException {
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		ResultSet carResult = statement.executeQuery("select * from car where vin ='" + vin + "'");
		carResult.next();
		String typeOfCar = carResult.getString("typeOfCar");
		String isConvertible = carResult.getString("isConvertible");
		
		Car car = new Car(typeOfCar, isConvertible, vin);
		
		statement.close();
		con.close();
		
		return car;
	}
	
	/**
	 * Gets suv specific details from a vin if that vehicle is an suv
	 * 
	 * @param vin
	 * @return Suv details as an Suv class
	 * @throws SQLException
	 */
	public static Suv getSuvFromVin(int vin) throws SQLException {
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		ResultSet suvResult = statement.executeQuery("select * from suv where vin ='" + vin + "'");
		suvResult.next();
		String seatsExpandable = suvResult.getString("seatsExpandable");
		
		Suv suv = new Suv(seatsExpandable, vin);
		
		statement.close();
		con.close();
		
		return suv;
	}
	
	/**
	 * Gets van specific details from a vin if that vehicle is a van
	 * 
	 * @param vin
	 * @return Van details as an Van class
	 * @throws SQLException
	 */
	public static Van getVanFromVin(int vin) throws SQLException {
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		ResultSet vanResult = statement.executeQuery("select * from van where vin ='" + vin + "'");
		vanResult.next();
		String vanMiniOrFull = vanResult.getString("vanMiniOrFull");
		
		Van van = new Van(vanMiniOrFull, vin);
		
		statement.close();
		con.close();
		
		return van;
	}
	
	/**
	 * Gets truck specific details from a vin if that vehicle is a truck
	 * 
	 * @param vin
	 * @return Truck details as a Truck class
	 * @throws SQLException
	 */
	public static Truck getTruckFromVin(int vin) throws SQLException {
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		ResultSet truckResult = statement.executeQuery("select * from truck where vin ='" + vin + "'");
		truckResult.next();
		String isPickUpTruck = truckResult.getString("isPickUpTruck");
		int numberOfWheels = truckResult.getInt("numberOfWheels");
		
		Truck truck = new Truck(isPickUpTruck, numberOfWheels, vin);
		
		statement.close();
		con.close();
		
		return truck;
	}
	
	/**
	 * Gets motorcycle specific details from a vin if that vehicle is a motorcycle
	 * 
	 * @param vin
	 * @return Motorcycle details as a Motorcycle class
	 * @throws SQLException
	 */
	public static Motorcycle getMotorcycleFromVin(int vin) throws SQLException {
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		ResultSet carResult = statement.executeQuery("select * from motorcycle where vin ='" + vin + "'");
		carResult.next();
		String hasStorage = carResult.getString("hasStorage");
		String typeOfMotorCycle = carResult.getString("typeOfMotorCycle");
		
		Motorcycle motorcycle = new Motorcycle(hasStorage, typeOfMotorCycle, vin);
		
		statement.close();
		con.close();
		
		return motorcycle;
	}
	
	/**
	 * Generate a sales report based on total earnings, earnings per vehicle, earnings per vehicle type, earnings per end-user, best selling items, and best buyers
	 * 
	 * @param auctionSet
	 * @throws SQLException
	 */
	public static void salesReport(List<Auction> auctions) throws SQLException {
		
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		//Total Earnings
		ResultSet totalEarnings = statement.executeQuery("select sum(currentPrice) from auctions where endingDate < now() and winner is not null");
		
		while(totalEarnings.next()) {
			float sum = totalEarnings.getFloat("sum(currentPrice)");
			System.out.println("Total Earnings: $" + sum);	
		}
		
		//Earnings Per Vehicle
		ResultSet earningsPerVehicle = statement.executeQuery("select v.vin, a.sum(currentPrice) from auction a, vehicle v where a.endingDate < now() and a.winner is not null group and a.auctionID = v.auctionID by v.auctionID");
		
		while(earningsPerVehicle.next()) {
			int id = earningsPerVehicle.getInt("v.auctionID");
			float sum = earningsPerVehicle.getFloat("a.sum(currentPrice");
			System.out.println("Vehicle ID: " + id + "/t Earnings: $" + sum);
		}
		
		//Earnings Per Vehicle Type
		ResultSet earningsPerType = statement.executeQuery("select vehicleType, sum(currentPrice) from auctions where endingDate < now() and winner is not null group by vehicleType");
		
		while(earningsPerType.next()) {
			String type = earningsPerType.getString("vehicleType");
			float sum = earningsPerType.getFloat("sum(currentPrice)");
			System.out.println("Vehicle Type: " + type + "/t Earnings: $" + sum);
		}
		
		//Earnings Per User
		ResultSet earningsPerUser = statement.executeQuery("select creator, sum(currentPrice) from auctions where endingDate < now() and winner is not null group by creator");
		
		while(earningsPerUser.next()) {
			String user = earningsPerUser.getString("creator");
			float sum = earningsPerUser.getFloat("sum(currentPrice)");
			System.out.println("User: " + user + "/t Earnings: $" + sum);
		}
		
		//Best Selling Vehicles
		ResultSet bestItems = statement.executeQuery("select vehicleType, count(vehicleTypes) from auctions where endingDate < now() and winner is not null group by vehicleType order by count(vehicleTypes) desc");
	
		while(bestItems.next()) {
			String type = bestItems.getString("vehicleType");
			int count = bestItems.getInt("count(vehicleType");
			System.out.println("Vehicle Type: " + type + "/t Amount sold: " + count);
		}
		
		//Best Buyers
		ResultSet bestBuyers = statement.executeQuery("select winner, sum(currentPrice) from auctions group by winner order by sum(currentPrice) desc");
		
		while(bestBuyers.next()) {
			String win = bestBuyers.getString("winner");
			float sum = bestBuyers.getFloat("sum(currentPrice)");
			System.out.println("User: " + win + "/t Total Spent: $" + sum);	
		}
		
		statement.close();
		con.close();
	}
}
