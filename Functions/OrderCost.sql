CREATE FUNCTION OrderCost(@OrderID int) 
AS
    SELECT SUM(TicketPrice (t.TicketID) + WorkshopPrice(t.TicketID))
    FROM Tickets AS t
    GROUP BY OrderID, TicketID
