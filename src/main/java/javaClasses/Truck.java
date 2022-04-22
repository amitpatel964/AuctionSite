package javaClasses;

/**
 * This class organizes truck specific details.
 * 
 * @author Amit
 *
 */

public class Truck {
	private String isPickUpTruck;
	private int numberOfWheels;
	private int vin;
	
	public Truck(String isPickUpTruck, int numberOfWheels, int vin) {
		this.isPickUpTruck = isPickUpTruck;
		this.numberOfWheels = numberOfWheels;
		this.vin = vin;
	}

	public String getIsPickUpTruck() {
		return isPickUpTruck;
	}

	public int getNumberOfWheels() {
		return numberOfWheels;
	}

	public int getVin() {
		return vin;
	}
}
