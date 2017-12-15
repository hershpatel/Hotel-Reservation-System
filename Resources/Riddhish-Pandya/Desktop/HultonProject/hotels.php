<?php


include('config.php');

$checkin = $_POST['checkin'];
$checkout = $_POST['checkout'];
$country = $_POST['Country'];
$state = $_POST['State'];
$type = $_POST['Type'];

if (strtotime($checkout) <= strtotime($checkin)) {
    echo 'Check-Out is before Check-In';
    echo "<br>";
    echo "<a href=\"javascript:history.go(-1)\">GO BACK</a>";
    echo "<br>";
} else {

    $sql = "SELECT * FROM hotels WHERE State='$state'";
    $result = mysqli_query($conn, $sql);

    if ($result && mysqli_num_rows($result) > 0) {
        echo "Hultons in $state ";
        echo "<br />";
        echo "-----------------------------------";
        echo "<br />";
        while($row = mysqli_fetch_array($result)) {
             $HotelID = $row['HotelID'];
             $Street = $row['Street'];
             $City = $row['City'];
             $Zip = $row['ZIP'];
             $State = $row['State'];
             $Country = $row['Country'];
             echo $Street;
             echo ', ';
             echo $City;
             echo " ";
             echo $State;
             echo ', ';
             echo $Zip;
             echo " ";
             echo $Country;
             echo "<br />";
        }
        session_start();

        $_SESSION['type'] = $type;
        $_SESSION['hotelid'] = $HotelID;

        ?>
            <form action="rooms.php" method="POST">
            <button type="submit">Choose Hotel</button><br>
            </form>
        <?php
    }
    else {
        echo "RETURNED NOTHING";
        echo "<a href=\"javascript:history.go(-1)\">GO BACK</a>";
    }
    //
    // $data = array();
    // $count_hotels = mysqli_num_rows($result);
    // for($i=0; $i < $count_hotels; $i++){
    //   $row = mysqli_fetch_assoc($result);
    //   array_push($data, $row['HotelID']);
    // }
    //
    // $data_json = json_encode($data);
    // echo $data_json;

}
?>
