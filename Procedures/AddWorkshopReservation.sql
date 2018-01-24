CREATE PROC dbo.AddWorkshopReservation
@WorkshopID INT,
@TicketID INT
AS
INSERT dbo.WorkshopReservations
(
    WorkshopID,
    TicketID
)
VALUES
(   @WorkshopID, -- WorkshopID - int
    @TicketID  -- TicketID - int
    )