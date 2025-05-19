CREATE FUNCTION dbo.SecurityPredicate(@user_id INT)
RETURNS TABLE  
WITH SCHEMABINDING  
AS  
RETURN  
(  
    SELECT 1 AS access  
    WHERE @user_id IN (1, 2, 3, 11)  
);
