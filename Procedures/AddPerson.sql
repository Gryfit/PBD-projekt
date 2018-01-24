CREATE PROC dbo.AddPerson
    @CompanyName INT,
    @LastName VARCHAR(30),
    @FirstName VARCHAR(30),
    @IsStudent BIT
AS
    IF @CompanyName IS NOT NULL
        IF (SELECT CompanyID FROM dbo.CompanyList WHERE CompanyName = @CompanyName) IS NULL
        BEGIN
            INSERT dbo.CompanyList
            (
                CompanyName
            )
            VALUES
            (
                @CompanyName -- CompanyName - varchar(50)
            )
        END
        
    DECLARE @IdentityValue TABLE (
        PersonID int
        )
    INSERT dbo.People
    (
        CompanyID,
        LastName,
        FirstName
    )
    OUTPUT inserted.PersonID INTO @IdentityValue
    VALUES
    (   (SELECT CompanyID FROM dbo.CompanyList WHERE CompanyName = @CompanyName),  -- CompanyID - int
        @LastName, -- LastName - varchar(30)
        @FirstName  -- FirstName - varchar(30)
    )
    
    IF @IsStudent = 1
    BEGIN
        INSERT dbo.Students (PersonID)
        SELECT PersonID 
        FROM @IdentityValue   
    END
