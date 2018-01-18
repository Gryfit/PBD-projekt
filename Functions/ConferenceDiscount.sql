CREATE FUNCTION dbo.ConferenceDiscount(@ConferenceID int, @OrderDate datetime) 
  RETURNS decimal(10,2) AS
BEGIN
  RETURN
    (
         SELECT TOP 1 Discount
         FROM ConferenceDiscounts
         WHERE ConferenceID = @ConferenceID AND @OrderDate <= UntilDate
         ORDER BY UntilDate
    )
END
