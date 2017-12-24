#query to output highest rated breakfast type for each hotel given check in and check out dates

SELECT r.hotelID, br.bType, SUM(re.rating)/COUNT(b.bType) AS Average
FROM myroom AS r, breakfast AS b, review AS re, breakfast_review AS br, reserves AS res
WHERE re.reviewID = br.reviewID AND br.btype = b.bType AND br.hotelID = r.hotelID AND r.hotelID = 1 /*insert hotelID here*/
AND (res.inDate >= '2017-4-08' /*insert user input date here*/ AND res.outDate <= '2019-4-10'/*insert user input date here*/)
GROUP BY r.hotelID, br.btype
ORDER BY SUM(re.rating)/COUNT(b.btype) DESC
LIMIT 1
;