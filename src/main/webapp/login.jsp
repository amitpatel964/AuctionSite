<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Login Page</title>
	</head>
	
	<body>
		<form action="checkLoginDetails.jsp" method="POST">
			<div>
				Welcome to our Auction Site!
			</div>
			<div>
				Username: <input type="text" name="username"/> <br/>
				Password: <input type="text" name="password"/> <br/>
				<input type="submit" value="Login"/>
			</div>
		</form>
	</body>
</html>