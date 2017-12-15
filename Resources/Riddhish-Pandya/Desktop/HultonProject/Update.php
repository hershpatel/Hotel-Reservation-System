<?php

include('config.php');


	$name = $_POST['Name'];
	$email = $_POST['Email'];
	$address = $_POST['Address'];
	$phone_no =  $_POST['Phone_no'];

  echo $name;
  echo $email;
  echo $address;
  echo $phone_no;

	$select = "SELECT * FROM customers WHERE Email='$email'";

	$check = mysqli_query($conn, $select);

  $update0 = "UPDATE customers SET Name ='$name' WHERE  Email='$email'";
  $update1 = "UPDATE customers SET Name ='$name' WHERE  Email='$email'";
  $update2 = "UPDATE customers SET Address ='$address' WHERE  Email='$email'";
  $update3 = "UPDATE customers SET Phone_no ='$phone_no' WHERE  Email='$email'";

  mysqli_query($conn, $update0);
  mysqli_query($conn, $update1);
  mysqli_query($conn, $update2);
  mysqli_query($conn, $update3);

  echo "<a href=\"javascript:history.go(-1)\">GO BACK</a>";

?>
