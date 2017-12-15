<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
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

		//Populate SQL statement with an actual query. It returns a single number. The number of beers in the DB.
		String str = "SELECT COUNT(*) as cnt FROM beers";

		//Run the query against the DB
		ResultSet result = stmt.executeQuery(str);

		//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
		result.next();
		//Parse out the result of the query
		int countBeers = result.getInt("cnt");

		//Populate SQL statement with an actual query. It returns a single number. The number of beers in the DB.
		str = "SELECT COUNT(*) as cnt FROM bars";
		//Run the query against the DB
		result = stmt.executeQuery(str);
		//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
		result.next();
		//Parse out the result of the query
		int countBars = result.getInt("cnt");

		//Get parameters from the HTML form at the HelloWorld.jsp
		String newBar = request.getParameter("bar");
		String newBeer = request.getParameter("beer");
		float price = Float.valueOf(request.getParameter("price"));

		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO sells(bar, beer, price)"
				+ "VALUES (?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, newBar);
		ps.setString(2, newBeer);
		ps.setFloat(3, price);
		//Run the query against the DB
		ps.executeUpdate();

		//Check counts once again (the same as the above)
		str = "SELECT COUNT(*) as cnt FROM beers";
		result = stmt.executeQuery(str);
		result.next();
		System.out.println("Here");
		int countBeersN = result.getInt("cnt");
		System.out.println(countBeersN);
		str = "SELECT COUNT(*) as cnt FROM bars";
		result = stmt.executeQuery(str);
		result.next();
		int countBarsN = result.getInt("cnt");

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		//Compare counts of the beers and bars before INSERT on Sells and after to figure out whether there is a bar and a beer stub records inserted by a trigger. 
		int updateBeer = (countBeers != countBeersN) ? 1 : 0;
		int updateBar = (countBars != countBarsN) ? 1 : 0;
		;
		System.out.println(updateBeer + "   " + updateBar);
		if (updateBeer > 0) {
			//Create a dynamic HTML form for beer update if needed. The form is not going to show up if the beer specified at HelloWorld.jsp already exists in the database.
			out.print("Beer " + newBeer + " details: <br>");
			out.print("<form method=\"post\" action=\"newBeerDetails.jsp\">"
					+ "<table> <tr>	<td>Manf</td><td><input type=\"text\" name=\"manufacturer\"></td>   	</tr>"
					+ "</table> <br>");
		}

		if (updateBar > 0) {
			//Create a dynamic HTML form for bar update if needed. The form is not going to show up if the bar  specified at HelloWorld.jsp already exists in the database..
			//The form goes inside the HTML table too make alignment of the elements prettier.
			//See show.jsp for clear notation of the HTML table and HelloWorld.jsp for clear notation of the HTML form
			out.print("Bar " + newBar + " details: <br>");
			out.print("<table> <tr>	<td>Address</td><td><input type=\"text\" name=\"addr\"></td>   	</tr>"
					+ " 	<tr>  	<td>License</td><td><input type=\"text\" name=\"license\"></td> 	</tr>"
					+ "	<tr>  	<td>City</td><td><input type=\"text\" name=\"city\"></td> 	</tr>"
					+ "	<tr>  	<td>Phone</td><td><input type=\"text\" name=\"phone\"></td> 	</tr>"
					+ "</table> <br> <input type=\"submit\" value=\"submit\">"
					+
					//use hidden inputs to pass the new beer and new bar keys as well as requiresUpdate flags to the update page.
					"<input type=\"hidden\" name=\"bar\" value=\""
					+ newBar
					+ "\"/>"
					+ "<input type=\"hidden\" name=\"beer\" value=\""
					+ newBeer
					+ "\"/>"
					+ "<input type=\"hidden\" name=\"ubar\" value=\""
					+ Integer.toString(updateBar)
					+ "\"/>"
					+ "<input type=\"hidden\" name=\"ubeer\" value=\""
					+ Integer.toString(updateBeer) + "\"/>" + "</form>");
		}

		out.print("insert succeeded");
	} catch (Exception ex) {
		out.print("insert failed");
	}
%>
</body>
</html>