#Then user enters invoice number, and chooses type of review
#Lists types of rooms you've stayed at, or type of breakfast, type of services

SELECT DISTINCT reserves.hotelID, hotel.hotel_name, reserves.invoiceNo, reserves.inDate, reserves.outDate, `contains`.sType, services.sCost
FROM reserves, `contains`, review, reservation, services, hotel
WHERE reserves.hotelID = hotel.hotelID AND reserves.hotelID = `contains`.hotelID AND reservation.CID = review.CID AND reserves.invoiceNo = reservation.invoiceNo
AND `contains`.invoiceNo = reserves.invoiceNo AND services.sType = `contains`.sType AND services.hotelID = reserves.hotelID 
AND reserves.invoiceNo = '1'/*insert user Invoice Number here*/
AND review.review_type = 'Service';