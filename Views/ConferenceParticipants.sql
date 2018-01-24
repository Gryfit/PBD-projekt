CREATE VIEW dbo.ConferenceParticipants
AS
  SELECT t.ConferenceID, p.PersonID, Lastname + ' ' + Firstname AS Name, 
    ISNULL(CompanyName, '') AS Company, dbo.IsStudent(p.personID) AS IsStudent 
  FROM People AS p 
  JOIN CompanyList AS cl
       ON p.CompanyID = cl.CompanyID
  JOIN Tickets AS t
       ON t.PersonID = p.PersonID
  JOIN ConferenceDays AS cd
       ON cd.ConferenceID = t.ConferenceID AND cd.ConferenceDayID = t.ConferenceDayID AND cd.Cancelled = 0
