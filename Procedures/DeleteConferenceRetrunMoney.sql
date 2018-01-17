CREATE FUNCTION DeleteConferenceRetrunMoney(
	@ConferenceID INT
)
RETURNS @retTable TABLE (
	BankAccount INT,
	RetrunMoney DECIMAL(10,2)
)
AS
BEGIN
	INSERT INTO @retTable
	SELECT BankAccount, SUM(PaymentValue) FROM dbo.Payments WHERE OrderID IN (
		SELECT DISTINCT OrderID FROM dbo.Tickets WHERE ConferenceID =@ConferenceID 
	) GROUP BY BankAccount	
	RETURN
END