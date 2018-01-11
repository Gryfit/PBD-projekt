CREATE VIEW VIEW_WorkshopSeats
 AS
   SELECT w.WorkshopID,
          w.ConferenceID,
          w.ConferenceDayID,
          w.Seats AS 'TotalSeats',
          SUM(wr.WorkshopID) AS 'SeatsSold',
          w.Seats - SUM(wr.WorkshopID) AS 'SeatsLeft'
  FROM Workshops AS w
  JOIN WorkshopReservations AS wr
       ON w.WorkshopID = wr.WorkshopID
  GROUP BY w.WorkshopID, w.ConferenceID, w.ConferenceDayID, w.Seats
GO
