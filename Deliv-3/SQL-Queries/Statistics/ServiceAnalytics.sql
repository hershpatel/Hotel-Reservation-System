#query to output highest rated service type for each hotel given check in and check out dates

SELECT r.hotelID, s.sType, SUM(re.rating)/COUNT(sr.sType) AS Average
FROM myroom AS r, services AS s, review AS re, service_review AS sr, reserves AS res
WHERE re.reviewID = sr.reviewID AND sr.sType = s.sType AND sr.hotelID = r.hotelID AND r.hotelID = 1 /*insert hotelID here*/
AND (res.inDate >= '2017-4-08' /*insert user input date here*/ AND res.outDate <= '2019-4-10'/*insert user input date here*/)
GROUP BY r.hotelID, s.sType
ORDER BY SUM(re.rating)/COUNT(sr.sType) DESC
LIMIT 1
;