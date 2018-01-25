CREATE TRIGGER PriceTrasholdDateCheck ON dbo.ConferenceDiscounts AFTER INSERT AS 
BEGIN 
    DECLARE @ConferenceID AS int 
    SET @ConferenceID = (SELECT ConferenceID FROM inserted)
    DECLARE @UntilDate AS datetime
    SET @UntilDate = (SELECT UntilDate FROM inserted)
    DECLARE @Discount AS int 
    SET @Discount = (SELECT Discount FROM inserted)
    
    IF @UntilDate > GETDATE()
    BEGIN
        RAISERROR ('You try to set discount price for date in the past.',-1,-1)
        ROLLBACK TRANSACTION
        RETURN
    END
END 
