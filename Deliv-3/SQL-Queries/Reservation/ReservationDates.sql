#query to output hotel and room info given check in and check out dates


SELECT DISTINCT r.hotelID, r.room_num, h.hotel_name, h.country, h.state, h.city, h.address, h.zipcode, r.price, r.capacity, r.floor_no, r.description, r.room_type, ph.phone_no, IFNULL(rd.discount, 'No Discount in period') AS DiscountPct
FROM hotel AS h
LEFT JOIN myroom AS r
	ON h.hotelID = r.hotelID
LEFT JOIN reserves AS re
	ON r.hotelID = re.hotelID
		AND r.room_num = re.room_num
        AND (re.inDate <= '2017-4-08' /*insert user input date here*/ OR re.outDate >= '2019-4-10'/*insert user input date here*/)
LEFT JOIN room_discount AS rd
	ON r.hotelID = rd.hotelID
		AND r.room_num = rd.room_no
		AND (rd.sdate >= '2017-4-08' /*insert user input date here*/ AND rd.edate <= '2019-4-10'/*insert user input date here*/)
INNER JOIN HotelPhoneNumbers AS ph
	ON h.hotelID = ph.hotelID
WHERE re.invoiceNo IS NULL
AND h.country = 'USA' /*insert user input date here*/ AND h.state = 'NJ' /*insert user input date here*/
ORDER BY r.hotelID, r.room_num
;
 