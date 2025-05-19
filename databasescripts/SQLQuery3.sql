SELECT TOP (1000) [UserId]
      ,[Name]
      ,[Email]
      ,[PasswordHash]
      ,[Phone]
      ,[Address]
  FROM [Jewllery].[dbo].[Users]
  SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users';
