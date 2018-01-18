CREATE VIEW dbo.OrderTickets
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
       
