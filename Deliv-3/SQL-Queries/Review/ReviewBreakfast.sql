#Then user enters invoice number, and chooses type of review
#Lists types of rooms you've stayed at, or type of breakfast, type of services

SELECT DISTINCT reserves.hotelID, hotel.hotel_name, reserves.invoiceNo, reserves.inDate, reserves.outDate, includes.bType, breakfast.bPrice, breakfast.description
FROM reserves, includes, reservation, breakfast, hotel
WHERE reserves.hotelID = hotel.hotelID AND reserves.hotelID = includes.hotelID AND reserves.invoiceNo = reservation.invoiceNo 
AND includes.invoiceNo = reserves.invoiceNo AND breakfast.bType = includes.bType AND breakfast.hotelID = reserves.hotelID
AND reserves.invoiceNo = '1'/*insert user Invoice Number here*/;