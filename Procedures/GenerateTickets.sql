CREATE PROC GenerateTickets
@ConferenceID int,
@ConferenceDayID int
AS
DECLARE
@seats int
SET @seats = (SELECT Seats FROM Conferences WHERE Conferences.ConferenceID = @ConferenceID)
SET @seats += (SELECT Seats FROM Workshops WHERE Workshops.ConferenceID = @ConferenceID AND Workshops.ConferenceDayID = @ConferenceDayID)
DECLARE
@i int
SET @i =0
WHILE (@i<@seats)
BEGIN
	INSERT Tickets Values (NULL,NULL,@ConferenceID, @ConferenceDayID)
	SET @i = (@i+1)
END
