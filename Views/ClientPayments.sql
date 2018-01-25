CREATE VIEW ClientPayments AS
    SELECT o.OrderID, o.OrderDate, ConferenceID, CompanyName, Phone, dbo.ordercost(o.OrderID) AS 'HasToPay'
      --  (SELECT SUM(PaymentValue) FROM Payments AS p WHERE p.OrderID = oc.OrderID GROUP BY p.OrderID) AS AlreadyPaid
    FROM Orders AS o
    JOIN Clients AS c
        ON c.ClientID = o.ClientID
    JOIN Tickets AS t
        ON t.OrderID = o.OrderID
    LEFT JOIN CompanyClients AS cc
        ON cc.ClientID = c.CLientID
    LEFT JOIN CompanyList AS cl
        ON cl.CompanyID = cc.CompanyID
    GROUP BY o.OrderID, CompanyName, o.OrderDate, Phone, ConferenceID
