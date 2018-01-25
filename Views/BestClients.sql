CREATE VIEW dbo.BestClients
AS
  SELECT ClientID, CompanyName, Email, Phone, 
  sum(TicketsOrdered) AS TicketsBought, 
  sum(studentTickets) AS StudentTicketsBought,
  ISNULL((SELECT sum(TicketsOrdered) 
    FROM dbo.OrderTickets AS ot2 
    WHERE ot.ClientID = ot2.ClientID AND DATEDIFF(month, ot2.OrderDate, GETDATE()) < 6 ),0) AS Last6Months
  FROM dbo.OrderTickets as ot
  GROUP BY ClientID, CompanyName, Email, Phone
