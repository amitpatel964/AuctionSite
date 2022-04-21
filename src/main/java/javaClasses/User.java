package javaClasses;

public class User {

	/**
	 * This class represents a user.
	 * Each user has a unique id and email. First and last are not distinct.
	 */
	
	private int id;
	private String firstName;
	private String lastName;
	private String password;
	private String email;
	
	public User(int id, String firstName, String lastName, String password, String email) {
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.password = password;
		this.email = email;
	}
	
	public int getId() {
		return id;
	}

	public String getFirstName() {
		return firstName;
	}

	public String getlastName() {
		return lastName;
	}

	public String getEmail(){
		return email;
	}
	
	public String getPassword(){
		return password;
	}
	
	
}