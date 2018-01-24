CREATE TRIGGER PriceTrasholdDateCheck ON dbo.WorkshopReservations FOR INSERT AS 
BEGIN 
    DECLARE @TicketID AS int 
    SET @TicketID = (SELECT TicketID FROM inserted)
    DECLARE @WorkshopID AS int 
    SET @WorkshopID = (SELECT WorkshopID FROM inserted)
    
    DECLARE @vacancy AS int
    SET @vacancy = (
        SELECT w.Seats - COUNT(TicketID)
        FROM Workshops AS w
        JOIN WorkshopReservations AS wr
        ON wr.WorkshopID = w.WorkshopID
        WHERE wr.WorkshopID = @WorkshopID
        GROUP BY TicketID, w.Seats
        )
    IF @vacancy > 0
    BEGIN
       INSERT INTO WorkshopReservations (WorkshopID, TicketID)
       VALUES (@WorkshopID, @TicketID) 
    END 
    ELSE
    BEGIN
       RAISERROR ('There are no vacant seats at given workshop.',-1,-1)
    END 
END 

    © 2018 GitHub, Inc.
    Terms
