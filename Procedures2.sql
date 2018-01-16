CREATE PROC GenerateDays 
@ConferenceID int
AS
	DECLARE
	@StD datetime
	DECLARE
	@EnD datetime
	DECLARE
	@i int
	SET @i =1
	SET @StD = (SELECT TOP 1 StartDate
	FROM Conferences
	WHERE Conferences.ConferenceID = @ConferenceID)

	SET @EnD = (SELECT TOP 1 EndDate
	FROM Conferences
	WHERE Conferences.ConferenceID = @ConferenceID)

	WHILE @StD < @EnD
	BEGIN
		INSERT ConferenceDays Values (@i,@ConferenceID,@StD)
		SET @i = (@i +1)
		SET @StD = DATEADD(day,1,@StD)
	END
