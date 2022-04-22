package javaClasses;

/**
 * This class organizes car specific details
 * 
 * @author Amit
 *
 */

public class Car {
	private String typeOfCar;
	private String isConvertible;
	private int vin;
	
	public Car(String typeOfCar, String isConvertible, int vin) {
		this.typeOfCar = typeOfCar;
		this.isConvertible = isConvertible;
		this.vin = vin;
	}

	public String getTypeOfCar() {
		return typeOfCar;
	}

	public String getIsConvertible() {
		return isConvertible;
	}

	public int getVin() {
		return vin;
	}
}
