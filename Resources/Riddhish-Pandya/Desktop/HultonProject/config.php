<?php

// $host = "localhost";
// $user = "root";
// $pass = "pig1mango";
// $dbname = "Hulton_test"

// Create connection
$conn = mysqli_connect("localhost", "root", "pig1mango", "Hulton_DB");

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
//echo "Connected successfully";
?>
