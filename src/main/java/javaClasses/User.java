package javaClasses;

public class User {

	/**
	 * This class represents a user.
	 * Each user has a unique id and email.
	 * One user can have the status of Admin. Admin appoints Customer Representatives.
	 */
	
	private int id;
	private String firstName;
	private String lastName;
	private String password;
	private String email;
	private boolean custRep;
	private boolean admin;
	
	public User(int id, String firstName, String lastName, String password, String email, boolean cr, boolean ad) {
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.password = password;
		this.email = email;
		custRep = cr;
		admin = ad;
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
	
	public void setId(int i) {
		this.id = i;
	}
	
	public void setFirstName(String f) {
		this.firstName = f;
	}
	
	public void setLastName(String l) {
		this.lastName = l;
	}
	
	public void setEmail(String e) {
		this.email = e;
	}
	
	public void setPassword(String pw) {
		this.password = pw;
	}
	
	public boolean getCustRep() {
		return custRep;
	}
	
	public void setCustRep(boolean c) {
		this.custRep = c;
	}
	
	public boolean getAdmin(){
		return admin;
	}
	
	public void setAdmin(boolean a) {
		this.admin = a;
	}
	
}
