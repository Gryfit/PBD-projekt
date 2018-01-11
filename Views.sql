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

CREATE VIEW VIEW_ConferencePopularity
AS
  SELECT c.ConferenceID, COUNT(c.ConferenceID) AS 'SeatsReserved', 
         c.Seats - COUNT(c.ConferenceID) AS 'SeatsLeft', c.Seats
  FROM Conferences AS c
  JOIN Tickets AS t
       ON t.ConferenceID = c.ConferenceID
  WHERE t.OrderID != NULL
  GROUP BY c.ConferenceID, Seats
GO

CREATE VIEW VIEW_ConferencePopularity
AS
  SELECT c.ConferenceID, (COUNT(c.ConferenceID) / c.Seats * 100) AS 'PercentSold',
         COUNT(c.ConferenceID) AS 'SeatsSold', c.Seats
  FROM Conferences AS c
  JOIN Tickets AS t
       ON t.ConferenceID = c.ConferenceID
  WHERE t.OrderID != NULL
  GROUP BY c.ConferenceID, Seats
GO

CREATE VIEW VIEW_WorkshopPopularity
AS
  SELECT wr.WorkshopID, (COUNT(wr.WorkshopID) * 100 / w.Seats) AS 'PercentSold',
         COUNT(wr.WorkshopID) AS 'SeatsSold', w.Seats
  FROM WorkshopReservations AS wr
  JOIN Tickets AS t
       ON t.TicketID = wr.WorkshopID
  JOIN Workshops AS w
       ON wr.WorkshopID = w.WorkshopID
  WHERE t.OrderID != NULL
  GROUP BY wr.WorkshopID, w.Seats
GO
