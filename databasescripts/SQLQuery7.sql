SELECT TOP (1000) [RingId]
      ,[Name]
      ,[Color]
      ,[Price]
      ,[ImageUrl]
  FROM [Jewllery].[dbo].[Rings]
  INSERT INTO Rings (Name, Color, Price, ImageUrl) VALUES
('Royal Sapphire Ring', 'Blue', 68000.00, 'ring4.jpg'),
('Timeless Platinum Band', 'Platinum', 85000.00, 'ring5.jpg'),
('Ruby Elegance Ring', 'Red', 72000.00, 'ring6.jpg'),
('Emerald Radiance Ring', 'Green', 55000.00, 'ring7.jpg'),
('Opulent Diamond Halo Ring', 'White Gold', 91000.00, 'ring8.jpg');
