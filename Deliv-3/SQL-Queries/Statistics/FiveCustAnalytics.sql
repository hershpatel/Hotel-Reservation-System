#query to output 5 best customers (in terms of money spent on reservations) 
#given check in and check out dates

SELECT r.CID, c.name, ROUND(SUM(r.totalAmt),2) AS totalSpent
FROM customer AS c, reservation AS r, reserves AS res
WHERE c.CID = r.CID AND r.invoiceNo = res.invoiceNo
AND (res.inDate >= '2017-4-08' /*insert user input date here*/ AND res.outDate <= '2019-4-10'/*insert user input date here*/)
GROUP BY r.CID, c.name
ORDER BY SUM(r.totalAmt) DESC
LIMIT 5
;