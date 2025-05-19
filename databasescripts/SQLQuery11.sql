CREATE TABLE Cart1 (
    CartId INT IDENTITY(1,1) PRIMARY KEY,
    ProductId INT NOT NULL,
    ProductType NVARCHAR(50) NOT NULL,  -- Category name (Ring, Chain, etc.)
    Name NVARCHAR(255) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Quantity INT DEFAULT 1,
    TotalPrice AS (Price * Quantity) PERSISTED
);
