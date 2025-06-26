/*
---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
In SQL,(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.

Task: You are a restaurant owner and you want to analyze a possible business expansion. 
It is assumed that at least one customer arrives every day.
Calculate the moving average of the amount the customer has paid over the last 7 days 
(including the current day and the previous 6). Round the result (average_amount) to two decimal places.
Return the results table sorted by the date of the visit (visited_on) in ascending order.
*/
WITH data_sorting AS(SELECT visited_on,
SUM(amount) OVER ( ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
ROUND(AVG(CONVERT(decimal, amount)) OVER ( ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS average_amount
FROM(
    SELECT visited_on, SUM(amount) AS amount
    FROM Customer 
    GROUP BY visited_on
) AS gc
)

SELECT visited_on, amount, average_amount
FROM data_sorting
ORDER BY visited_on OFFSET 6 ROWS