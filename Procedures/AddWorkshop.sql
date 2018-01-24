CREATE PROC dbo.AddWorkshop
@ConferenceDayID INT,
@ConferenceID INT,
@StartD DATETIME,
@Duration DATETIME,
@Seats INT,
@BasePrice DECIMAL(10,2)
AS
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