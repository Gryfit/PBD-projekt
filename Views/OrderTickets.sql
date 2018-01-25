CREATE VIEW dbo.OrderTickets
AS
  SELECT c.ClientID, CompanyName,
         c.Email, c.Phone,
         (SELECT COUNT (*) FROM Tickets WHERE OrderID = o.OrderID) AS 'TicketsOrdered',
         (SELECT COUNT (*) 
          FROM Tickets AS t 
          JOIN Students AS s 
               ON s.PersonID = t.PersonID
          WHERE t.OrderID = o.OrderID
         ) AS 'StudentTickets'
  FROM Orders AS o
  JOIN Clients AS c
       ON c.ClientID = o.ClientID
  LEFT JOIN CompanyClients AS cc
      ON cc.ClientID = c.ClientID
  LEFT JOIN CompanyList AS cl
      ON cc.CompanyID = cl.CompanyID
       
