SELECT TOP (1000) [CartId]
      ,[UserId]
      ,[RingId]
      ,[Quantity]
      ,[BangleId]
      ,[ID]
      ,[Name]
  FROM [Jewllery].[dbo].[Cart]
  ALTER TABLE Cart 
ADD ProductId INT NOT NULL, 
    ProductType NVARCHAR(50) NOT NULL;

-- Remove old individual product columns
ALTER TABLE Cart DROP COLUMN RingId;
ALTER TABLE Cart DROP COLUMN BangleId;
