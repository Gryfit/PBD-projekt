CREATE FUNCTION dbo.TicketPrice(@TicketID int) RETURNS decimal(10,2) AS
BEGIN
  RETURN
    (
      SELECT c.BasePrice * dbo.ConferenceDiscount(t.ConferenceID, o.OrderDate) / 100 *
        dbo.IsStudent(t.PersonID) * (1 - c.StudentDiscount) / 100
      FROM Tickets AS t
      JOIN Orders AS o
           ON o.OrderID = t.OrderID
      JOIN Conferences AS c
           ON c.ConferenceID = t.ConferenceID
      WHERE t.TicketID = @TicketID
    )
END
