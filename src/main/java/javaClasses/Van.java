package javaClasses;

/**
 * This class organizes van specific details.
 * 
 * @author Amit
 *
 */

public class Van {
	private String vanMiniOrFull;
	private int vin;
	
	public Van(String vanMiniOrFull, int vin) {
		this.vanMiniOrFull = vanMiniOrFull;
		this.vin = vin;
	}

	public String getVanMiniOrFull() {
		return vanMiniOrFull;
	}

	public int getVin() {
		return vin;
	}
}
