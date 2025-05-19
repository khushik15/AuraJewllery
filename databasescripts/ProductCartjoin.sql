SELECT P.Name AS ProductName, C.Quantity, P.Price, 
       (C.Quantity * P.Price) AS Total 
FROM Cart C
INNER JOIN Products P ON C.ProductID = P.ProductID
WHERE C.UserID = 1; -- Replace '1' with a valid UserID
