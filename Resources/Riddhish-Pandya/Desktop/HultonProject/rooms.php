<?php

include('config.php');

session_start();

$HotelID = $_SESSION['hotelid'];
$type = $_SESSION['type'];

$sql = "SELECT * FROM rooms WHERE HotelID='$HotelID' and Type='$type'";
$result = mysqli_query($conn, $sql);
echo "Rooms of ";
echo $type;
echo " Type:";
echo "<br />";

?>
<style>
table {
    width:100%;
}
table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
}
th, td {
    padding: 5px;
    text-align: left;
}
table#style tr:nth-child(even) {
    background-color: #eee;
}
table#style tr:nth-child(odd) {
   background-color:#fff;
}
table#style th {
    background-color: black;
    color: white;
}
</style>
<table>
    <thead>
        <tr>
            <th>Room Number</th>
            <th>Capacity</th>
            <th>Price</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <!--Use a while loop to make a table row for every DB row-->
        <?php while($row = mysqli_fetch_array($result)) : ?>
        <tr>
            <!--Each table column is echoed in to a td cell-->
            <td><?php echo $row['RoomNo']; ?><form action="registration.html" method="POST">
                                             <button type="submit">CHOOSE ROOM</button><br></td>
                                             </form>
            <td><?php echo $row['Capacity']; ?></td>
            <td><?php $Price = $row['Price']; $_SESSION['Price'] = $Price; echo $row['Price']; ?></td>
            <td><?php echo $row['Description']; ?></td>
        </tr>
        <?php endwhile ?>
    </tbody>
</table>
<?php
echo "<a href=http://localhost/HultonProject/homepage.html>Homepage</a>";



?>
