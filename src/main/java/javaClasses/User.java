package javaClasses;

public class User {

	/**
	 * This class represents a user.
	 * Each user has a unique id and email.
	 * One user can have the status of Admin. Admin appoints Customer Representatives.
	 */
	
	private String username;
	private String email;
	private String firstName;
	private String lastName;
	private String password;
	private int isCustRep;
	
	public User(String username, String email, String firstName, String lastName, String password, int isCustRep) {
		this.username = username;
		this.email = email;
		this.firstName = firstName;
		this.lastName = lastName;
		this.password = password;
		this.isCustRep = isCustRep;
	}

	public String getUsername() {
		return username;
	}

	public String getEmail() {
		return email;
	}

	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public String getPassword() {
		return password;
	}

	public int getIsCustRep() {
		return isCustRep;
	}
}
