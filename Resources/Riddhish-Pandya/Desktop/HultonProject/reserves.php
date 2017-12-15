<?php

include('config.php');

session_start();

$HotelID = $_SESSION['hotelid'];
$type = $_SESSION['type'];

echo "Rooms of ";
echo $type;
echo " Type:";
echo "<br />";
 $Price = $_SESSION['Price'];
 echo $Price;
 echo "Session Works";


?>
