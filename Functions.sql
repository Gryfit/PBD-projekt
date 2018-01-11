CREATE FUNCTION FUNC_DiscountedPrice
  (
    @ConferenceID int,
    @OrderDate datetime,
    @IsStudent bit
  )
  RETURNS decimal(10,2)
AS
BEGIN
  RETURN
    (
      SELECT BasePrice * (@IsStudent * StudentDiscount / 100) *
        (SELECT TOP 1 
         FROM ConferenceDiscounts
         WHERE ConferenceID = @ConferenceID AND 
               @OrderDate <= UntilDate
         ORDER BY UntilDate) / 100
    );
END
GO

CREATE FUNCTION FUNC_DiscountedPrice
  (
    @TicketID
  )
  RETURNS decimal(10,2)
AS
BEGIN
  RETURN
    (
      SELECT FUNC_DiscountedPrice(
           cd.ConferenceID, 
           o.OrderDate, 
           (SELECT COUNT (*) FROM Students as s WHERE s.PersonID = t.PersonID))  
      FROM Tickets AS t
      JOIN Orders AS o
           ON o.OrderID = t.OrderID
      JOIN ConferenceDays AS cd
           ON cd.ConferenceDayID = t.ConferenceDayID
      WHERE t.TicketID = @TicketID
    );
END
GO


