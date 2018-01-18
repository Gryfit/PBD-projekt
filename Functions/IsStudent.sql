CREATE FUNCTION dbo.IsStudent(@PersonID int) RETURNS bit AS
BEGIN
  RETURN( CASE
            WHEN EXISTS(SELECT 1 FROM Students WHERE PersonID = @PersonID) 
            THEN 1
            ELSE 0
          END
      )
END
