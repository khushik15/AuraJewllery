CREATE TABLE Cart (
    CartID INT PRIMARY KEY IDENTITY(1,1), -- Unique identifier for each cart entry
    UserId INT NOT NULL, -- Links the cart entry to the user
    ProductID INT NOT NULL, -- Links the cart entry to the product
    Quantity INT CHECK (Quantity > 0), -- Stores the quantity of the product
    AddedAt DATETIME DEFAULT GETDATE(), -- Timestamp of when the item was added

    -- Foreign key constraints
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
