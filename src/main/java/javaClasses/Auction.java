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
	private int auctionID;
	private String creator;
	private String auctionName;
	private float initialPrice;
	private float currentPrice;
	private float minimumSellingPrice;
	private float bidIncrement;
	private String vehicleType;
	private LocalDateTime startingDateTime;
	private LocalDateTime endingDateTime;
	private float autoBidHighest;
	private String currentHighestBidder = "";
	private String winner;
	private String status;
	
	public Auction(int auctionID, String creator, String auctionName, float initialPrice, float currentPrice,
			float minimumSellingPrice, float bidIncrement, String vehicleType, LocalDateTime startingDateTime,
			LocalDateTime endingDateTime, float autoBidHighest, String currentHighestBidder, String winner, String status) {
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
		this.autoBidHighest = autoBidHighest;
		this.currentHighestBidder = currentHighestBidder;
		this.winner = winner;
		this.status = status;
	}

	public int getAuctionID() {
		return auctionID;
	}

	public String getCreator() {
		return creator;
	}

	public String getAuctionName() {
		return auctionName;
	}

	public float getInitialPrice() {
		return initialPrice;
	}

	public float getCurrentPrice() {
		return currentPrice;
	}

	public float getMinimumSellingPrice() {
		return minimumSellingPrice;
	}

	public float getBidIncrement() {
		return bidIncrement;
	}

	public String getVehicleType() {
		return vehicleType;
	}

	public LocalDateTime getStartingDateTime() {
		return startingDateTime;
	}

	public LocalDateTime getEndingDateTime() {
		return endingDateTime;
	}

	public float getAutoBidHighest() {
		return autoBidHighest;
	}

	public String getCurrentHighestBidder() {
		return currentHighestBidder;
	}

	public String getWinner() {
		return winner;
	}
	
	public String getStatus() {
		return status;
	}
}
