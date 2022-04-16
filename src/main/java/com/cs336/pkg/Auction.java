package com.cs336.pkg;

import java.time.LocalDateTime;

public class Auction {
	int auctionID;
	String auctionName;
	float initialPrice;
	float minimumSellingPrice;
	float bidIncrement;
	float autoBidUpperLimit;
	String vehicleType;
	LocalDateTime startingDateTime;
	LocalDateTime endingDateTime;
	String currentHighestBidder = "";
	
//	public Auction (int auctionID, String auctionName, float initialPrice, float minimumSellingPrice, float bidIncrement,
//			float autoBidUpperLimit, String vehicleType, LocalDateTime startingDateTime, LocalDateTime endingDateTime) {
//		this.auctionID = auctionID;
//		this.initialPrice = initialPrice;
//		this.minimumSellingPrice = minimumSellingPrice;
//		this.bidIncrement = bidIncrement;
//		this.autoBidUpperLimit = autoBidUpperLimit;
//		this.vehicleType = vehicleType;
//		this.startingDateTime = startingDateTime;
//		this.endingDateTime = endingDateTime;
//	}
	
	public int getAuctionID() {
		return this.auctionID;
	}
	
	public String getAuctionName() {
		return this.auctionName;
	}
	
	public float getIntializePrice() {
		return this.initialPrice;
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
