CREATE PROC AddOrder
	@ClientID INT,
	@PersonID INT,
	@ConferenceID INT,
	@ConferenceDayID INT,
	@NumOfTickets INT
AS
	INSERT dbo.Orders
	(
	    ClientID,
	    OrderDate
	)
	VALUES
	(   @ClientID,        -- ClientID - int
	    GETDATE() -- OrderDate - datetime
	    )
	DECLARE 
	@i INT
    SET @i =0
	WHILE
	@i<@NumOfTickets
	BEGIN
		IF @PersonID IS NOT NULL
			UPDATE dbo.Tickets
			SET dbo.Tickets.OrderID = (SELECT TOP 1 OrderID FROM dbo.Orders ORDER BY OrderID DESC),
			dbo.Tickets.PersonID = @PersonID
			WHERE dbo.Tickets.ConferenceID = @ConferenceID AND dbo.Tickets.ConferenceDayID = @ConferenceDayID
		ELSE
			UPDATE dbo.Tickets
			SET dbo.Tickets.OrderID = (SELECT TOP 1 OrderID FROM dbo.Orders ORDER BY OrderID DESC)
			WHERE dbo.Tickets.ConferenceID = @ConferenceID AND dbo.Tickets.ConferenceDayID = @ConferenceDayID
		SET @i +=1
	END

