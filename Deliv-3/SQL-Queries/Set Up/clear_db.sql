#clear databases

DELETE FROM `creditcard`
WHERE `InvoiceNo` >=1;

DELETE FROM `includes`
WHERE `invoiceNo` >=1;

DELETE FROM `contains`
WHERE `invoiceNo` >=1;

DELETE FROM `service_review`
WHERE `reviewID` >=1;

DELETE FROM `breakfast_review`
WHERE `reviewID` >=1;

DELETE FROM `room_review`
WHERE `reviewID` >=1;

DELETE FROM `review`
WHERE `reviewID` >=1;

ALTER TABLE `review` AUTO_INCREMENT = 1 ;

DELETE FROM `services`
WHERE `hotelID` >=1;

DELETE FROM `breakfast`
WHERE `hotelID` >=1;

DELETE FROM `reserves`
WHERE `invoiceNo` >=1;

DELETE FROM `reservation`
WHERE `invoiceNo` >=1;

ALTER TABLE `reservation` AUTO_INCREMENT = 1;

DELETE FROM `room_discount`
WHERE `hotelID` >=1;

DELETE FROM `myroom`
WHERE `hotelID` >=1;

DELETE FROM `HotelPhoneNumbers`
WHERE `hotelID` >=1;

DELETE FROM `hotel`
WHERE `hotelID` >=1;

ALTER TABLE `hotel` AUTO_INCREMENT = 1 ;
