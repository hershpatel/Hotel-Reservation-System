<?php

include('config.php');

session_start();

$HotelID = $_SESSION['hotelid'];
$type = $_SESSION['type'];
$Price = $_SESSION['Price'];
echo "Total Price:  ";
echo $Price;
echo "<br\>"


?>
<!DOCTYPE HTML>
<html>
<head>
<title>Pay Here</title>
</head>
<body id="body-color">
<div id="Sign-Up">
<fieldset style="width:30%"><legend>Pay Here</legend>
<table border="0">
<tr>
<form method="POST" action="pays.php">
<td>Name</td><td> <input type="text" name="Name" required></td>
</tr>
<tr>
<td>Email</td><td><input type="email" id="email" name="Email"required></td>
</tr>
<tr>
<td>Billing Address</td><td> <input type="text" name="BillingAddr" required></td>
</tr>
<tr>
<td>Type</td><td><input type="text" name="Type" required></td>
</tr
<tr>
<td>Card Number</td><td><input type="text" name="CNumber"required></td>
</tr>
<tr>
<td>Code</td><td><input type="text" name="Code" required></td>
</tr>
<tr>
<td>Expiration Date</td><td><input type="date" name="ExpDate" required></td>
</tr>
<tr>
<td><input id="button" type="submit" name="submit" value="Pay Now"></td>
</tr>
</form>
</table>
</fieldset>
</div>
</body>
</html>
<?php

?>
