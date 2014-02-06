CREATE FUNCTION GetTotalPayments(@TaxpayerID int)
RETURNS money
AS
BEGIN
	DECLARE @total money
	SET @total=(SELECT SUM(Amount) FROM Taxpayments WHERE TaxpayerID=@TaxpayerID)
	RETURN ISNULL(@total,0)
END