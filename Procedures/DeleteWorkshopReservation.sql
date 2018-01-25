CREATE PROC DeleteWorkshopReservation
	@WorkshopID INT,
	@TicketID INT
AS
	DELETE FROM dbo.WorkshopReservations WHERE WorkshopID = @WorkshopID AND TicketID = @TicketID
	