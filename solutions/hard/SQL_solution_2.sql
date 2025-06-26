/*Tables
Product(maker, model(PK), type)
PC(code, model(FK), speed, ram, hd, cd, price)
Laptop(code, model(FK), speed, ram, hd, price, screen)
Printer(code, model(FK), color, type, price)

Task: For each manufacturer (maker) and each type of product (type) from the Product table, 
calculate the percentage of the number of models of this type from this manufacturer to the total number 
of models from this manufacturer. Print the result to two decimal places.
*/

WITH AllType AS (SELECT 'PC' AS type
UNION
SELECT 'Laptop' 
UNION 
SELECT 'Printer'),
AllMaker AS(
SELECT maker
FROM Product
GROUP BY maker),
GroupMT AS(SELECT maker, type
FROM AllMaker am
CROSS JOIN AllType at),
GroupAll AS(
SELECT g.maker, g.type, p.model 
FROM GroupMT g
LEFT JOIN Product p ON g.maker = p.maker AND g.type = p.type)

SELECT 
  ga1.maker, 
  ga1.type, 
  CAST(
    ROUND(
      (CAST(COUNT(ga1.model) AS decimal(10,2)) /
       CAST(
         (SELECT COUNT(ga2.model) FROM GroupAll ga2 WHERE ga1.maker = ga2.maker) 
         AS decimal(10,2))
      ) * 100, 2) AS decimal(10,2)
  ) AS isModel
FROM GroupAll ga1
GROUP BY ga1.maker, ga1.type;





