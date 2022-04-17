package javaClasses;

/**
 * This class represents a vehicle. A vehicle can be a car, truck, van or suv.
 * auctionID is also included to help associate the vehicle with an auction.
 * 
 * @author Amit
 *
 */

public class Vehicle {
	int vin;
	int numberOfDoors;
	int numberOfWheels;
	int numberOfSeats;
	int mileage;
	int milesPerGallon;
	String fuelType;
	String newOrUsed;
	String manufacturer;
	String model;
	int year;
	String color;
	String wheelDriveType;
	String transmissionType;
	int auctionID;
	
	public Vehicle(int vin, int numberOfDoors, int numberOfWheels, int numberOfSeats, int mileage, int milesPerGallon,
			String fuelType, String newOrUsed, String manufacturer, String model, int year, String color,
			String wheelDriveType, String transmissionType, int auctionID) {
		this.vin = vin;
		this.numberOfDoors = numberOfDoors;
		this.numberOfWheels = numberOfWheels;
		this.numberOfSeats = numberOfSeats;
		this.mileage = mileage;
		this.milesPerGallon = milesPerGallon;
		this.fuelType = fuelType;
		this.newOrUsed = newOrUsed;
		this.manufacturer = manufacturer;
		this.model = model;
		this.year = year;
		this.color = color;
		this.wheelDriveType = wheelDriveType;
		this.transmissionType = transmissionType;
		this.auctionID = auctionID;
	}

	public int getVin() {
		return vin;
	}

	public int getNumberOfDoors() {
		return numberOfDoors;
	}

	public int getNumberOfWheels() {
		return numberOfWheels;
	}

	public int getNumberOfSeats() {
		return numberOfSeats;
	}

	public int getMileage() {
		return mileage;
	}

	public int getMilesPerGallon() {
		return milesPerGallon;
	}

	public String getFuelType() {
		return fuelType;
	}

	public String getNewOrUsed() {
		return newOrUsed;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public String getModel() {
		return model;
	}

	public int getYear() {
		return year;
	}

	public String getColor() {
		return color;
	}

	public String getWheelDriveType() {
		return wheelDriveType;
	}

	public String getTransmisionType() {
		return transmissionType;
	}

	public int getAuctionID() {
		return auctionID;
	}
}
