CREATE PROC CancelConference
	@ConferenceID INT
	
AS
BEGIN

	UPDATE dbo.Workshops SET Cancelled =1 WHERE ConferenceID = @ConferenceID
	UPDATE dbo.ConferenceDays SET Cancelled = 1  WHERE ConferenceID = @ConferenceID
	UPDATE dbo.Conferences SET Cancelled = 1 WHERE ConferenceID = @ConferenceID

END