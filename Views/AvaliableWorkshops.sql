CREATE VIEW VIEW_AvaliableWorkshops
AS
  SELECT w.WorkshopID,
         w.ConferenceID,
         w.ConferenceDayID, w.Start, w.Duration, w.BasePrice
  FROM Workshops AS w
  JOIN WorkshopReservations AS wr
       ON w.WorkshopID = wr.WorkshopID
  GROUP BY w.WorkshopID,
         w.ConferenceID, w.Seats,
         w.ConferenceDayID, w.Start, w.Duration, w.BasePrice
  HAVING COUNT(w.WorkshopID) < w.Seats
