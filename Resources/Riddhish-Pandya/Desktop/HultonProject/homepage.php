<!doctype html>
<html lang="en">

  <head>
  <meta charset="utf-8" />
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>Find a Hotel</title>
     <!-- my css -->
    <link rel="stylesheet" type="text/css" href="style.css">

    <link rel="stylesheet" type="text/css" href="bootstrap-datepicker.css">

  </head>

  <body>


  	<div class="page-header">

  		<img id="logo" src="Logo.png"/>

  			<div class ="menu-bar">
				<ul>
					<li>Register</li>
  					<li>Login</li>
  					<li>Admin</li>
				</ul>
  			</div>
  	</div>



  	<div class="page-background">

          <p id="phrase1">The Places You'd Rather Be</p>

        <div id="form-wrapper">

          <div id="slogan">
            <h2 id ="one"> Where would you like to Stay?</h2>
            <br><br><br>
          </div>

          <form id="form-reserve" action="login.php" method="post">

            <span style="color:white">Country:</span>
            <input type="text" name="country" placeholder="Country">

            <span style="color:white">State:</span>
            <input type="text" name="state" placeholder="State">
            <br><br>

            <div class="modal-body">
              <div class="input-daterange input-group dp" id="datepicker">
                  <input type="text" class="input-sm form-control" name="checkin" placeholder="Checkin Date" />
                  <span class="input-group-addon">to</span>
                  <input type="text" class="input-sm form-control" name="checkout" placeholder="Checkout Date" />
              </div>
            </div>

            <div class="form-group">
              <label for="sel1">Select Room Type:</label>
              <br>
              <select class="form-control" id="sel1" name="type">
                <option>Standard</option>
                <option>Double</option>
                <option>Deluxe</option>
                <option>Suite</option>
              </select>
            </div>
            <br><br>

            <div class="text-center">
              <button input type="submit" name="search" class="btn btn-primary">Search</button>
            </div>

          </form>
        </div>
  	</div>
    <script src="app.js" charset="utf-8"></script>
    <script src="bootstrap-datepicker.min.js" charset="utf-8"></script>
    <script src="Libs/jquery.js" charset="utf-8"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  </body>
</html>
