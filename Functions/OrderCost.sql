CREATE FUNCTION OrderCost(@OrderID int) 
RETURNS decimal(10,2) AS
BEGIN
RETURN (
    ISNULL((SELECT TOP 1 SUM(dbo.TicketPrice (t.TicketID) + dbo.WorkshopPrice(t.TicketID))
    FROM Tickets AS t
    WHERE t.OrderID = @OrderID
    GROUP BY OrderID, TicketID), 0)
    )
END
