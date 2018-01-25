CREATE PROC DeleteOrder
	@OrderID INT
AS
	DELETE FROM dbo.Students WHERE PersonID IN (SELECT PersonID FROM dbo.Tickets WHERE OrderID = @OrderID)
	DELETE FROM dbo.WorkshopReservations WHERE TicketID IN (SELECT TicketID FROM dbo.Tickets WHERE OrderID = @OrderID)

	(SELECT PersonID INTO TmpPeople FROM dbo.Tickets WHERE OrderID = @OrderID)

	UPDATE dbo.Tickets SET OrderID = NULL, PersonID = NULL WHERE OrderID = @OrderID
	DELETE FROM dbo.Payments WHERE OrderID = @OrderID

	DELETE FROM dbo.People WHERE PersonID IN (SELECT * FROM TmpPeople)
	DROP TABLE TmpPeople
