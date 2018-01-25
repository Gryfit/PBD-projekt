ALTER FUNCTION dbo.TicketPrice(@TicketID int) RETURNS decimal(10,2) AS
BEGIN
  RETURN
    (
      SELECT top 1 c.BasePrice * (100 - dbo.ConferenceDiscount(t.ConferenceID, o.OrderDate)) 
      * (100 - dbo.IsStudent(t.PersonID) * c.StudentDiscount) * (1 - cd.Cancelled) / 10000
      FROM Tickets AS t
      JOIN Orders AS o
           ON o.OrderID = t.OrderID
      JOIN Conferences AS c
           ON c.ConferenceID = t.ConferenceID
      JOIN ConferenceDays AS cd
           ON cd.ConferenceID = t.ConferenceID 
      WHERE t.TicketID = @TicketID
    )
END
