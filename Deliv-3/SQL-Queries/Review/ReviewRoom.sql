#Then user enters invoice number, and chooses type of review
#Lists types of rooms you've stayed at, or type of breakfast, type of services

SELECT DISTINCT reserves.hotelID, hotel.hotel_name, reserves.invoiceNo, reserves.inDate, reserves.outDate, myroom.room_num, myroom.room_type
FROM reserves, review, reservation, myroom, hotel
WHERE reserves.hotelID = hotel.hotelID AND reserves.hotelID = myroom.hotelID AND reservation.CID = review.CID AND reserves.invoiceNo = reservation.invoiceNo
AND reserves.room_num = myroom.room_num
AND reserves.invoiceNo = '1'/*insert user Invoice Number here*/
AND review.review_type = 'Room';