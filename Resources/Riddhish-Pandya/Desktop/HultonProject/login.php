<?php


include('config.php');

$email = $_POST['Email'];

$query = "SELECT * FROM customers WHERE Email='$email'";

$result = mysqli_query($conn, $query);

if ($result && mysqli_num_rows($result) > 0)

    {
        echo "E-MAIL CANNOT CHANGE";
        while($row = mysqli_fetch_array($result))
         {

         $name = $row['Name'];
         $address = $row['Address'];
         $phone_no= $row['Phone_no'];
         $row['Email']; //these are the fields that you have stored in your database table employee
         echo "<br />";
         }
         ?>
         <fieldset style="width:30%"><legend>Update</legend>
         <table border="0">
         <tr>
         <form method="POST" action="Update.php">
         <td>Name</td><td> <input type="text" name="Name" placeholder="<?php echo $name; ?>"></td>
         </tr>
         <tr>
         <td>Email</td><td><input type="email" id="email" name="Email"required placeholder="<?php echo $email; ?>"disabled></td>
         </tr>
         <tr>
         <td>Address</td><td> <input type="text" name="Address" placeholder="<?php echo $address; ?>"></td>
         </tr>
         <tr>
         <td>Phone Number</td><td><input type="text" name="Phone_no" maxlength="10"  pattern="[0-9]{10}"required placeholder="<?php echo $phone_no; ?>"></td>
        </tr>
         <tr>
         <td><input id="button" type="submit" name="submit" value="Update"></td>
         </tr>
         </form>
         </table>
          <form action="credit_card.php" method="get">
          <button type="submit">Pay Now</button><br>
          </form>
         </fieldset>
         <?php
    }
else
    {
        echo 'Username and Password NOT Found';
    }
echo "\n";
echo "<a href=\"javascript:history.go(-1)\">GO BACK</a>";
?>
