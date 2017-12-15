<?php

include('config.php');


	$name = $_POST['Name'];
	$email = $_POST['Email'];
	$address = $_POST['Address'];
	$phone_no =  $_POST['Phone_no'];



	$select = "SELECT * FROM customers WHERE Email='$email'";

	$check = mysqli_query($conn, $select);


	if (mysqli_num_rows($check) != 0) {
		 echo 'Already Exist in the Database...';
		 echo "\r\n";
		 echo 'Proceed to Login';
		 echo "\r\n";
		 echo "<a href=\"javascript:history.go(-1)\">GO BACK</a>";
	 }
	 else {

		 	$query = "INSERT INTO customers(Name,Address,Phone_no,Email) VALUES ('$name','$address','$phone_no','$email')";
		 	$result = mysqli_query($conn, $query);
		 	if(!$result){
		 	  echo "query error: " . mysqli_error($conn);
		 	  exit;
		 	}
			 echo "Account Successfully Created..You May Go Back and Login";
			 echo "<br />";
		   echo "<a href=\"javascript:history.go(-1)\">GO BACK</a>";
	 }

?>
