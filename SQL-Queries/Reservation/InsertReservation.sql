#insertReservation query

INSERT INTO `customer`(`username`, `password`, `name`, `email`, `address`, `PHONE_NUM`)
				VALUES  (/*auto CID*/'tanvi','123','Tanvi','tanvi@rutgers','rpo way','999123');

INSERT INTO `reservation`(`CID`, `totalAmt`, `resDate`)
				VALUES(/*auto InvoiceNo*/ /*CID*/ 6, /*totalAmt*/ 121.12, NOW());
                    
INSERT INTO `reserves`(`invoiceNo`, `room_num`, `hotelID`, `noOfDays`, `inDate`, `outDate`)
				VALUES(/*get invoiceNO from reservation*/(SELECT MAX(invoiceNo) AS invNo FROM reservation), /*user input room numer*/101, /*hotelID query*/(SELECT h.hotelID FROM hotel AS h WHERE h.hotel_name = 'Hyatt'/*userinput*/ AND h.country = 'USA'/*userinput*/ AND h.state = 'NJ'/*userinput*/ AND h.city = 'New Brunswick'/*userinput*/), /*calc noOfDays*/(DATEDIFF('2017-12-21', '2017-12-18')), '2017-12-18','2017-12-21'/*these dates should be user input*/);

INSERT INTO `includes`(`invoiceNo`, `hotelID`,`bType`, `num_of_breakfasts`)
				VALUES(/*get invoiceNO from reservation*/(SELECT MAX(invoiceNo) AS invNo FROM reservation), /*hotelID query*/(SELECT h.hotelID FROM hotel AS h WHERE h.hotel_name = 'Hyatt'/*userinput*/ AND h.country = 'USA'/*userinput*/ AND h.state = 'NJ'/*userinput*/ AND h.city = 'New Brunswick'/*userinput*/), /*userinput bType*/'steak and eggs', /*userinput*/ 5);

INSERT INTO `contains`(`invoiceNo`, `hotelID`,`sType`, `num_of_services`)
				VALUES(/*get invoiceNO from reservation*/(SELECT MAX(invoiceNo) AS invNo FROM reservation), /*hotelID query*/(SELECT h.hotelID FROM hotel AS h WHERE h.hotel_name = 'Hyatt'/*userinput*/ AND h.country = 'USA'/*userinput*/ AND h.state = 'NJ'/*userinput*/ AND h.city = 'New Brunswick'/*userinput*/), /*userinput sType*/'spa', /*userinput*/ 6);