<?php

include("config.php");

$sql = "create table if not exists customers(CID int not null auto_increment, Name varchar(16) default null, Address varchar(64) default null, Phone_no char(10) default null, Email varchar(64) not null, constraint customer_pk primary key(CID,Email))";

$result = mysqli_query($conn, $sql);
if(!$result){
  echo "query error: " . mysqli_error($conn);
  exit;
}

$sql = "create table if not exists creditcards (CNumber int not null, BillingAddr varchar(16) not null, Code char(3) not null, ExpDate date not null, Name varchar(20) not null, constraint credit_card_pk primary key(CNumber))";

$result = mysqli_query($conn, $sql);
if(!$result){
  echo "query error: " . mysqli_error($conn);
  exit;
}

$sql = "create table if not exists hotels (HotelID int not null, Street varchar(32) default null, City varchar(16) default null, Country varchar(16) default null, State varchar(16) default null, Zip char(5) default null, constraint hotel_pk primary key(HotelID))";

$result = mysqli_query($conn, $sql);
if(!$result){
  echo "query error: " . mysqli_error($conn);
  exit;
}

$sql = "create table if not exists hotel_phones (HotelID int not null, PhoneNo char(10) not null, constraint hotel_phone_pk primary key(HotelID, PhoneNo), constraint hotel_phones_hotel_fk foreign key(HotelID) references hotels(HotelID))";

$result = mysqli_query($conn, $sql);
if(!$result){
  echo "query error: " . mysqli_error($conn);
  exit;
}

$sql = "create table if not exists rooms (HotelID int not null, RoomNo int not null, Type varchar(16) default null, Price decimal(5,2) default null, Description text, FloorNo int not null, Capacity int not null, Discount decimal(4,4) default null, StartDate date default null, EndDate date default null, constraint room_pk primary key(HotelID, RoomNo), constraint room_hotel_fk foreign key(HotelID) references hotels(HotelID) on delete cascade on update cascade)";

$result = mysqli_query($conn, $sql);
if(!$result){
  echo "query error: " . mysqli_error($conn);
  exit;
}

$sql = "create table if not exists reservations (InvoiceNo int not null auto_increment, CID int not null, Cnumber int not null, Rdate date default null, constraint reservation_pk primary key(InvoiceNo), constraint reservation_customer_fk foreign key(CID) references customers(CID) on delete cascade on update cascade, constraint reservation_credit_card_fk foreign key(Cnumber) references creditcards(CNumber) on delete cascade on update cascade)";

$result = mysqli_query($conn, $sql);
if(!$result){
  echo "query error: " . mysqli_error($conn);
  exit;
}

$sql = "create table if not exists reserves_room (InvoiceNo int not null, HotelID int not null, RoomNo int not null, CheckInDate date not null, CheckOutDate date not null, constraint reserves_room_pk primary key(HotelID, RoomNo, CheckInDate), constraint reserves_room_room_fk foreign key(HotelID, RoomNo) references rooms(HotelID, RoomNo) on delete cascade on update cascade, constraint reserves_room_fk foreign key(InvoiceNo) references reservations(InvoiceNo) on delete cascade on update cascade)";

$result = mysqli_query($conn, $sql);
if(!$result){
  echo "query error: " . mysqli_error($conn);
  exit;
}


$sql = "create table if not exists services (HotelID int not null, SType varchar(16) not null, Scost decimal(5,2) default null, constraint service_pk primary key(HotelID, SType), constraint service_hotel_fk foreign key(HotelID) references hotels(HotelID) on delete cascade on update cascade)";

$result = mysqli_query($conn, $sql);
if(!$result){
  echo "query error: " . mysqli_error($conn);
  exit;
}

$sql = "create table if not exists breakfasts(HotelID int not null, BType varchar(16) not null, BPrice decimal(5,2) default null, Description text, constraint breakfast_pk primary key(HotelID, BType), constraint breakfast_hotel_fk foreign key(HotelID) references hotels(HotelID) on delete cascade on update cascade)";

$result = mysqli_query($conn, $sql);
if(!$result){
  echo "query error: " . mysqli_error($conn);
  exit;
}

$sql = "create table if not exists room_reviews (RID int not null auto_increment, Rating int default null check(Rating between 0 and 10), Text text, CID int default null, HotelID int not null, RoomNo int not null, constraint room_reviews_pk primary key(RID), constraint room_reviews_customer_fk foreign key(CID) references customers(CID) on delete set null on update cascade, constraint room_reviews_room_fk foreign key(HotelID, RoomNo) references rooms(HotelID, RoomNo) on delete cascade on update cascade)";

$result = mysqli_query($conn, $sql);
if(!$result){
  echo "query error: " . mysqli_error($conn);
  exit;
}

$sql = "create table if not exists breakfast_reviews (RID int not null auto_increment, HotelID int not null, BType varchar(16) not null, CID int default null, Text text, Rating int default null check(Rating between 0 and 5), constraint breakfast_reviews_pk primary key(RID), constraint breakfast_reviews_breakfast_fk foreign key(HotelID, BType) references breakfasts(HotelID, BType) on delete cascade on update cascade, constraint breakfast_reviews_customer_fk foreign key(CID) references customers(CID) on delete set null on update cascade)";

$result = mysqli_query($conn, $sql);
if(!$result){
  echo "query error: " . mysqli_error($conn);
  exit;
}

$sql = "create table if not exists service_reviews (RID int not null auto_increment, HotelID int not null, SType varchar(16) not null, CID int default null, Rating int default null check(Rating between 0 and 10), Text text, constraint service_reviews_pk primary key(RID), constraint service_reviews_service_fk foreign key(HotelID, SType) references services(HotelID, SType) on delete cascade on update cascade, constraint service_reviews_customer_fk foreign key(CID) references customers(CID) on delete set null on update cascade)";

$result = mysqli_query($conn, $sql);
if(!$result){
  echo "query error: " . mysqli_error($conn);
  exit;
}


$sql = "create table if not exists reserves_breakfasts(Btype varchar(16) not null, HotelID int not null, RoomNo int not null, CheckInDate date not null, NoofOrders int default null, constraint reserves_breakfast_pk primary key(Btype, HotelID, RoomNo, CheckInDate), constraint reserves_breakfast_breakfast_fk foreign key(HotelID, Btype) references breakfasts(HotelID, BType) on delete cascade on update cascade, constraint reserves_breakfast_reserves_room_fk foreign key(HotelID, RoomNo, CheckInDate) references reserves_room(HotelID, RoomNo, CheckInDate) on delete cascade on update cascade)";

$result = mysqli_query($conn, $sql);
if(!$result){
  echo "query error: " . mysqli_error($conn);
  exit;
}

$sql = "create table if not exists reserves_services (Stype varchar(16) not null, HotelID int not null, RoomNo int not null, CheckInDate date not null, constraint reserves_service_pk primary key(Stype, HotelID, RoomNo, CheckInDate), constraint reserves_service_service_fk foreign key(HotelID, Stype) references services(HotelID, SType) on delete cascade on update cascade, constraint reserves_service_reserves_room_fk foreign key(HotelID, RoomNo, CheckInDate) references reserves_room(HotelID, RoomNo, CheckInDate) on delete cascade on update cascade)";

$result = mysqli_query($conn, $sql);
if(!$result){
  echo "query error: " . mysqli_error($conn);
  exit;
}


?>
