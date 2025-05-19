SELECT TOP (1000) [CartId]
      ,[ProductId]
      ,[ProductType]
      ,[Name]
      ,[Price]
      ,[Quantity]
  FROM [Jewllery].[dbo].[Cart1]
  ALTER TABLE dbo.Cart1 ADD TotalPrice AS (Price * Quantity) PERSISTED;
  SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Cart1';
  SELECT name FROM sys.databases;
