# Outputs Invoice number, all Hotels, and number of rooms of each past reservation

SELECT DISTINCT reserves.invoiceNo, hotel.hotel_name, reserves.inDate, reserves.outDate, COUNT(reserves.room_num) AS numRooms
FROM reserves, reservation, hotel
WHERE reserves.invoiceNo = reservation.invoiceNo AND reserves.hotelID = hotel.hotelID
AND CID = '2'/*insert user CID here*/ AND reserves.outDate < NOW() AND reserves.inDate < NOW()
GROUP BY reserves.invoiceNo, hotel.hotel_name, reserves.inDate, reserves.outDate
ORDER BY reserves.inDate;
