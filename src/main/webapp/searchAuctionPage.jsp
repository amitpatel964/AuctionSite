<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Search</title>
	</head>
	
	<body>
		<div>
			<a href='userHomePage.jsp'>Home Page</a>
			<a href='logout.jsp'>Log out</a>
		</div>
		
		<%
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		Statement statement = con.createStatement();
		
		ResultSet auctions = statement.executeQuery("select * from auction");
		ResultSetMetaData data = auctions.getMetaData();
		int numberOfColumns = data.getColumnCount();
		while (auctions.next()) {
			for (int i = 1; i <= numberOfColumns; i++) {
				if (i > 1) {
					out.print(", ");
				}
				String valueForCurrentColumn = auctions.getString(i);
				out.print(valueForCurrentColumn + " " + data.getColumnName(i));
			}
			out.println("");
		}
		%>
	</body>
</html>