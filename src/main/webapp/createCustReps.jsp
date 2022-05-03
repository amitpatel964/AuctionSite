<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<!-- This page will allow the admin to create accounts for customer reps. based on the information that they enter. -->

<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Customer Representatives</title>
</head>
	<body>
		<div>
			<a href='adminHomePage.jsp'>Home Page</a>
			<a href='logout.jsp'>Log out</a>
		</div>
		<div>
			Please enter the following information to create an account for a Customer Representative.
		</div>
		<div>
			<form action="processNewCustRep.jsp" method="POST">
				ID: <input type="text" name="id"/> <br/>
				First Name: <input type="text" name="firstName"/> <br/>
				Last Name: <input type="text" name="lastName"/> <br/>
				Email: <input type="text" name="email"/> <br/>
				Password: <input type="text" name="password"/> <br/>
 				<br/>
				<br/>
				<input type="submit" value="Create Customer Representative"/>
			</form>
		</div>
	</body>
</html>