CREATE VIEW dbo.OrderConferenceTickets
AS
    SELECT DISTINCT t.OrderID, t.TicketID, p.LastName, p.FirstName
    FROM Tickets AS t
    LEFT JOIN People AS p
    ON t.PersonID = p.PersonID
    WHERE t.OrderID IS NOT NULL
