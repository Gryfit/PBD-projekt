CREATE TRIGGER WorkshopOverlapCheck ON dbo.WorkshopReservations INSTEAD OF INSERT AS 
BEGIN 
    DECLARE @TicketID AS int 
    SET @TicketID = (SELECT TicketID FROM inserted)
    DECLARE @WorkshopID AS int 
    SET @WorkshopID = (SELECT WorkshopID FROM inserted)
    DECLARE @StartTime AS datetime
    SET @StartTime = (SELECT dbo.Workshops.Start FROM dbo.Workshops WHERE WorkshopID = @WorkshopID)
    DECLARE @EndTime AS datetime
    SET @EndTime = (SELECT Duration FROM dbo.Workshops WHERE WorkshopID = @WorkshopID)

    DECLARE @impossible AS int
    SET @impossible = (
      SELECT COUNT (*)
      FROM Workshops AS w
      JOIN WorkshopReservations AS wr
      ON wr.WorkshopID = w.WorkshopID AND w.Cancelled != 1
      WHERE wr.TicketID = @TicketID AND (
        (@StartTime BETWEEN w.Start AND w.Duration) OR
        (@EndTime BETWEEN w.Start AND w.Duration))
    )

    IF @impossible > 0
    BEGIN
      RAISERROR ('The participant has reserved another Workshop at the time',-1,-1)
      ROLLBACK TRANSACTION
    END
    ELSE
    BEGIN 
      INSERT INTO WorkshopReservations (@WorkshopID, @TicketID)
END 
