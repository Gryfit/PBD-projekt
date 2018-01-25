CREATE PROC AddTicket
	@ClientID INT,
	@PersonID INT,
	@ConferenceID INT,
	@ConferenceDayID INT,
AS
	DECLARE @PersonExists int
  SET @PersonExists = 
    (SELECT PersonID FROM People WHERE PersonID = @PersonID)
   
  IF NOT EXISTS (SELECT PersonID FROM People WHERE PersonID = @PersonID)
    RAISERROR('
   
  DECLARE @FreeTicket int
  SET @FreeTicket = 
    (SELECT OrderID FROM Tickets 
    WHERE ConferenceID = @ConferenceID AND ConferenceDayID = @ConferenceDayID
    AND OrderID IS NULL)
  IF @FreeTicket IS NOT NULL
