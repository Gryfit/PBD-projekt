CREATE FUNCTION FUNC_DiscountedPrice
  (
    @ConferenceID int,
    @OrderDate datetime,
    @IsStudent bit
  )
  RETURNS money
AS
BEGIN
  RETURN
    (
      SELECT BasePrice * (@IsStudent * StudentDiscount / 100) *
        (SELECT TOP 1 
         FROM ConferenceDiscounts
         WHERE ConferenceID = @ConferenceID AND 
             @OrderDate <= UntilDate
         ORDER BY UntilDate)
    );
END
GO
