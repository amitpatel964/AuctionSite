package javaClasses;

/**
 * This class organizes Sales Report specific details
 * 
 * @author Michael
 *
 */

public class SalesReport {
	private float sum;
	private int vin;
	private int count;
	private String vehicleType;
	private String username;
	private String bestUser;
	
	public SalesReport(float sum, int vin, int count, String vehicleType, String username, String bestUser) {
		super();
		this.sum = sum;
		this.vin = vin;
		this.count = count;
		this.vehicleType = vehicleType;
		this.username = username;
		this.bestUser = bestUser;
	}

	public float getSum() {
		return sum;
	}
	
	public int getVin() {
		return vin;
	}
	
	public int getCount() {
		return count;
	}
	
	public String getVehicleType() {
		return vehicleType;
	}
	
	public String getUsername() {
		return username;
	}
	
	public String getBestUser() {
		return bestUser;
	}
	
	public void setSum(float s) {
		this.sum = s;
	}
	
	public void setVin(int v) {
		this.vin = v;
	}
	
	public void setCount(int c) {
		this.count = c;
	}
	
	public void setVehicleType(String vt) {
		this.vehicleType = vt;
	}
	
	public void setUsername(String u) {
		this.username = u;
	}
	
	public void setBestUser(String b) {
		this.bestUser = b;
	}
}
