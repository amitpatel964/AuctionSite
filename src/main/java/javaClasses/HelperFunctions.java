package javaClasses;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.LinkedList;
import java.util.List;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

/**
 * This class contains all helper functions that are used throughout various files in the project.
 * All methods should be static in this class.
 * 
 * @author Amit, Michael
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
	 * This method is used to get the list of questions asked so far.
	 * 
	 * @return
	 * @throws SQLException
	 */
	public static List<Question> getListOfQuestions() throws SQLException {
		List<Question> questions = new ArrayList<>();
		
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		ResultSet questionsSet = statement.executeQuery("select * from questionAndAnswer");
		
		while(questionsSet.next()) {
			int questionID = questionsSet.getInt("questionID");
			String usernameAsker = questionsSet.getString("usernameAsker");
			String questionTitle = questionsSet.getString("questionTitle");
			String questionBodyContent = questionsSet.getString("questionBodyContent");
			String usernameResponder = questionsSet.getString("usernameResponder");
			String answerBodyContent = questionsSet.getString("answerBodyContent");
			int questionAnswered = questionsSet.getInt("questionAnswered");
			Question questionToAdd = new Question(questionID, usernameAsker, questionTitle, questionBodyContent,
					usernameResponder, answerBodyContent, questionAnswered);
			questions.add(questionToAdd);
		}
		
		statement.close();
		con.close();
		
		return questions;
	}
	
	/**
	 * This method gets the list of regular users
	 * 
	 * @return
	 * @throws SQLException
	 */
	public static List<User> getListOfUsers() throws SQLException {
		List<User> users = new ArrayList<>();
		
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		ResultSet usersSet = statement.executeQuery("select * from user where isCustRep = '0'");
		
		while(usersSet.next()) {
			String username = usersSet.getString("username");
			String email = usersSet.getString("email");
			String firstName = usersSet.getString("firstName");
			String lastName = usersSet.getString("lastName");
			String password = usersSet.getString("password");
			int isCustRep = usersSet.getInt("isCustRep");
			User userToAdd = new User(username, email, firstName, lastName, password, isCustRep);
			users.add(userToAdd);
		}
		
		statement.close();
		con.close();
		
		return users;
	}
	
	
	public static User getUser(String username) throws SQLException {
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		ResultSet userSearch = statement.executeQuery("select * from user where username = '"+username+"'");
		
		userSearch.next();
		
		String email = userSearch.getString("email");
		String firstName = userSearch.getString("firstName");
		String lastName = userSearch.getString("lastName");
		String password = userSearch.getString("password");
		int isCustRep = userSearch.getInt("isCustRep");
		User user = new User(username, email, firstName, lastName, password, isCustRep);
		
		statement.close();
		con.close();
		
		return user;
	}
	
	/**
	 * This method gets a question by question ID.
	 * 
	 * @param questionID
	 * @return
	 * @throws SQLException
	 */
	public static Question getQuestion(int questionID) throws SQLException {
		Question question = null;
		
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		ResultSet questionSearch = statement.executeQuery("select * from questionAndAnswer where questionID = '"+questionID+"'");
		
		questionSearch.next();
		
		String usernameAsker = questionSearch.getString("usernameAsker");
		String questionTitle = questionSearch.getString("questionTitle");
		String questionBodyContent = questionSearch.getString("questionBodyContent");
		String usernameResponder = questionSearch.getString("usernameResponder");
		String answerBodyContent = questionSearch.getString("answerBodyContent");
		int questionAnswered = questionSearch.getInt("questionAnswered");
		question = new Question(questionID, usernameAsker, questionTitle, questionBodyContent,
				usernameResponder, answerBodyContent, questionAnswered);
		
		statement.close();
		con.close();
		
		return question;
	}
	
	/**
	 * This method is used to get the auctions that are similar to an item and were made in the month before.
	 * 
	 * @param vehicleType
	 * @param manufacturer
	 * @param model
	 * @return
	 * @throws SQLException
	 */
	public static List<Auction> getSimilarItems(String vehicleType, String manufacturer, String model) throws SQLException {
		List<Auction> auctions = new ArrayList<>();
		
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		ResultSet auctionsSet = statement.executeQuery("select * from auction where vehicleType = '"+vehicleType+"'");
		
		LocalDate currentDate = LocalDate.now();
		LocalDate monthBeforeDate = currentDate.minusMonths(1).withDayOfMonth(1);
		LocalDate beginningOfCurrentMonth = currentDate.withDayOfMonth(1);
		
		while (auctionsSet.next()) {
			LocalDate startingDate = auctionsSet.getTimestamp("startingDate").toLocalDateTime().toLocalDate();
			
			if (!startingDate.isBefore(beginningOfCurrentMonth) || !startingDate.isAfter(monthBeforeDate)) {
				continue;
			}
			
			int auctionID = auctionsSet.getInt("auctionID");
			
			Vehicle vehicle = getVehicleFromAuctionID(auctionID);
			String manufacturerToCompare = vehicle.getManufacturer().toLowerCase();
			String modelToCompare = vehicle.getModel().toLowerCase();
			
			if (manufacturer.toLowerCase().equals(manufacturerToCompare) && 
					model.toLowerCase().equals(modelToCompare)) {
				auctions.add(getAuction(auctionID));
			}
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
		
		ResultSet test = statement.executeQuery("select count(*) from alertForBidOrWinner");
		test.next();
		System.out.println(test.getInt(1));
		
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
	 * This method is used to get any alerts for new items for a user if they were not seen yet
	 * 
	 * @param currentUser
	 * @return
	 * @throws SQLException
	 */
	public static List<Alert> getAlertsForNewItem(String currentUser) throws SQLException {
		List<Alert> alertsForUser = new ArrayList<>();
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		ResultSet alertsForUserSet = statement.executeQuery("select * from alertForNewItems where username ='" + currentUser + "' and auctionID != '0' and wasSeen = 'no'");
		
		while (alertsForUserSet.next()) {
			String alertType = "matchingItem";
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
	 * This method is used to check if the new auction made has parameters that match a user's
	 * alert for a certain item.
	 * 
	 * @param auctionID
	 * @param vehicleType
	 * @param manufacturer
	 * @param model
	 * @param year
	 * @param newOrUsed
	 * @param mileage
	 * @param username
	 * @throws SQLException
	 */
	public static void checkForMatchingItemAlert(int auctionID, String vehicleType, String manufacturer, String model,
			int year, String newOrUsed, int mileage, String username) throws SQLException {
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		ResultSet alertsForNewItem = statement.executeQuery("select * from alertForNewItems where auctionID ='0'");
		
		while (alertsForNewItem.next()) {
			int alertID = alertsForNewItem.getInt("alertID");
			String usernameSet = alertsForNewItem.getString("username");
			int auctionIDSet = alertsForNewItem.getInt("auctionID");
			String vehicleTypeSet = alertsForNewItem.getString("vehicleType");
			String manufacturerSet = alertsForNewItem.getString("manufacturer");
			String modelSet = alertsForNewItem.getString("model");
			int yearSet = alertsForNewItem.getInt("year");
			String newOrUsedSet = alertsForNewItem.getString("newOrUsed");
			int mileageSet = alertsForNewItem.getInt("mileage");
			
			if (auctionIDSet > 0 || username.equals(usernameSet)) {
				continue;
			}
			
			int amountToMatch = 0;
			if (!vehicleTypeSet.equals("")) {
				amountToMatch++;
			}
			if (!manufacturerSet.equals("")) {
				amountToMatch++;
			}
			if (!modelSet.equals("")) {
				amountToMatch++;
			}
			if (yearSet > -1) {
				amountToMatch++;
			}
			if (!newOrUsedSet.equals("")) {
				amountToMatch++;
			}
			if (mileageSet > -1) {
				amountToMatch++;
			}
			
			int amountMatched = 0;
			if (!vehicleTypeSet.equals("") && vehicleTypeSet.equals(vehicleType)) {
				amountMatched++;
			}
			if (!manufacturerSet.equals("") && manufacturerSet.equals(manufacturer)) {
				amountMatched++;
			}
			if (!modelSet.equals("") && modelSet.equals(model)) {
				amountMatched++;
			}
			if (yearSet > -1 && year == yearSet) {
				amountMatched++;
			}
			if (!newOrUsedSet.equals("") && newOrUsedSet.equals(newOrUsed)) {
				amountMatched++;
			}
			if (mileageSet > -1 && mileageSet == mileage) {
				amountMatched++;
			}
			
			if (amountToMatch == amountMatched) {
				statement.executeUpdate("update alertForNewItems set auctionID = '"+auctionID+"' where alertID='"+alertID+"'");
			}
		}
		
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
	 * @return List of BidHistory
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
	
	/**
	 * This method is used to get all of the bids a user has made
	 * 
	 * @param username
	 * @return List of BidHistory
	 * @throws SQLException
	 */
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
	 * This method is used to get all of the auctionIDs of the auctions a user has made
	 * 
	 * @param username
	 * @return List of Integers
	 * @throws SQLException
	 */
	public static List<Integer> getAuctionsMadeByUser(String username) throws SQLException {
		List<Integer> auctionsMade = new ArrayList<>();
		
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		ResultSet auctions = statement.executeQuery("select * from auction where creator ='" + username + "'");
		
		while(auctions.next()) {
			int auctionID = auctions.getInt("auctionID");
			auctionsMade.add(auctionID);
		}
		
		statement.close();
		con.close();
		
		return auctionsMade;
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
	 * Sorts the list of auctions alphabetically by vehicle manufacturer
	 * 
	 * @param allAuctions
	 * @return
	 * @throws SQLException
	 */
	public static List<Auction> sortAuctionsByManufacturer(List<Auction> allAuctions) throws SQLException {
		List<Auction> sortedList = new ArrayList<>();
		List<Vehicle> listOfVehicles = new ArrayList<>();
		
		for (Auction auction: allAuctions) {
			Vehicle vehicle = getVehicleFromAuctionID(auction.getAuctionID());
			listOfVehicles.add(vehicle);
		}
		
		sortedList.add(allAuctions.get(0));
		
		for (int i = 1; i < allAuctions.size(); i++) {
			Vehicle vehicle = listOfVehicles.get(i);
			for (int j = 0; j < i; j++) {
				Vehicle vehicleToCompareTo = getVehicleFromAuctionID(sortedList.get(j).getAuctionID());
				if (vehicle.getManufacturer().compareTo(vehicleToCompareTo.getManufacturer()) < 0) {
					if (j == 0) {
						sortedList.add(0,allAuctions.get(i));
					} else {
						sortedList.add(j,allAuctions.get(i));
					}
					break;
				}
				
				if (j == i - 1) {
					sortedList.add(allAuctions.get(i));
				}
			}
		}
		
		return sortedList;
	}
	
	/**
	 * Sorts the list of auctions alphabetically by vehicle type
	 * 
	 * @param allAuctions
	 * @return
	 * @throws SQLException
	 */
	public static List<Auction> sortAuctionsByVehicleType(List<Auction> allAuctions) throws SQLException {
		List<Auction> sortedList = new ArrayList<>();
		
		sortedList.add(allAuctions.get(0));
		
		for (int i = 1; i < allAuctions.size(); i++) {
			for (int j = 0; j < i; j++) {
				if (allAuctions.get(i).getVehicleType().compareTo(sortedList.get(j).getVehicleType()) < 0) {
					if (j == 0) {
						sortedList.add(0,allAuctions.get(i));
					} else {
						sortedList.add(j,allAuctions.get(i));
					}
					break;
				}
				
				if (j == i - 1) {
					sortedList.add(allAuctions.get(i));
				}
			}
		}
		
		return sortedList;
	}
	
	/**
	 * Sorts the list of auctions by miles per gallon descending
	 * 
	 * @param allAuctions
	 * @return
	 * @throws SQLException
	 */
	public static List<Auction> sortAuctionsByMilesPerGallon(List<Auction> allAuctions) throws SQLException {
		List<Auction> sortedList = new ArrayList<>();
		List<Vehicle> listOfVehicles = new ArrayList<>();
		
		for (Auction auction: allAuctions) {
			Vehicle vehicle = getVehicleFromAuctionID(auction.getAuctionID());
			listOfVehicles.add(vehicle);
		}
		
		sortedList.add(allAuctions.get(0));
		
		for (int i = 1; i < allAuctions.size(); i++) {
			Vehicle vehicle = listOfVehicles.get(i);
			for (int j = 0; j < i; j++) {
				Vehicle vehicleToCompareTo = getVehicleFromAuctionID(sortedList.get(j).getAuctionID());
				if (vehicle.getMilesPerGallon() > vehicleToCompareTo.getMilesPerGallon()) {
					if (j == 0) {
						sortedList.add(0,allAuctions.get(i));
					} else {
						sortedList.add(j,allAuctions.get(i));
					}
					break;
				}
				
				if (j == i - 1) {
					sortedList.add(allAuctions.get(i));
				}
			}
		}
		
		return sortedList;
	}
	
	/**
	 * Sorts the list of auctions by mileage by ascending
	 * 
	 * @param allAuctions
	 * @return
	 * @throws SQLException
	 */
	public static List<Auction> sortAuctionsByMileage(List<Auction> allAuctions) throws SQLException {
		List<Auction> sortedList = new ArrayList<>();
		List<Vehicle> listOfVehicles = new ArrayList<>();
		
		for (Auction auction: allAuctions) {
			Vehicle vehicle = getVehicleFromAuctionID(auction.getAuctionID());
			listOfVehicles.add(vehicle);
		}
		
		sortedList.add(allAuctions.get(0));
		
		for (int i = 1; i < allAuctions.size(); i++) {
			Vehicle vehicle = listOfVehicles.get(i);
			for (int j = 0; j < i; j++) {
				Vehicle vehicleToCompareTo = getVehicleFromAuctionID(sortedList.get(j).getAuctionID());
				if (vehicle.getMileage() < vehicleToCompareTo.getMileage()) {
					if (j == 0) {
						sortedList.add(0,allAuctions.get(i));
					} else {
						sortedList.add(j,allAuctions.get(i));
					}
					break;
				}
				
				if (j == i - 1) {
					sortedList.add(allAuctions.get(i));
				}
			}
		}
		
		return sortedList;
	}
	
	/**
	 * Sort the list of auctions by current price ascending
	 * 
	 * @param allAuctions
	 * @return
	 * @throws SQLException
	 */
	public static List<Auction> sortAuctionsByCurrentPrice(List<Auction> allAuctions) throws SQLException {
		List<Auction> sortedList = new ArrayList<>();
		
		sortedList.add(allAuctions.get(0));
		
		for (int i = 1; i < allAuctions.size(); i++) {
			for (int j = 0; j < i; j++) {
				if (allAuctions.get(i).getCurrentPrice() < sortedList.get(j).getCurrentPrice()) {
					if (j == 0) {
						sortedList.add(0,allAuctions.get(i));
					} else {
						sortedList.add(j,allAuctions.get(i));
					}
					break;
				}
				
				if (j == i - 1) {
					sortedList.add(allAuctions.get(i));
				}
			}
		}
		
		return sortedList;
	}
	
	/**
	 * Admin creates Customer Representatives
	 * 
	 * @param id, first, last, pw, mail, cr, ad
	 * @throws SQLException 
	 * 
	 */
	public static void createCustomReps(String id, String first, String last, String pw, String mail, boolean cr, boolean ad) throws SQLException {
		
//		User custRep = new User(i, first, last, pw, mail, true, false);
		
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		statement.executeUpdate("insert into user values('" + id + "','" + mail + "','" + first + "','" + last + "','" + pw + "','1')");
		
		statement.close();
		con.close();
		
//		return custRep;
	}
	
	/**
	 * Generate a sales report based on total earnings, earnings per vehicle, earnings per vehicle type, earnings per end-user, best selling items, and best buyers
	 * 
	 * @param auctions
	 * @throws SQLException
	 */
	public static List<SalesReport> salesReport(List<Auction> auctions) throws SQLException {
		
		ApplicationDB db = new ApplicationDB();
		java.sql.Connection con = db.getConnection();
		
		java.sql.Statement statement = con.createStatement();
		
		List<Vehicle> vehicles = new ArrayList<>();
		for(int i = 0; i < auctions.size(); i++) {
			vehicles.add(getVehicleFromAuctionID(auctions.get(i).getAuctionID()));
		}
		List<SalesReport> report = new ArrayList<>();
		//Total Earnings
		ResultSet totalEarnings = statement.executeQuery("select sum(currentPrice) as s from auction where endingDate < now() and winner != ''");
		while(totalEarnings.next()) {
			SalesReport sr = new SalesReport(0, 0, 0, "", "", "");
			sr.setSum(totalEarnings.getFloat("s"));
			report.add(sr);
		}
		
		//Earnings Per Vehicle
		ResultSet earningsPerVehicle = statement.executeQuery("select v.vin as vin, sum(a.currentPrice) as s from auction a, vehicle v where a.status = 'closed' and winner != '' and a.auctionID = v.auctionID group by v.vin");
		while(earningsPerVehicle.next()) {
			SalesReport sr = new SalesReport(0, 0, 0, "", "", "");
			sr.setVin(earningsPerVehicle.getInt("vin"));
			sr.setSum(earningsPerVehicle.getFloat("s"));
			report.add(sr);
		}
		
		//Earnings Per Vehicle Type
		ResultSet earningsPerType = statement.executeQuery("select vehicleType, sum(currentPrice) as s from auction where status = 'closed' and winner != '' group by vehicleType");
		while(earningsPerType.next()) {
			SalesReport sr = new SalesReport(0, 0, 0, "", "", "");
			sr.setVehicleType(earningsPerType.getString("vehicleType"));
			sr.setSum(earningsPerType.getFloat("s"));
			report.add(sr);
		}
		
		//Earnings Per User
		ResultSet earningsPerUser = statement.executeQuery("select creator, sum(currentPrice) as s from auction where status = 'closed' and winner != '' group by creator");
		while(earningsPerUser.next()) {
			SalesReport sr = new SalesReport(0, 0, 0, "", "", "");
			sr.setUsername(earningsPerUser.getString("creator"));
			sr.setSum(earningsPerUser.getFloat("s"));
			report.add(sr);
		}
		
		//Best Selling Vehicles
		ResultSet bestItems = statement.executeQuery("select vehicleType, count(vehicleType) as c from auction where status = 'closed' and winner != '' group by vehicleType order by count(vehicleType) desc");
		while(bestItems.next()) {
			SalesReport sr = new SalesReport(0, 0, 0, "", "", "");
			sr.setVehicleType(bestItems.getString("vehicleType"));
			sr.setCount(bestItems.getInt("c"));
			report.add(sr);
		}

		//Best Buyers
		ResultSet bestBuyers = statement.executeQuery("select winner, sum(currentPrice) as s from auction where status = 'closed' and winner != '' group by winner order by sum(currentPrice) desc");
		while(bestBuyers.next()) {
			SalesReport sr = new SalesReport(0, 0, 0, "", "", "");
			sr.setUsername(bestBuyers.getString("winner"));
			sr.setSum(bestBuyers.getFloat("s"));
			report.add(sr);
		}
		
		statement.close();
		con.close();
		
		return report;
	}
}
