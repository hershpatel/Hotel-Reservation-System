#revised query to output highest rated breakfast type for all hotels given check in and check out dates

SELECT br.bType, ROUND(SUM(re.rating)/COUNT(b.bType),3) AS Average
FROM breakfast AS b, review AS re, breakfast_review AS br, reserves AS res
WHERE re.reviewID = br.reviewID AND br.btype = b.bType
AND (res.inDate >= '2017-4-08' /*insert user input date here*/ AND res.outDate <= '2019-4-10'/*insert user input date here*/)
GROUP BY br.btype
ORDER BY SUM(re.rating)/COUNT(b.btype) DESC
LIMIT 1
;