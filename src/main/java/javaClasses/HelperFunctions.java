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
			Auction auctionToAddToList = new Auction(auctionID, creator, auctionName, initialPrice, currentPrice, 
					minimumSellingPrice, bidIncrement, vehicleType, startingDate, endingDate);
			auctions.add(auctionToAddToList);
		}
		
		statement.close();
		con.close();
		
		return auctions;
	}
}
