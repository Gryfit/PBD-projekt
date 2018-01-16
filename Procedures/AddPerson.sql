CREATE PROC AddPerson
	@CompanyName INT,
	@LastName VARCHAR(30),
	@FirstName VARCHAR(30),
	@TicketID INT
AS
	IF
	@CompanyName IS NOT NULL
		IF
		(SELECT CompanyID FROM dbo.CompanyList WHERE CompanyName = @CompanyName) IS NULL
		BEGIN
			INSERT dbo.CompanyList
			(
			    CompanyName
			)
			VALUES
			(@CompanyName -- CompanyName - varchar(50)
			    )
		END
		INSERT dbo.People
		(
			CompanyID,
			LastName,
			FirstName
		)
		VALUES
		(   (SELECT CompanyID FROM dbo.CompanyList WHERE CompanyName = @CompanyName),  -- CompanyID - int
			@LastName, -- LastName - varchar(30)
			@FirstName  -- FirstName - varchar(30)
			)
		UPDATE dbo.Tickets
		SET dbo.Tickets.PersonID = (SELECT TOP 1 PersonID FROM dbo.People ORDER BY PersonID DESC)
