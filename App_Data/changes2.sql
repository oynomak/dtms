CREATE PROCEDURE GetDefaulters
AS
DECLARE @periods tinyint;
SET @periods=(SELECT dbo.GetTaxPeriods());

WITH payments AS
(
Select *, Expected=(ISNULL(BusinessTax,0) + ISNULL(landtax,0) + ISNULL(propertytax,0) + ISNULL(RentalTax,0)) * @periods , 
Payed=dbo.GetTotalPayments(taxpayerid,CellID),Years=@periods
From taxpayerregistry
)

SELECT * FROM payments WHERE Expected>Payed