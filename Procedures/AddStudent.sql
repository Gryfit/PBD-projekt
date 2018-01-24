CREATE PROC dbo.AddPerson
    @PersonID
AS
  INSERT dbo.Students 
  (
    PersonID
  )
  VALUES
  (
    @PersonID
    )
