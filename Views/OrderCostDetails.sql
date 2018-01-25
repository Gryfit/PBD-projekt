ALTER VIEW OrderCostDetails 
AS
    SELECT o.OrderID, o.OrderDate, LastName + ' ' + FirstName AS 'name', CompanyName, dbo.IsStudent(t.PersonID) AS IsStudent,
    dbo.TicketPrice(t.TicketID) AS 'ConferencePrice', dbo.WorkshopPrice(t.TicketID) AS 'WorkshopPrice',
    dbo.TicketPrice(t.TicketID) + dbo.WorkshopPrice(t.TicketID) AS 'TotalPrice'
    FROM Tickets AS t
    JOIN Orders AS o
         ON o.OrderID = t.OrderID
    LEFT JOIN People AS p
    ON p.PersonID = t.PersonID
    LEFT JOIN CompanyList AS cl
    ON cl.CompanyID = p.CompanyID
