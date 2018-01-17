CREATE PROC DeleteConference
	@ConferenceID INT
AS
	DELETE FROM dbo.ConferenceDiscounts WHERE ConferenceID = @ConferenceID
	DELETE FROM dbo.Students WHERE PersonID IN (
		SELECT DISTINCT PersonID FROM dbo.Tickets WHERE ConferenceID = @ConferenceID 
	)
	DELETE FROM dbo.Payments WHERE OrderID IN (
		SELECT DISTINCT OrderID FROM dbo.Tickets WHERE ConferenceID = @ConferenceID 
	)
	DELETE FROM dbo.WorkshopReservations WHERE TicketID IN (
		SELECT DISTINCT TicketID FROM dbo.Tickets WHERE ConferenceID = @ConferenceID
	)
	DELETE FROM dbo.Workshops WHERE ConferenceID = @ConferenceID


	DECLARE @TmpPeople TABLE (
	PersonID INT
	)
	INSERT INTO @TmpPeople
	SELECT DISTINCT PersonID FROM dbo.Tickets WHERE ConferenceID =@ConferenceID
	DECLARE @TmpOrders TABLE (
	OrderID INT
	)
	INSERT INTO @TmpOrders
	SELECT DISTINCT OrderID FROM dbo.Tickets WHERE ConferenceID =@ConferenceID

	 
	DELETE FROM dbo.Tickets WHERE ConferenceID = @ConferenceID
	DELETE FROM dbo.People WHERE PersonID IN (SELECT * FROM @TmpPeople)
	DELETE FROM dbo.Orders WHERE OrderID IN (SELECT * FROM @TmpOrders)
	DELETE FROM dbo.ConferenceDays WHERE ConferenceID = @ConferenceID
	DELETE FROM dbo.Conferences WHERE ConferenceID = @ConferenceID


	 