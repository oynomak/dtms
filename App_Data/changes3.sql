CREATE FUNCTION GetTaxPeriods()
RETURNS tinyint
AS
BEGIN
	DECLARE @years tinyint
	SET @years=(Select period=DATEDIFF(Year,GETDATE(),Min(paymentdate))+1 from taxpayments)
	RETURN @years
END
