CREATE PROC AddPayment
	@OrderID INT,
	@PaymentValue DECIMAL(10,2),
	@BankAccount INT
AS
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
    GETDATE(), -- PaymentDate - datetime
    @PaymentValue,      -- PaymentValue - decimal(10, 2)
    @BankAccount          -- BankAccount - int
    )