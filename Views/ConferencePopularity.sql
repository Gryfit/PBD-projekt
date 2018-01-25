CREATE VIEW dbo.ConferencePopularity
AS
  SELECT c.ConferenceID, c.StartDate, c.EndDate, (COUNT(c.ConferenceID) * 100 / c.Seats) AS 'PercentageSold',
         COUNT(c.ConferenceID) AS 'SeatsSold', c.Seats
  FROM Conferences AS c
  JOIN Tickets AS t
       ON t.ConferenceID = c.ConferenceID
  WHERE (t.orderID IS NOT NULL) AND c.Cancelled = 0
GROUP BY c.ConferenceID, Seats, c.StartDate, c.EndDate
