CREATE PROC dbo.AddWorkshop
@ConferenceDayID INT,
@ConferenceID INT,
@Start DATETIME,
@Duration DATETIME,
@Seats INT,
@BasePrice DECIMAL(10,2)
AS
DECLARE @Day AS DATETIME
IF DATEDIFF(day, @Start, 
            (SELECT TOP 1 cd.Day FROM ConferenceDays AS cd WHERE ConferenceID = @ConferenceID AND ConferenceDayID = @ConferenceDayID)) > 0
	RAISERROR ('Start Date is a different day from ConferenceDay.',-1,-1)
ELSE 
BEGIN
	IF DATEDIFF(day, @Start, @Duration)) > 0
		RAISERROR ('Difference between Start and Duration is grater than 1 day.',-1,-1)
	ELSE
	BEGIN
		INSERT dbo.Workshops
		(
			ConferenceDayID,
			ConferenceID,
			Start,
			Duration,
			Seats,
			BasePrice
		)
		VALUES
		(   @ConferenceDayID,         -- ConferenceDayID - int
			@ConferenceID,         -- ConferenceID - int
			@StartD, -- Start - datetime
			@Duration, -- Duration - datetime
			@Seats,         -- Seats - int
			@BasePrice       -- BasePrice - decimal(10, 2)
			)
	END
END
