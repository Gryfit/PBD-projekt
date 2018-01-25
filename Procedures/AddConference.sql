CREATE PROC AddConference
	@StartDate DATETIME,
	@EndDate DATETIME,
	@Seats INT,
	@BasePrice DECIMAL(10,2),
	@StudentDiscount INT
AS
	INSERT dbo.Conferences
	(
	    StartDate,
	    EndDate,
	    Seats,
	    BasePrice,
	    StudentDiscount
	)
	VALUES
	(   @StartDate, -- StartDate - datetime
	    @EndDate, -- EndDate - datetime
	    @Seats,         -- Seats - int
	    @BasePrice,      -- BasePrice - decimal(10, 2)
	    @StudentDiscount          -- StudentDiscount - int
	    )
	EXEC GenerateDays @ConferenceID = (SELECT TOP 1 ConferenceID FROM dbo.Conferences ORDER BY ConferenceID DESC)
