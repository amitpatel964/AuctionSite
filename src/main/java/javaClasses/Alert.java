package javaClasses;

/**
 * This class will be used to build any alerts that a user may have.
 * If it was seen by the user already, then it is not shown again.
 * 
 * @author Amit
 *
 */

public class Alert {
	private String alertType;
	private String username;
	private int auctionID;
	private String wasSeen;
	
	/**
	 * This constructor is used when a user is outbid in an auction.
	 * It is also used to tell a user if they won or lost an auction.
	 * 
	 * @param alertType
	 * @param username
	 * @param auctionID
	 * @param wasSeen
	 */
	public Alert(String alertType, String username, int auctionID, String wasSeen) {
		this.alertType = alertType;
		this.username = username;
		this.auctionID = auctionID;
		this.wasSeen = wasSeen;
	}

	public String getAlertType() {
		return alertType;
	}

	public String getUsername() {
		return username;
	}

	public int getAuctionID() {
		return auctionID;
	}

	public String getWasSeen() {
		return wasSeen;
	}
}
