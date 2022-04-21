package javaClasses;

import java.time.LocalDateTime;

/**
 * This class is used to organize information for the bid history of an auction.
 * 
 * @author Amit
 *
 */

public class BidHistory {
	private int auctionID;
	private String username;
	private float bidAmount;
	private LocalDateTime bidDateTime;
	
	public BidHistory(int auctionID, String username, float bidAmount, LocalDateTime bidDateTime) {
		this.auctionID = auctionID;
		this.username = username;
		this.bidAmount = bidAmount;
		this.bidDateTime = bidDateTime;
	}

	public int getAuctionID() {
		return auctionID;
	}

	public String getUsername() {
		return username;
	}

	public float getBidAmount() {
		return bidAmount;
	}

	public LocalDateTime getBidDateTime() {
		return bidDateTime;
	}
}
