package javaClasses;

/**
 * This class organizes motorcycle specific details
 * 
 * @author Amit
 *
 */

public class Motorcycle {
	private String hasStorage;
	private String typeOfMotorCycle;
	private int vin;
	
	public Motorcycle(String hasStorage, String typeOfMotorCycle, int vin) {
		this.hasStorage = hasStorage;
		this.typeOfMotorCycle = typeOfMotorCycle;
		this.vin = vin;
	}

	public String getHasStorage() {
		return hasStorage;
	}

	public String getTypeOfMotorCycle() {
		return typeOfMotorCycle;
	}

	public int getVin() {
		return vin;
	}
}
