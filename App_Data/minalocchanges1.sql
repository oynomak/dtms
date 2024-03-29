set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

CREATE FUNCTION [dbo].[GetTotalPayments](@TaxpayerID int,@CellID smallint)
RETURNS money
AS
BEGIN
	DECLARE @total money
	SET @total=(SELECT SUM(Amount) FROM Taxpayments WHERE TaxpayerID=@TaxpayerID AND CellID=@CellID)
	RETURN ISNULL(@total,0)
END
