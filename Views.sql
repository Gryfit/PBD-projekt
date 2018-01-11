CREATE VIEW VIEW_OrderTickets
AS
  SELECT o.OrderID, o.OrderDate,
         c.Email, c.Phone,
         (SELECT COUNT (*) FROM Tickets WHERE OrderID = o.OrderID) AS 'TicketsOrdered',
         (SELECT COUNT (*) 
          FROM Tickets AS t 
          JOIN Students AS s 
               ON s.PersonID = t.PersonID
         ) AS 'StudentTickets'
  FROM Orders AS o
  JOIN Clients AS c
       ON c.ClientID = o.ClientID
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

CREATE VIEW VIEW_AvaliableWorkshops
AS
  SELECT w.WorkshopID,
         w.ConferenceID,
         w.ConferenceDayID
  FROM Workshops AS w
  JOIN WorkshopReservations AS wr
       ON w.WorkshopID = wr.WorkshopID
  GROUP BY w.WorkshopID, w.ConferenceID, w.ConferenceDayID, w.Seats
  HAVING COUNT(w.WorkshopID) < w.Seats
GO


