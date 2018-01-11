CREATE VIEW VIEW_WorkshopSeats
AS
  SELECT w.WorkshopID,
         w.ConferenceID,
         w.ConferenceDayID,
         w.Seats AS 'TotalSeats',
         wr.SeatsSold,
         w.Seats - wr.SeatsSold AS 'SeatsLeft'
  FROM Workshops AS w
  JOIN (SELECT WorkshopID, COUNT(WorkshopID) AS 'SeatsSold' 
        FROM Workshops GROUP BY WorkshopID
       ) AS wr
       ON w.WorkshopID = wr.WorkshopID
  GROUP BY w.WorkshopID, w.ConferenceID, w.ConferenceDayID, w.Seats, wr.SeatsSold
GO

CREATE VIEW VIEW_AvaliableWorkshops
AS
  SELECT w.WorkshopID,
         w.ConferenceID,
         w.ConferenceDayID
  FROM Workshops AS w
  JOIN WorkshopReservations AS wr
       ON w.WorkshopID = wr.WorkshopID
  GROUP BY w.WorkshopID, w.ConferenceID, w.ConferenceDayID, w.Seats
  HAVING SUM(w.WorkshopID) < w.Seats
GO

CREATE VIEW VIEW_OrderTickets
AS
  SELECT o.OrderID,
         OrderDate,
         Email,
         Phone,
         (SELECT COUNT (*) FROM t) AS 'TicketsOrdered',
         (SELECT COUNT (*) 
          FROM t JOIN People AS p 
               ON p.PersonID = t.PersonID
          JOIN Students AS s 
               ON s.PersonID = p.PersonID
         ) AS 'StudentTickets'
  FROM Orders AS o
  JOIN Tickets AS t
       ON t.OrderID = o.OrderID
  GROUP BY t.ConferenceDayID, o.OrderID, OrderDate, Email, Phone, 
GO
