CREATE FUNCTION dbo.FUNC_ConferenceDiscount(@ConferenceID int, @OrderDate datetime) 
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

CREATE FUNCTION dbo.FUNC_IsStudent(@PersonID int) 
  RETURNS bit AS
BEGIN
  RETURN( CASE
            WHEN EXISTS(SELECT 1 FROM Students WHERE PersonID = @PersonID) 
            THEN 1
            ELSE 0
          END
      )
END

CREATE FUNCTION dbo.FUNC_TicketPrice(@TicketID int) 
  RETURNS decimal(10,2) AS
BEGIN
  RETURN
    (
      SELECT c.BasePrice * dbo.FUNC_ConferenceDiscount(t.ConferenceID, o.OrderDate) / 100 *
        dbo.FUNC_IsStudent(t.PersonID) * (1 - StudentDiscount) / 100
      FROM Tickets AS t
      JOIN Orders AS o
           ON o.OrderID = t.OrderID
      JOIN Conferences AS c
           ON c.ConferenceID = t.ConferenceID
      WHERE t.TicketID = @TicketID
    )
END

CREATE FUNCTION dbo.FUNC_WorkshopsPrice(@TicketID) 
  RETURNS decimal(10,2) AS
BEGIN
  RETURN
    (
      SELECT SUM(w.BasePrice)
      FROM WorkshopReservations AS wr
      JOIN Workshops AS w
           ON wr.WorkshopID = w.WorkshopID
      WHERE wr.TicketID = @TicketID
    ) + FUNC_TicketPrice(@TicketID);
END

CREATE FUNCTION dbo.FUNC_ConferenceParticipants(@ConferenceID) 
  RETURNS TABLE AS
BEGIN
  RETURN
    (
      SELECT Lastname + ' ' + Firstname AS Name, ISNULL(CompanyName, '')
      FROM People AS p 
      JOIN CompanyList AS cl
           ON p.CompanyID = cl.CompanyID
      JOIN Tickets AS t
           ON t.PersonID = p.PersonID
      WHERE t.ConferenceID = @ConferenceID
    )
END

CREATE FUNCTION dbo.FUNC_WorkshopParticipants(@WorkshopID) 
  RETURNS TABLE AS
BEGIN
  RETURN
    (
      SELECT Lastname + ' ' + Firstname AS Name, ISNULL(CompanyName, '')
      FROM People AS p 
      JOIN CompanyList AS cl
           ON p.CompanyID = cl.CompanyID
      JOIN Tickets AS t
           ON t.PersonID = p.PersonID
      JOIN WorkshopReservations AS wr
           ON wr.TicketID = t.TicketID
      WHERE wr.WorkshopID = @WorkshopID
    )
END


CREATE FUNCTION dbo.FUNC_ConferenceDayParticipants(@ConferenceID, @Day datetime) 
  RETURNS TABLE AS
BEGIN
  RETURN
    (
      SELECT Lastname + ' ' + Firstname AS Name, ISNULL(CompanyName, '')
      FROM People AS p 
      JOIN CompanyList AS cl
           ON p.CompanyID = cl.CompanyID
      JOIN Tickets AS t
           ON t.PersonID = p.PersonID
      JOIN ConferenceDays AS cd
           ON cd.ConferenceID = t.ConferenceID
      WHERE t.ConferenceID = @ConferenceID AND cd.Day = @Day 
    )
END
