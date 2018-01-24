CREATE PROC CancelConferenceDay
	@ConferenceID INT,
	@ConferenceDayID INT
AS
BEGIN
	UPDATE dbo.ConferenceDays SET Cancelled = 1 WHERE ConferenceDayID=@ConferenceDayID AND ConferenceID = @ConferenceID