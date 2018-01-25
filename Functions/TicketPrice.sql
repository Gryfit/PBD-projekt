CREATE FUNCTION dbo.TicketPrice(@TicketID int) RETURNS decimal(10,2) AS
BEGIN
  RETURN
    (
      SELECT sum(c.BasePrice * (1 - dbo.ConferenceDiscount(t.ConferenceID, o.OrderDate) / 100) 
      * (1 - dbo.IsStudent(t.PersonID) * c.StudentDiscount / 100) * (1 - cd.Cancelled))
      FROM Tickets AS t
      JOIN Orders AS o
           ON o.OrderID = t.OrderID
      JOIN Conferences AS c
           ON c.ConferenceID = t.ConferenceID
      JOIN ConferenceDays AS cd
           ON cd.ConferenceID = t.ConferenceID 
      WHERE t.TicketID = @TicketID
      GROUP BY t.ConferenceID
    )
END
