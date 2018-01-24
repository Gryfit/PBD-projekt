CREATE FUNCTION DeleteOrderRetrunMoney(
	@OrderID INT
	)
	RETURNS DECIMAL(10,2)
	
AS
	BEGIN
	DECLARE @ret DECIMAL(10,2)
	SET @ret = (SELECT SUM(paymentValue) FROM dbo.Payments WHERE OrderID = @OrderID)
	RETURN @ret
	END