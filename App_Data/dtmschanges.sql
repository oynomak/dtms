set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


/*Stored Proc: Scripted 05/12/2007  */

ALTER PROCEDURE [dbo].[DeleteLandParcels]
 @ID int
 AS 
     DELETE FROM dbo.LandParcels WHERE LandParcelID=@ID

