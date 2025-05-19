SELECT TOP (1000) [CartID]
      ,[UserId]
      ,[ProductID]
      ,[Quantity]
      ,[AddedAt]
  FROM [Jewllery].[dbo].[Cart]
  ALTER TABLE [Jewllery].[dbo].[Cart]  
ADD CONSTRAINT FK_Cart_User FOREIGN KEY (UserId) REFERENCES [Jewllery].[dbo].[Users](UserID),  
    CONSTRAINT FK_Cart_Product FOREIGN KEY (ProductID) REFERENCES [Jewllery].[dbo].[Products](ProductID);
