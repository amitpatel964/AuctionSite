<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Remove Auctions</title>
</head>
<body>
<% 
	ApplicationDB db = new ApplicationDB();	
	java.sql.Connection con = db.getConnection();
	java.sql.Statement statement = con.createStatement();
	String newAuction = request.getParameter("auctionID");
	ResultSet output = null;
	output.next();
	if(output.getString("status").equals ("open"))
	{
		String delete = "DELETE FROM auction WHERE auctionID ='" + request.getParameter("auctionID") + "'";
		statement.executeUpdate(delete);
	}
	else
	{
		out.print("Error");	
	}
	%>
</body>
</html>