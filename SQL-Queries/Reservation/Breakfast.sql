#query to output breakfast options given hotelID

SELECT h.hotelID, B.btype, B.description, B.bprice
FROM hotel AS h, breakfast AS B
WHERE h.hotelID = B.hotelID AND (h.hotelID = 1 /*insert user input hotelID here*/)
;
