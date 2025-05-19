SELECT TOP (1000) [CartId]
      ,[ProductId]
      ,[ProductType]
      ,[Name]
      ,[Price]
      ,[Quantity]
      ,[TotalPrice]
  FROM [Jewllery].[dbo].[Cart1]
   
   USE Jewllery; -- Make sure you're using the correct database
GO

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Cart1';


USE Jewllery; 
GO

SELECT * FROM dbo.Cart1; 

ALTER TABLE dbo.Cart1 ADD TotalPrice AS (Price * Quantity) PERSISTED;
ALTER TABLE dbo.Cart1 DROP COLUMN TotalPrice;

