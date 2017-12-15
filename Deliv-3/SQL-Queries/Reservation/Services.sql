#query to output service options given hotelID

SELECT h.hotelID, S.stype, S.sCost
FROM hotel AS h, services AS S
WHERE h.hotelID = S.hotelID AND (h.hotelID = 6 /*insert user input hotelID here*/)
;
