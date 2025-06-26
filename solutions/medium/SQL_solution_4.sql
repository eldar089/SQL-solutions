/*Tables
Product(maker, model(PK), type)
PC(code, model(FK), speed, ram, hd, cd, price)
Laptop(code, model(FK), speed, ram, hd, price, screen)
Printer(code, model(FK), color, type, price)

Task:
For each manufacturer that has models in at least one of the PC, Laptop, or Printer tables, 
determine the maximum price of its products.
If there is at least one NULL value among the prices of this manufacturer, the output for this manufacturer 
should be NULL. Otherwise, you can print the maximum price.*/

WITH group_model AS(
SELECT model, price
FROM PC

UNION

SELECT model, price
FROM Laptop

UNION

SELECT model, price
FROM Printer),
Sorting_maker AS(
SELECT p.maker, gm.model, gm.price
FROM group_model gm
JOIN Product p on p.model = gm.model
)
SELECT DISTINCT maker,
CASE 
    WHEN EXISTS(
SELECT * FROM Sorting_maker sm2 WHERE price IS NULL AND sm1.maker = sm2.maker)
 THEN NULL ELSE MAX(price) END AS price 
FROM Sorting_maker sm1
GROUP BY maker