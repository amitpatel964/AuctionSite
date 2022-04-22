package javaClasses;

/**
 * This class organizes suv specific details
 * 
 * @author Amit
 *
 */

public class Suv {
	private String seatsExpandable;
	private int vin;
	
	public Suv(String seatsExpandable, int vin) {
		super();
		this.seatsExpandable = seatsExpandable;
		this.vin = vin;
	}

	public String getSeatsExpandable() {
		return seatsExpandable;
	}

	public int getVin() {
		return vin;
	}
}
