SELECT TOP (1000) [CartId]
      ,[UserId]
      ,[RingId]
      ,[Quantity]
      ,[BangleId]
      ,[ID]
      ,[Name]
  FROM [Jewllery].[dbo].[Cart]
  ALTER TABLE Cart DROP COLUMN RingId;
ALTER TABLE Cart DROP COLUMN BangleId;