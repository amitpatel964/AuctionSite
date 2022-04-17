package javaClasses;

import java.time.LocalDateTime;

/**
 * This class represents an auction.
 * Each auction has a unique ID, a creator, and various other parameters. The creator should not be able to bid on their own auction.
 * The auction also keeps track of who the current highest bidder is.
 * 
 * @author Amit
 *
 */

public class Auction {
	int auctionID;
	String creator;
	String auctionName;
	float initialPrice;
	float currentPrice;
	float minimumSellingPrice;
	float bidIncrement;
	float autoBidUpperLimit;
	String vehicleType;
	LocalDateTime startingDateTime;
	LocalDateTime endingDateTime;
	String currentHighestBidder = "";
	
	public Auction (int auctionID, String creator, String auctionName, float initialPrice, float minimumSellingPrice, float currentPrice,
			float bidIncrement, String vehicleType, LocalDateTime startingDateTime, LocalDateTime endingDateTime) {
		this.auctionID = auctionID;
		this.creator = creator;
		this.auctionName = auctionName;
		this.initialPrice = initialPrice;
		this.currentPrice = currentPrice;
		this.minimumSellingPrice = minimumSellingPrice;
		this.bidIncrement = bidIncrement;
		this.vehicleType = vehicleType;
		this.startingDateTime = startingDateTime;
		this.endingDateTime = endingDateTime;
	}
	
	public int getAuctionID() {
		return this.auctionID;
	}
	
	public String getCreator() {
		return this.creator;
	}
	
	public String getAuctionName() {
		return this.auctionName;
	}
	
	public float getIntialPrice() {
		return this.initialPrice;
	}
	
	public float getCurrentPrice() {
		return this.currentPrice;
	}
	
	public float getMinimumSellingPrice() {
		return this.minimumSellingPrice;
	}
	
	public float getBidIncrement() {
		return this.bidIncrement;
	}
	
	public float getAutoBidUpperLimit() {
		return this.autoBidUpperLimit;
	}
	
	public String getVehicleType() {
		return this.vehicleType;
	}
	
	public LocalDateTime getStartingDate() {
		return this.startingDateTime;
	}
	
	public LocalDateTime getEndingDate() {
		return this.endingDateTime;
	}
	
	public void setCurrentHighestBidder(String currentHighestBidder) {
		this.currentHighestBidder = currentHighestBidder;
	}
	
	public String getCurrentHighestBidder() {
		return this.currentHighestBidder;
	}
}
