SELECT TOP (1000) [RingId]
      ,[Name]
      ,[Color]
      ,[Price]
      ,[ImageUrl]
  FROM [Jewllery].[dbo].[Rings]
  DELETE FROM Rings 
WHERE RingId IN (4, 5, 6);
