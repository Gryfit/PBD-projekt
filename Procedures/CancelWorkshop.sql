CREATE PROC CancelWorkshop
	@WorkshopID INT
AS
	BEGIN
	UPDATE Workshops SET Cancelled = 1 WHERE WorkshopID = @WorkshopID
	END