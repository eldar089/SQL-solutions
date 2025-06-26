/*Column Name    | Type    |
+----------------+---------+
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+
(requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
This table contains the ID of the user who sent the request, the ID of the user who received 
the request, and the date when the request was accepted.

Task: Find the person with the most friends and output their name (or ID) along with the number of friends.
It is guaranteed that exactly one person has the maximum number of friends in the test data.
*/

WITH accepter AS(
    SELECT DISTINCT accepter_id, 
	count(accepter_id) OVER (partition by accepter_id ORDER BY accepter_id) AS countAccepter
FROM RequestAccepted),
requester As(
	SELECT DISTINCT requester_id, 
	count(requester_id) OVER (partition by requester_id ORDER BY requester_id) AS countRequester
	FROM RequestAccepted)

SELECT TOP(1) 
CASE 
	WHEN requester_id IS NULL THEN accepter_id ELSE requester_id END AS id, num
FROM(
	SELECT r.requester_id, a.accepter_id, (ISNULL(a.countAccepter,0) + ISNULL(r.countRequester,0)) AS num
	FROM accepter a
	FULL JOIN requester r ON a.accepter_id = r.requester_id
) AS result
ORDER BY num DESC