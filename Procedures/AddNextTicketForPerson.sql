CREATE PROC AddNextTicketForPerson
	@OrderID INT,
	@PersonID INT,
	@ConferenceID INT,
	@ConferenceDayID INT
AS
 	IF NOT EXISTS (SELECT PersonID FROM People WHERE PersonID = @PersonID)
    	RAISERROR('You have to use AddFirstTicketForPerson first because there is no such PersonID in database!', -1, -1)
  	ELSE
	BEGIN
		DECLARE @FreeTicket int
		SET @FreeTicket = (SELECT Top 1 TicketID FROM Tickets 
			WHERE ConferenceID = @ConferenceID AND ConferenceDayID = @ConferenceDayID
			AND OrderID = @OrderID)
		IF @FreeTicket IS NOT NULL
		BEGIN
			UPDATE Tickets SET OrderID = @OrderID AND PersonID = @PersonID WHERE TicketID = @FreeTicket
		END
		ELSE
		BEGIN
			SET @FreeTicket = (SELECT Top 1 TicketID FROM Tickets 
				WHERE ConferenceID = @ConferenceID AND ConferenceDayID = @ConferenceDayID
				AND OrderID IS NULL)
			IF @FreeTicket NOT NULL
				UPDATE Tickets SET OrderID = @OrderID AND PersonID = @PersonID WHERE TicketID = @FreeTicket
			ELSE
			BEGIN
				INSERT INTO Tickets VALUES (@OrderID, @PersonID, @ConferenceID, @ConferenceDayID)
			END
	END
