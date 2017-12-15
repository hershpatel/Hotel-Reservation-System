<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		try {

			//Create a connection string
			String url = "jdbc:mysql://cs336-2.crujdr9emkb3.us-east-1.rds.amazonaws.com:3306/BarBeerDrinkerSample";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");

			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "student", "student");

			//Create a SQL statement
			Statement stmt = con.createStatement();

			//Parse out the information from the newBeer.jsp
			String newBar = request.getParameter("bar");
			String newBeer = request.getParameter("beer");
			String addr = request.getParameter("addr");
			String city = request.getParameter("city");
			String phone = request.getParameter("phone");
			String license = request.getParameter("license");
			String manf = request.getParameter("manufacturer");
			int uBar = Integer.parseInt(request.getParameter("ubar"));
			int uBeer = Integer.parseInt(request.getParameter("ubeer"));

			if (uBar > 0) {
				//make an update SQL query
				String insert1 = "UPDATE bars SET license = ?, addr = ?, city = ?, phone = ?"
						+ "WHERE name = ?";
				//make a statement object that will execute the query
				PreparedStatement ps = con.prepareStatement(insert1);

				//add query parameters to the statement object
				ps.setString(1, license);
				ps.setString(2, addr);
				ps.setString(3, city);
				ps.setString(4, phone);
				ps.setString(5, newBar);

				//run the query against the database
				ps.executeUpdate();
			}
			if (uBeer > 0) {
				//make an update SQL query
				String insert = "UPDATE beers SET manf = ?"
						+ "WHERE name = ?";
				//make a statement object that will execute the query
				PreparedStatement ps = con.prepareStatement(insert);

				//add query parameters to the statement object
				ps.setString(1, manf);
				ps.setString(2, newBeer);
				//run the query against the database
				ps.executeUpdate();

			}
			//close the connection
			con.close();

			//notify the user that the update succeeded.
			out.print("Update succeeded");

		} catch (Exception ex) {
		}
	%>
</body>
</html>