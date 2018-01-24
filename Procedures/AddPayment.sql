CREATE PROC AddPayment
    @OrderID INT,
    @PaymentDate DATETIME,
    @PaymentValue DECIMAL(10,2),
    @BankAccount INT
AS
IF @PaymentDate IS NULL
BEGIN
    SET @PaymentDate = GETDATE()
END
INSERT dbo.Payments
(
    PaymentID,
    OrderID,
    PaymentDate,
    PaymentValue,
    BankAccount
)
VALUES
(   (SELECT COUNT(OrderID) FROM dbo.Payments WHERE OrderID=@OrderID) + 1,         -- PaymentID - int
    @OrderID,         -- OrderID - int
    @PaymentDate, -- PaymentDate - datetime
    @PaymentValue,      -- PaymentValue - decimal(10, 2)
    @BankAccount          -- BankAccount - int
    )
