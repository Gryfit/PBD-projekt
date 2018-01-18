CREATE FUNCTION dbo.WorkshopPrice(@TicketID) 
  RETURNS decimal(10,2) AS
BEGIN
  RETURN
    (
      SELECT SUM(w.BasePrice)
      FROM WorkshopReservations AS wr
      JOIN Workshops AS w
           ON wr.WorkshopID = w.WorkshopID
      WHERE wr.TicketID = @TicketID
    )
END
