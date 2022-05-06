<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javaClasses.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>

<!-- This page is where the admin can see the sales report. -->

<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales Report</title>
</head>
<body>
		<div>
			<a href='adminHomePage.jsp'>Home Page</a>
		</div>
			Sales Report
		<div> 
		<br/>
			<%
			List<Auction> auction = HelperFunctions.getListOfAuctions();
			if (auction.size() == 0) {
				out.println("No finished auctions at the moment. Please refresh the page when at least one auction has ended");
			}else{
				List<SalesReport> salesReport = HelperFunctions.salesReport(auction);
				out.println("Total Earnings: $" + salesReport.get(0).getSum()); 
				%><br/><br/>
				<%
				out.println("Earnings Per Vehicle");
				%><br/>
				<%
				int j = 0;
				for(int i = 1; i < salesReport.size(); i++){
					if(salesReport.get(i).getVin() != 0){
						out.println("Vehicle ID: " + salesReport.get(i).getVin() + " Earnings: $" + salesReport.get(i).getSum()); 
					}else{
						j = i;
						break;
					}
				}
				%><br/><br/>
				<%
				out.println("Earnings Per Vehicle Type");
				%><br/>
				<%
				for(int i = j; i < salesReport.size(); i++){
					if(salesReport.get(i).getVehicleType().equals("")){
						j = i;
						break;
					}else{
						out.println("Vehicle Type: " + salesReport.get(i).getVehicleType() + " Earnings: $" + salesReport.get(i).getSum());
					}
				}
				%><br/><br/>
				<%
				out.println("Earnings Per User");
				%><br/>
				<%
				for(int i = j; i < salesReport.size(); i++){
					if(salesReport.get(i).getUsername().equals("")){
						j = i;
						break;
					}else{
						out.println("User: " + salesReport.get(i).getUsername() + " Earnings: $" + salesReport.get(i).getSum()); 
					}
				}
				%><br/><br/>
				<%
				out.println("Best Items");
				%><br/>
				<%
				for(int i = j; i < salesReport.size(); i++){
					if(salesReport.get(i).getVehicleType().equals("")){
						j = i;
						break;
					}else{
						out.println("Vehicle Type: " + salesReport.get(i).getVehicleType() + " Amount Sold: " + salesReport.get(i).getCount()); 
					}
				}
				%><br/><br/>
				<%
				out.println("Best Buyers");
				%><br/>
				<%
				for(int i = j; i < salesReport.size(); i++){
					if(!salesReport.get(i).getVehicleType().equals("")){
						out.println("User: " + salesReport.get(i).getUsername() + " Amount Spent: $" + salesReport.get(i).getSum());
					} 
				}
				%><br/>
				<%
				
			}
			%>
			
		</div>
</body>
</html>
