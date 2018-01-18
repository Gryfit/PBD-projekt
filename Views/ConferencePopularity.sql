CREATE VIEW dbo.ConferencePopularity
AS
  SELECT c.ConferenceID, c.StartDate, c.EndDate, (COUNT(c.ConferenceID) / c.Seats * 100) AS 'PercentSold',
         COUNT(c.ConferenceID) AS 'SeatsSold', c.Seats
  FROM Conferences AS c
  JOIN Tickets AS t
       ON t.ConferenceID = c.ConferenceID
  WHERE t.OrderID != NULL
  GROUP BY c.ConferenceID, Seats, c.StartDate, c.EndDate
