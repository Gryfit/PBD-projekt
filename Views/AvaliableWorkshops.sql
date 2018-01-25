CREATE VIEW VIEW_AvaliableWorkshops
AS
  SELECT w.WorkshopID,
         w.ConferenceID,
         w.ConferenceDayID, w.Start, w.Duration, w.BasePrice
  FROM Workshops AS w
  JOIN WorkshopReservations AS wr
       ON w.WorkshopID = wr.WorkshopID
  JOIN ConferenceDays AS cd
       ON cd.ConferenceDayID = w.ConferenceDayID AND cd.ConferenceID = w.ConferenceID AND cd.Cancelled = 0
  JOIN ConferenceDays AS c
       ON c.ConferenceID = w.ConferenceID AND c.Cancelled = 0
  WHERE w.Cancelled = 0
  GROUP BY w.WorkshopID,
         w.ConferenceID, w.Seats,
         w.ConferenceDayID, w.Start, w.Duration, w.BasePrice
  HAVING COUNT(w.WorkshopID) < w.Seats
