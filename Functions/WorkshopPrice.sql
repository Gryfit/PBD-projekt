CREATE FUNCTION dbo.WorkshopPrice(@TicketID int) 
  RETURNS decimal(10,2) AS
BEGIN
  RETURN
    (
      SELECT ISNULL(SUM(w.BasePrice), 0) * (1 - w.Cancelled)
      FROM WorkshopReservations AS wr
      JOIN Workshops AS w
           ON wr.WorkshopID = w.WorkshopID
      WHERE wr.TicketID = @TicketID
    )
END
