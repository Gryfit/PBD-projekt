CREATE PROC dbo.AddStudent (
    @PersonID int
)
AS
INSERT dbo.Students 
(
  PersonID
)
VALUES
(
  @PersonID
)
