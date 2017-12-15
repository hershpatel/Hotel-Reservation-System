#query to output highest rated room type for each hotel given check in and check out dates

SELECT r.hotelID, r.room_type, ROUND(SUM(re.rating)/COUNT(r.room_num),3) AS Average
FROM myroom AS r, reserves AS res, review AS re, room_review AS rr
WHERE re.reviewID = rr.reviewID AND rr.room_num = r.room_num AND rr.hotelID = r.hotelID AND r.hotelID = 1 /*insert hotelID here*/
AND (res.inDate >= '2017-4-08' /*insert user input date here*/ AND res.outDate <= '2019-4-10'/*insert user input date here*/)
GROUP BY r.hotelID, r.room_type
ORDER BY SUM(re.rating)/COUNT(r.room_num) DESC
LIMIT 1
;