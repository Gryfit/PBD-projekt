ALTER PROC AddClient
    @Email VARCHAR(255),
    @Phone VARCHAR(14),
    @CompanyName  VARCHAR(50)
AS
    DECLARE @compID AS int
    SET @compID = (SELECT CompanyID FROM dbo.CompanyList WHERE CompanyName = @CompanyName)
    DECLARE @cliID AS int
    SET @cliID = (SELECT ClientID FROM dbo.CompanyClients WHERE CompanyID = @compID)
    

    IF @CompanyName IS NULL
    INSERT dbo.Clients
    (
        Email,
        Phone
    )
    VALUES
    (   @Email, -- Email - varchar(255)
        @Phone  -- Phone - varchar(14)
        )
    ELSE
        IF @cliID IS NULL
            INSERT dbo.Clients
            (
                 Email,
                 Phone
            )
            VALUES
            (   @Email, -- Email - varchar(255)
                @Phone  -- Phone - varchar(14)
            )
            INSERT dbo.CompanyClients
            (
                ClientID,
                CompanyID
            )
            VALUES
            (   (SELECT Top 1 ClientID FROM Clients ORDER BY 1 DESC), -- ClientID - int
                @compID  -- CompanyID - int
                )
