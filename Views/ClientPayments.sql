ALTER VIEW ClientPayments AS
    SELECT oc.OrderID, o.OrderDate, (SELECT Top 1 PaymentDate FROM Payments AS p WHERE p.OrderID = oc.OrderID ORDER BY PaymentDate DESC) AS 'LastPayment',
        ConferenceID, CompanyName, Phone, SUM(TotalPrice) AS HasToPay, 
        (SELECT SUM(PaymentValue) FROM Payments AS p WHERE p.OrderID = oc.OrderID GROUP BY p.OrderID) AS AlreadyPaid
    FROM OrderCostDetails AS oc
    JOIN Orders AS o
        ON o.OrderID = oc.OrderID
    JOIN Clients AS c
        ON c.ClientID = o.ClientID
    JOIN Tickets AS t
        ON t.OrderID = o.OrderID
    GROUP BY oc.OrderID, CompanyName, TotalPrice, o.OrderDate, Phone, ConferenceID
