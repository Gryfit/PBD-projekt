CREATE VIEW VIEW_WorkshopPopularity
AS
  SELECT wr.WorkshopID, (COUNT(wr.WorkshopID) * 100 / w.Seats) AS 'PercentSold',
         COUNT(wr.WorkshopID) AS 'SeatsSold', w.Seats, w.Start, w.Duration
  FROM WorkshopReservations AS wr
  JOIN Tickets AS t
       ON t.TicketID = wr.WorkshopID
  JOIN Workshops AS w
       ON wr.WorkshopID = w.WorkshopID
  WHERE t.OrderID != NULL
  GROUP BY wr.WorkshopID, w.Seats
