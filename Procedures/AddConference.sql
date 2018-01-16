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