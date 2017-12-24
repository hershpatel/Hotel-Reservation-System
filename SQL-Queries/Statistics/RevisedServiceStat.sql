#revised query to output highest rated service type for all hotels given check in and check out dates

SELECT s.sType, ROUND(SUM(re.rating)/COUNT(sr.sType),3) AS Average
FROM services AS s, review AS re, service_review AS sr, reserves AS res
WHERE re.reviewID = sr.reviewID AND sr.sType = s.sType
AND (res.inDate >= '2017-4-08' /*insert user input date here*/ AND res.outDate <= '2019-4-10'/*insert user input date here*/)
GROUP BY s.sType
ORDER BY SUM(re.rating)/COUNT(sr.sType) DESC
LIMIT 1
;