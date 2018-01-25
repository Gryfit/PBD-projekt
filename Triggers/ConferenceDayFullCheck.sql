CREATE TRIGGER ConferenceDayFullCheck ON dbo.Tickets AFTER INSERT AS 
BEGIN 
    DECLARE @ConferenceID AS int 
    SET @ConferenceID = (SELECT ConferenceID FROM inserted)
    DECLARE @ConferenceDayID AS int 
    SET @ConferenceDayID = (SELECT ConferenceDayID FROM inserted)
    
    DECLARE @vacancy AS int
    SET @vacancy = (
        SELECT count(PersonID) - Seats
        FROM Tickets AS t
        JOIN Conferences AS c
        ON t.ConferenceID = c.ConferenceID
        WHERE (OrderID IS NOT NULL) AND ConferenceDayID = @ConferenceDayID
        GROUP BY ConferenceDayID, Seats
        )
    IF @vacancy <= 0
    BEGIN
       RAISERROR ('There are no vacant seats at given conferenceday.',-1,-1)
       ROLLBACK TRANSACTION
    END 
    ELSE
    BEGIN
        INSERT INTO Tickets VALUES (
            (SELECT OrderID FROM inserted),
            (SELECT PersonID FROM inserted),
            (SELECT ConferenceID FROM inserted),
            (SELECT ConferenceDayID FROM inserted)
            )
    END
END 
