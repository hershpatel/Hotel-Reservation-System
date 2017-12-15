<?php

include('config.php');


	$name = $_POST['Name'];
	$email = $_POST['Email'];
	$billaddress = $_POST['BillingAddr'];
	$type = $_POST['Type'];
	$expdate = $_POST['ExpDate'];
	$cnumber = $_POST['CNumber'];
	$code = $_POST['Code'];


	$query = "INSERT INTO creditcards(CNumber,BillingAddr,Code,ExpDate,Name) VALUES ('$cnumber','$billaddress','$code','$expdate','$name')";
	$result = mysqli_query($conn, $query);
	if(!$result){
	  	echo "query error: " . mysqli_error($conn);
	  	exit;
	}
	else {
		echo"BOOKING CONFIRMED";
		echo "<br />";
		echo "Details Sent Your E-mail!";
		echo "<br />";
	}
 	echo "<a href=http://localhost/HultonProject/homepage.html>Homepage</a>";


	?>
	<form action="write_review.php" method="POST">
	<button type="submit">Write A Review</button><br>
	</form>
<?php

?>
