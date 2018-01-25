CREATE PROC AddClient
	@Email VARCHAR(255),
	@Phone VARCHAR(14),
	@CompanyName  VARCHAR(50)
AS
	INSERT dbo.Clients
	(
	    Email,
	    Phone
	)
	VALUES
	(   @Email, -- Email - varchar(255)
	    @Phone  -- Phone - varchar(14)
	    )
	IF @CompanyName IS NOT NULL
		IF (SELECT CompanyID FROM dbo.CompanyList WHERE CompanyName = @CompanyName) IS NOT NULL
			INSERT dbo.CompanyClients
			(
			    ClientID,
			    CompanyID
			)
			VALUES
			(   (SELECT ClientID 
			     FROM dbo.CompanyClients as cc 
			     JOIN CompanyList as cl 
			          ON cl.CompanyID = cc.CompanyID AND CompanyName = @CompanyName), -- ClientID - int
			    (SELECT CompanyID FROM dbo.CompanyList WHERE CompanyName = @CompanyName)  -- CompanyID - int
			    )
		ELSE
			INSERT dbo.CompanyList
			(
			    CompanyName
			)
			VALUES
			(@CompanyName -- CompanyName - varchar(50)
			    )
			INSERT dbo.CompanyClients
			(
			    ClientID,
			    CompanyID
			)
			VALUES
			(   (SELECT TOP 1 ClientID FROM dbo.Clients ORDER BY ClientID DESC), -- ClientID - int
			    (SELECT CompanyID FROM dbo.CompanyList WHERE CompanyName = @CompanyName)  -- CompanyID - int
			    )
