<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Admin Home Page</title>
	</head>
	<body>
		Admin Home Page
		<a href='logout.jsp'>Log out</a>
		
		<form action="createCustReps.jsp" method="POST">
			<p>
				Click the button below to create Customer Representatives.
			</p>
			<input type="submit" value="Create Customer Representatives"/>
		</form>
		<form action="salesReport.jsp" method="POST">
			<p>
				Click the button below to view Sales Report.
			</p>
			<input type="submit" value="Sales Report"/>
		</form>
			<input type="hidden" name="username" value="<%= session.getAttribute("user") %>"/>
		</form>
		
	</body>
</html>
