CREATE PROC AddPriceThreshold
	@ConferenceID INT,
	@UntilDate DATETIME,
	@Discount INT
AS
	INSERT dbo.ConferenceDiscounts
	(
	    ConferenceID,
	    UntilDate,
	    Discount
	)
	VALUES
	(   @ConferenceID,         -- ConferenceID - int
	    @UntilDate, -- UntilDate - datetime
	    @Discount          -- Discount - int
	    )