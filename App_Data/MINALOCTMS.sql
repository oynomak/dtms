USE [master]
GO
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'MINALOCTMS')

CREATE DATABASE [MINALOCTMS] 

GO
EXEC dbo.sp_dbcmptlevel @dbname=N'MINALOCTMS', @new_cmptlevel=90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MINALOCTMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MINALOCTMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MINALOCTMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MINALOCTMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MINALOCTMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MINALOCTMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [MINALOCTMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MINALOCTMS] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [MINALOCTMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MINALOCTMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MINALOCTMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MINALOCTMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MINALOCTMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MINALOCTMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MINALOCTMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MINALOCTMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MINALOCTMS] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MINALOCTMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MINALOCTMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MINALOCTMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MINALOCTMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MINALOCTMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MINALOCTMS] SET  READ_WRITE 
GO
ALTER DATABASE [MINALOCTMS] SET RECOVERY FULL 
GO
ALTER DATABASE [MINALOCTMS] SET  MULTI_USER 
GO
ALTER DATABASE [MINALOCTMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MINALOCTMS] SET DB_CHAINING OFF 
USE [MINALOCTMS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Permissions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Permissions](
	[PermissionID] [tinyint] NOT NULL,
	[PermissionName] [varchar](50) NOT NULL,
 CONSTRAINT [Permissions_PK] PRIMARY KEY CLUSTERED 
(
	[PermissionID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBankBranchByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetBankBranchByID]
@ID tinyint=0
 AS 
     SELECT * FROM dbo.BankBranches
     WHERE BankBranchID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetHouseTenantsByPhrase]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetHouseTenantsByPhrase]
@phrase varchar(200)
 AS 
     SELECT * FROM dbo.HouseTenants
     WHERE FullName LIKE ''%'' + @phrase + ''%''
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetLandParcelsByTaxPayerID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetLandParcelsByTaxPayerID]
@TaxPayerID int
 AS 
     SELECT * FROM dbo.LandParcels
     WHERE TaxPayerID=@TaxPayerID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetLandParcelByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetLandParcelByID]
@ID int
 AS 
     SELECT * FROM dbo.LandParcels
     WHERE LandParcelID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBankAccounts]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*Stored Proc: Scripted 08/2/2008   */

CREATE PROCEDURE [dbo].[GetBankAccounts]
 AS 
     SELECT * FROM dbo.BankAccounts
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPaymentByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetTaxPaymentByID]
@ID int
 AS 
     SELECT tp.*,TaxPayerName=t.Names 
     FROM dbo.TaxPayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID
     WHERE PaymentID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertBankAccounts]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* Stored Proc: Scripted 08/2/2008  */

CREATE PROCEDURE [dbo].[InsertBankAccounts]
@BankAccountID int, @BankBranchID smallint, @AccountNumber varchar(50), @TaxPayerID int, @CellID smallint 
AS
      BEGIN
         INSERT INTO dbo.BankAccounts(BankAccountID,BankBranchID, AccountNumber, TaxPayerID, CellID  )
                    VALUES (@BankAccountID,@BankBranchID, @AccountNumber, @TaxPayerID, @CellID )
           SELECT SCOPE_IDENTITY() AS NewID
        END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteBankAccounts]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DeleteBankAccounts]
 @BankAccountID bigint,@CellID smallint
 AS 
     DELETE FROM dbo.BankAccounts WHERE BankAccountID=@BankAccountID AND CellID=@CellID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertTaxPayments]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* Stored Proc: Scripted 08/2/2008  */

CREATE PROCEDURE [dbo].[InsertTaxPayments]
@PaymentID bigint, @TaxPayerID int, @PaymentDate datetime, @Amount money, @Description varchar(100), @Cashier varchar(50), @TaxTypeID tinyint, @CellID smallint 
AS

      BEGIN
         INSERT INTO dbo.TaxPayments(PaymentID,TaxPayerID, PaymentDate, Amount, Description, Cashier, TaxTypeID, CellID  )
                    VALUES (@PaymentID,@TaxPayerID, @PaymentDate, @Amount, @Description, @Cashier, @TaxTypeID, @CellID )
           SELECT SCOPE_IDENTITY() AS NewID
        END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBankBranches]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 08/2/2008   */

CREATE PROCEDURE [dbo].[GetBankBranches]
 AS 
     SELECT * FROM dbo.BankBranches
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTotalTaxpayments]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetTotalTaxpayments]
AS
	SET NOCOUNT ON
	DECLARE @TTotal money
	DECLARE @FTotal money
	SET @TTotal=(SELECT SUM(Amount) FROM Taxpayments)
	SET @FTotal=(SELECT SUM(Amount) FROM Feepayments)
	SELECT Total=@TTotal + @FTotal
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertBankBranches]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* Stored Proc: Scripted 08/2/2008  */

CREATE PROCEDURE [dbo].[InsertBankBranches]
@BankBranchID smallint, @BankID tinyint, @BankBranchName varchar(50), @DistrictID smallint 
AS
      BEGIN
         INSERT INTO dbo.BankBranches(BankBranchID,BankID, BankBranchName, DistrictID  )
                    VALUES (@BankBranchID,@BankID, @BankBranchName, @DistrictID )
           SELECT SCOPE_IDENTITY() AS NewID
        END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBanks]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 08/2/2008   */

CREATE PROCEDURE [dbo].[GetBanks]
 AS 
     SELECT * FROM dbo.Banks
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertBanks]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* Stored Proc: Scripted 08/2/2008  */

CREATE PROCEDURE [dbo].[InsertBanks]
@BankID tinyint, @BankName varchar(100), @DistrictID smallint 
AS

      BEGIN
         INSERT INTO dbo.Banks(BankID,BankName, DistrictID  )
                    VALUES (@BankID,@BankName, @DistrictID )
           SELECT SCOPE_IDENTITY() AS NewID
        END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPayers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 08/2/2008   */

CREATE PROCEDURE [dbo].[GetTaxPayers]
 AS 
     SELECT * FROM dbo.TaxPayers
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBusinesses]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 08/2/2008   */

CREATE PROCEDURE [dbo].[GetBusinesses]
 AS 
     SELECT * FROM dbo.Businesses
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteDistricts]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteDistricts]
 @ID smallint
 AS 
     DELETE FROM dbo.Districts WHERE DistrictID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetFeePayments]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 08/2/2008   */

CREATE PROCEDURE [dbo].[GetFeePayments]
 AS 
     SELECT * FROM dbo.FeePayments
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertFeePayments]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* Stored Proc: Scripted 08/2/2008  */

CREATE PROCEDURE [dbo].[InsertFeePayments]
@PaymentID bigint, @TaxPayerID int, @Designation varchar(100), @PaymentDate datetime, @Amount money, @CellID smallint 
AS

      BEGIN
         INSERT INTO dbo.FeePayments(PaymentID,TaxPayerID, Designation, PaymentDate, Amount, CellID  )
                    VALUES (@PaymentID,@TaxPayerID, @Designation, @PaymentDate, @Amount, @CellID )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteFeePayments]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DeleteFeePayments]
 @PaymentID bigint,@CellID smallint
 AS 
     DELETE FROM dbo.FeePayments WHERE PaymentID=@PaymentID AND CellID=@CellID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertCells]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[InsertCells]
@CellID smallint, @SectorID smallint, @CellName varchar(50) 
AS
IF @CellID=0
      BEGIN
         INSERT INTO dbo.Cells(SectorID, CellName  )
                    VALUES (@SectorID, @CellName )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.Cells SET SectorID=@SectorID, CellName=@CellName 
 WHERE CellID=@CellID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteCells]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteCells]
 @ID smallint
 AS 
     DELETE FROM dbo.Cells WHERE CellID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetHouseTenants]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 08/2/2008   */

CREATE PROCEDURE [dbo].[GetHouseTenants]
 AS 
     SELECT * FROM dbo.HouseTenants
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteHouseTenants]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DeleteHouseTenants]
 @HouseID int,@CellID smallint
 AS 
     DELETE FROM dbo.HouseTenants WHERE HouseID=@HouseID AND CellID=@CellID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HouseTenants]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HouseTenants](
	[HouseID] [int] NOT NULL,
	[PlotNumber] [int] NOT NULL CONSTRAINT [DF_HouseTenants_PlotNumber]  DEFAULT (''),
	[FullName] [varchar](50) NOT NULL CONSTRAINT [DF_HouseTenants_FullName]  DEFAULT (''),
	[Telephone] [varchar](30) NOT NULL CONSTRAINT [DF_HouseTenants_Telephone]  DEFAULT (''),
	[Address] [varchar](100) NOT NULL CONSTRAINT [DF_HouseTenants_Address]  DEFAULT (''),
	[Amount] [money] NOT NULL CONSTRAINT [DF_HouseTenants_Amount]  DEFAULT ((0)),
	[TaxPayerID] [int] NOT NULL,
	[CellID] [smallint] NOT NULL,
 CONSTRAINT [HouseTenants_PK] PRIMARY KEY CLUSTERED 
(
	[HouseID] ASC,
	[CellID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetLandParcels]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 08/2/2008   */

CREATE PROCEDURE [dbo].[GetLandParcels]
 AS 
     SELECT * FROM dbo.LandParcels
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertLandParcels]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* Stored Proc: Scripted 08/2/2008  */

CREATE PROCEDURE [dbo].[InsertLandParcels]
@LandParcelID int, @TaxPayerID int, @PlotNumber varchar(50), @Year smallint, @StandingLevel varchar(50), @LandTitle varchar(50), @TitleNumber varchar(50), @Usage varchar(50), @NumberOfHouses smallint, @ContractNumber varchar(50), @ContractDate datetime, @Amount money, @CellID smallint 
AS

      BEGIN
         INSERT INTO dbo.LandParcels(LandParcelID,TaxPayerID, PlotNumber, Year, StandingLevel, LandTitle, TitleNumber, Usage, NumberOfHouses, ContractNumber, ContractDate, Amount, CellID  )
                    VALUES (@LandParcelID,@TaxPayerID, @PlotNumber, @Year, @StandingLevel, @LandTitle, @TitleNumber, @Usage, @NumberOfHouses, @ContractNumber, @ContractDate, @Amount, @CellID )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteLandParcels]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DeleteLandParcels]
 @LandParcelID int,@CellID smallint
 AS 
     DELETE FROM dbo.LandParcels WHERE LandParcelID=@LandParcelID AND CellID=@CellID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPropertyByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetPropertyByID]
@ID int
 AS 
     SELECT * FROM dbo.Properties
     WHERE PropertyID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProperties]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 08/2/2008   */

CREATE PROCEDURE [dbo].[GetProperties]
 AS 
     SELECT * FROM dbo.Properties
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteProperties]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DeleteProperties]
 @PropertyID int,@CellID smallint
 AS 
     DELETE FROM dbo.Properties WHERE PropertyID=@PropertyID AND CellID=@CellID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertProvinces]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[InsertProvinces]
@ProvinceID tinyint, @ProvinceName varchar(50) 
AS
IF @ProvinceID=0
      BEGIN
         INSERT INTO dbo.Provinces(ProvinceName  )
                    VALUES (@ProvinceName )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.Provinces SET ProvinceName=@ProvinceName 
 WHERE ProvinceID=@ProvinceID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteBusinesses]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DeleteBusinesses]
 @BusinessID bigint,@CellID smallint
 AS 
     DELETE FROM dbo.Businesses WHERE BusinessID=@BusinessID AND CellID=@CellID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetHouseTenantByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetHouseTenantByID]
@ID int
 AS 
     SELECT * FROM dbo.HouseTenants
     WHERE HouseID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertDistricts]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[InsertDistricts]
@DistrictID smallint, @ProvinceID tinyint, @DistrictName varchar(50) 
AS
IF @DistrictID=0
      BEGIN
         INSERT INTO dbo.Districts(ProvinceID, DistrictName  )
                    VALUES (@ProvinceID, @DistrictName )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.Districts SET ProvinceID=@ProvinceID, DistrictName=@DistrictName 
 WHERE DistrictID=@DistrictID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSectors]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetSectors]
@districtID tinyint
 AS 
     SELECT s.*,NumberOfCells=COUNT(c.CellID) 
		FROM dbo.Sectors s LEFT JOIN Cells c
		ON s.SectorID=c.SectorID
		WHERE s.DistrictID=@districtID
		GROUP BY s.SectorName,s.SectorID, s.DistrictID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteProvinces]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteProvinces]
 @ID tinyint
 AS 
     DELETE FROM dbo.Provinces WHERE ProvinceID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertSectors]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[InsertSectors]
@SectorID smallint, @DistrictID smallint, @SectorName varchar(50) 
AS
IF @SectorID=0
      BEGIN
         INSERT INTO dbo.Sectors(DistrictID, SectorName  )
                    VALUES (@DistrictID, @SectorName )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.Sectors SET DistrictID=@DistrictID, SectorName=@SectorName 
 WHERE SectorID=@SectorID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteTaxPayers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 08/2/2008  */

CREATE PROCEDURE [dbo].[DeleteTaxPayers]
 @ID smallint,@TaxPayerID int
 AS 
     DELETE FROM dbo.TaxPayers WHERE CellID=@ID AND TaxPayerID=@TaxPayerID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistrictNameFromCellID]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[GetDistrictNameFromCellID](@CellID smallint)
RETURNS varchar(50)
AS
	BEGIN
		DECLARE @dist varchar(50)
		SET @dist=(SELECT TOP 1 DistrictName FROM Regions WHERE CellID=@CellID)
		RETURN @dist
	END' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteUsers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteUsers]
 @ID smallint
 AS 
     DELETE FROM dbo.Users WHERE UserID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Provinces]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Provinces](
	[ProvinceID] [tinyint] IDENTITY(1,1) NOT NULL,
	[ProvinceName] [varchar](50) NOT NULL,
 CONSTRAINT [Provinces_PK] PRIMARY KEY CLUSTERED 
(
	[ProvinceID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteSectors]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteSectors]
 @ID smallint
 AS 
     DELETE FROM dbo.Sectors WHERE SectorID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007   */

CREATE PROCEDURE [dbo].[GetUsers]
 AS 
     SELECT * FROM dbo.Users
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DistrictLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DistrictLog](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[District] [varchar](50) NOT NULL DEFAULT (''),
	[RecordsInserted] [int] NOT NULL DEFAULT ((0)),
	[RecordsUpdated] [int] NOT NULL DEFAULT ((0)),
	[RecordsDeleted] [int] NOT NULL DEFAULT ((0)),
	[Created] [datetime] NOT NULL DEFAULT (getdate()),
	[Text] [varchar](1000) NOT NULL CONSTRAINT [DF_DistrictLog_Text]  DEFAULT (''),
PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DistrictServers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DistrictServers](
	[ServerID] [tinyint] IDENTITY(1,1) NOT NULL,
	[District] [varchar](50) NOT NULL,
	[ServerName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_DistrictServers] PRIMARY KEY CLUSTERED 
(
	[ServerID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateTaxPayer]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UpdateTaxPayer]
@TaxPayerID int, @CellID smallint, @FileNumber varchar(30), @Address varchar(100),
@Telephone varchar(30), @Mobile varchar(30), @Profession varchar(50), @DateOfBirth datetime, 
@IDNumber varchar(20), @IDType varchar(20), @TIN varchar(50), @Email varchar(100), 
@Names varchar(100) 
AS
   UPDATE dbo.TaxPayers SET FileNumber=@FileNumber, Address=@Address, Telephone=@Telephone,
    Mobile=@Mobile, Profession=@Profession, DateOfBirth=@DateOfBirth, IDNumber=@IDNumber, 
    IDType=@IDType, TIN=@TIN, Email=@Email, Names =@Names 
    WHERE TaxpayerID=@TaxpayerID AND CellID=@CellID
        

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateTaxPayment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UpdateTaxPayment]
@PaymentID bigint, @TaxPayerID int, @PaymentDate datetime, @Amount money, @Description varchar(100), @Cashier varchar(50), @TaxTypeID tinyint, @CellID smallint 
AS
UPDATE dbo.TaxPayments SET TaxPayerID=@TaxPayerID, PaymentDate=@PaymentDate, Amount=@Amount, 
						Description=@Description, Cashier=@Cashier, TaxTypeID=@TaxTypeID
						WHERE  CellID=@CellID AND PaymentID=@PaymentID
         
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBankAccountsByTaxpayerID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetBankAccountsByTaxpayerID]
@ID int=0
 AS 
     SELECT ba.*,BranchName=b.BankName + ''-'' + bb.BankBranchName
     FROM dbo.BankAccounts ba JOIN BankBranches bb
     ON ba.BankBranchID=bb.BankBranchID JOIN Banks b
     ON bb.BankID=b.BankID
     WHERE TaxPayerID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateFeePayment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UpdateFeePayment]
@PaymentID bigint, @TaxPayerID int, @Designation varchar(100), @PaymentDate datetime, @Amount money, @CellID smallint 
AS

UPDATE dbo.FeePayments SET TaxPayerID=@TaxPayerID, Designation=@Designation,
						PaymentDate=@PaymentDate, Amount=@Amount
						WHERE  CellID=@CellID AND PaymentID=@PaymentID
       
 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBankByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetBankByID]
@ID tinyint=0
 AS 
     SELECT * FROM dbo.Banks
		WHERE BankID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBankAccountID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetBankAccountID]
@ID smallint=0
 AS 
     SELECT ba.*,BranchName=b.BankName + ''-'' + bb.BankBranchName
     FROM dbo.BankAccounts ba JOIN BankBranches bb
     ON ba.BankBranchID=bb.BankBranchID JOIN Banks b
     ON bb.BankID=b.BankID
     WHERE BankAccountID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateBankAccount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UpdateBankAccount]
@BankAccountID int, @BankBranchID smallint, @AccountNumber varchar(50), @TaxPayerID int,
 @CellID smallint 
AS
     
UPDATE dbo.BankAccounts SET BankBranchID=@BankBranchID, AccountNumber=@AccountNumber,
 TaxPayerID=@TaxPayerID
WHERE  CellID =@CellID AND BankAccountID=@BankAccountID
     ' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBusinessByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetBusinessByID]
@ID int
 AS 
     SELECT * FROM dbo.Businesses
     WHERE BusinessID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateBusiness]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UpdateBusiness]
@BusinessID int, @PlotNumber varchar(50), @BusinessName varchar(100), @Profession varchar(100), @StartDate datetime, @Amount money, @Address varchar(100), @TaxPayerID int, @CellID smallint 
AS
 UPDATE dbo.Businesses SET PlotNumber=@PlotNumber, BusinessName=@BusinessName, Profession=@Profession,
  StartDate=@StartDate, Amount=@Amount, Address=@Address, TaxPayerID=@TaxPayerID
          WHERE BusinessID=@BusinessID AND  CellID=@CellID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertBusinesses]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* Stored Proc: Scripted 08/2/2008  */

CREATE PROCEDURE [dbo].[InsertBusinesses]
@BusinessID int, @PlotNumber varchar(50), @BusinessName varchar(100), @Profession varchar(100), @StartDate datetime, @Amount money, @Address varchar(100), @TaxPayerID int, @CellID smallint 
AS
      BEGIN
         INSERT INTO dbo.Businesses(BusinessID,PlotNumber, BusinessName, Profession, StartDate, Amount, Address, TaxPayerID, CellID  )
                    VALUES (@BusinessID,@PlotNumber, @BusinessName, @Profession, @StartDate, @Amount, @Address, @TaxPayerID, @CellID )
           SELECT SCOPE_IDENTITY() AS NewID
        END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBusinessesByTaxPayerID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetBusinessesByTaxPayerID]
@TaxPayerID int
 AS 
     SELECT * FROM dbo.Businesses
     WHERE TaxPayerID=@TaxPayerID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertHouseTenants]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* Stored Proc: Scripted 08/2/2008  */

CREATE PROCEDURE [dbo].[InsertHouseTenants]
@HouseID int, @PlotNumber int, @FullName varchar(50), @Telephone varchar(30), @Address varchar(100), @Amount money, @TaxPayerID int, @CellID smallint 
AS
    BEGIN
         INSERT INTO dbo.HouseTenants(HouseID,PlotNumber, FullName, Telephone, Address, Amount, TaxPayerID, CellID  )
                    VALUES (@HouseID,@PlotNumber, @FullName, @Telephone, @Address, @Amount, @TaxPayerID, @CellID )
           SELECT SCOPE_IDENTITY() AS NewID
        END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetHouseTenantsByTaxPayerID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetHouseTenantsByTaxPayerID]
@TaxPayerID int
 AS 
     SELECT * FROM dbo.HouseTenants
     WHERE TaxPayerID=@TaxPayerID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertProperties]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* Stored Proc: Scripted 08/2/2008  */

CREATE PROCEDURE [dbo].[InsertProperties]
@PropertyID int, @PlotNumber varchar(50), @OwnersName varchar(50), @Usage varchar(50), @DateOfAcquisition datetime, @OwnerValuation money, @DistrictValuation money, @TaxPayerID int, @Amount money, @CellID smallint 
AS

      BEGIN
         INSERT INTO dbo.Properties(PropertyID,PlotNumber, OwnersName, Usage, DateOfAcquisition, OwnerValuation, DistrictValuation, TaxPayerID, Amount, CellID  )
                    VALUES (@PropertyID,@PlotNumber, @OwnersName, @Usage, @DateOfAcquisition, @OwnerValuation, @DistrictValuation, @TaxPayerID, @Amount, @CellID )
           SELECT SCOPE_IDENTITY() AS NewID
        END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TaxTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TaxTypes](
	[TaxTypeID] [tinyint] IDENTITY(1,1) NOT NULL,
	[TaxTypeName] [varchar](50) NOT NULL CONSTRAINT [DF_TaxTypes_TaxTypeName]  DEFAULT (''),
 CONSTRAINT [PK_TaxTypes] PRIMARY KEY CLUSTERED 
(
	[TaxTypeID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPropertiesByTaxPayerID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetPropertiesByTaxPayerID]
@TaxPayerID int
 AS 
     SELECT * FROM dbo.Properties
     WHERE TaxPayerID=@TaxPayerID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateHouseTenant]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UpdateHouseTenant]
@HouseID int, @PlotNumber int, @FullName varchar(50), @Telephone varchar(30), @Address varchar(100), @Amount money, @TaxPayerID int, @CellID smallint 
AS
       UPDATE dbo.HouseTenants SET PlotNumber=@PlotNumber, FullName=@FullName,
        Telephone=@Telephone, Address=@Address, Amount=@Amount, TaxPayerID=@TaxPayerID
        WHERE  CellID=@CellID AND HouseID=@HouseID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBusinessesByPhrase]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetBusinessesByPhrase]
@phrase varchar(200)
 AS 
     SELECT * FROM dbo.Businesses
		WHERE BusinessName Like ''%'' +  @phrase + ''%''
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateProperty]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UpdateProperty]
@PropertyID int, @PlotNumber varchar(50), @OwnersName varchar(50), @Usage varchar(50), @DateOfAcquisition datetime, @OwnerValuation money, @DistrictValuation money, @TaxPayerID int, @Amount money, @CellID smallint 
AS
UPDATE dbo.Properties SET PlotNumber=@PlotNumber, OwnersName=@OwnersName, Usage=@Usage, DateOfAcquisition=@DateOfAcquisition, OwnerValuation=@OwnerValuation, DistrictValuation=@DistrictValuation, TaxPayerID=@TaxPayerID, Amount=@Amount
        WHERE PropertyID=@PropertyID AND CellID=@CellID 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetLandParcelsByPhrase]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetLandParcelsByPhrase]
@phrase varchar(200)
 AS 
     SELECT * FROM dbo.LandParcels
     WHERE PlotNumber Like ''%'' + @phrase + ''%''
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateLandParcel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UpdateLandParcel]
@LandParcelID int, @TaxPayerID int, @PlotNumber varchar(50), @Year smallint, 
@StandingLevel varchar(50), @LandTitle varchar(50), @TitleNumber varchar(50),
 @Usage varchar(50), @NumberOfHouses smallint, @ContractNumber varchar(50), 
 @ContractDate datetime, @Amount money, @CellID smallint 
AS
UPDATE dbo.LandParcels SET TaxPayerID=@TaxPayerID, PlotNumber=@PlotNumber, [Year]=@Year,
 StandingLevel=@StandingLevel, LandTitle=@LandTitle, TitleNumber=@TitleNumber, Usage=@Usage,
  NumberOfHouses=@NumberOfHouses, ContractNumber=@ContractNumber, ContractDate=@ContractDate,
   Amount=@Amount
		WHERE LandParcelID=@LandParcelID AND  CellID=@CellID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserPermissions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserPermissions](
	[UserPermissionID] [smallint] NOT NULL,
	[UserID] [smallint] NULL,
	[PermissionID] [tinyint] NULL,
 CONSTRAINT [UserPermissions_PK] PRIMARY KEY CLUSTERED 
(
	[UserPermissionID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Districts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Districts](
	[DistrictID] [smallint] IDENTITY(1,1) NOT NULL,
	[ProvinceID] [tinyint] NOT NULL,
	[DistrictName] [varchar](50) NOT NULL,
 CONSTRAINT [Districts_PK] PRIMARY KEY CLUSTERED 
(
	[DistrictID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Sectors]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Sectors](
	[SectorID] [smallint] IDENTITY(1,1) NOT NULL,
	[DistrictID] [smallint] NOT NULL,
	[SectorName] [varchar](50) NOT NULL,
 CONSTRAINT [Sectors_PK] PRIMARY KEY CLUSTERED 
(
	[SectorID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Users](
	[UserID] [smallint] IDENTITY(1,1) NOT NULL,
	[DistrictID] [smallint] NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](200) NOT NULL CONSTRAINT [DF_Users_Password]  DEFAULT (''),
	[FullName] [varchar](50) NOT NULL CONSTRAINT [DF_Users_FullName]  DEFAULT (''),
	[Status] [bit] NOT NULL CONSTRAINT [DF_Users_Status]  DEFAULT ((0)),
 CONSTRAINT [Users_PK] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Banks]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Banks](
	[BankID] [tinyint] NOT NULL,
	[BankName] [varchar](100) NOT NULL,
	[DistrictID] [smallint] NOT NULL,
 CONSTRAINT [Banks_PK] PRIMARY KEY CLUSTERED 
(
	[BankID] ASC,
	[DistrictID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BankBranches]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BankBranches](
	[BankBranchID] [smallint] NOT NULL,
	[BankID] [tinyint] NOT NULL,
	[BankBranchName] [varchar](50) NOT NULL,
	[DistrictID] [smallint] NOT NULL,
 CONSTRAINT [BankBranches_PK] PRIMARY KEY CLUSTERED 
(
	[BankBranchID] ASC,
	[DistrictID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Cells]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Cells](
	[CellID] [smallint] IDENTITY(1,1) NOT NULL,
	[SectorID] [smallint] NOT NULL,
	[CellName] [varchar](50) NOT NULL,
 CONSTRAINT [Cells_PK] PRIMARY KEY CLUSTERED 
(
	[CellID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TaxPayers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TaxPayers](
	[TaxPayerID] [int] NOT NULL,
	[CellID] [smallint] NOT NULL,
	[FileNumber] [varchar](30) NOT NULL CONSTRAINT [DF_TaxPayers_FileNumber]  DEFAULT (''),
	[Address] [varchar](100) NOT NULL CONSTRAINT [DF_TaxPayers_Address]  DEFAULT (''),
	[Telephone] [varchar](30) NOT NULL CONSTRAINT [DF_TaxPayers_Telephone]  DEFAULT (''),
	[Mobile] [varchar](30) NOT NULL CONSTRAINT [DF_TaxPayers_Mobile]  DEFAULT (''),
	[Profession] [varchar](50) NOT NULL CONSTRAINT [DF_TaxPayers_Profession]  DEFAULT (''),
	[DateOfBirth] [datetime] NOT NULL CONSTRAINT [DF_TaxPayers_DateOfBirth]  DEFAULT (getdate()),
	[IDNumber] [varchar](20) NOT NULL CONSTRAINT [DF_TaxPayers_IDNumber]  DEFAULT (''),
	[IDType] [varchar](20) NOT NULL CONSTRAINT [DF_TaxPayers_IDType]  DEFAULT ('Identity Card'),
	[TIN] [varchar](50) NOT NULL CONSTRAINT [DF_TaxPayers_TIN]  DEFAULT (''),
	[Email] [varchar](100) NOT NULL CONSTRAINT [DF_TaxPayers_Email]  DEFAULT (''),
	[Names] [varchar](100) NOT NULL CONSTRAINT [DF_TaxPayers_Names]  DEFAULT (''),
 CONSTRAINT [TaxPayers_PK] PRIMARY KEY CLUSTERED 
(
	[TaxPayerID] ASC,
	[CellID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TaxPayments]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TaxPayments](
	[PaymentID] [bigint] NOT NULL,
	[TaxPayerID] [int] NOT NULL,
	[PaymentDate] [datetime] NOT NULL,
	[Amount] [money] NOT NULL,
	[Description] [varchar](100) NOT NULL,
	[Cashier] [varchar](50) NOT NULL CONSTRAINT [DF_TaxPayments_Cashier]  DEFAULT (''),
	[TaxTypeID] [tinyint] NOT NULL CONSTRAINT [DF_TaxPayments_TaxTypeID]  DEFAULT ((0)),
	[CellID] [smallint] NOT NULL,
 CONSTRAINT [TaxPayments_PK] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC,
	[CellID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Businesses]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Businesses](
	[BusinessID] [int] NOT NULL,
	[PlotNumber] [varchar](50) NOT NULL CONSTRAINT [DF_Businesses_LandParcelID]  DEFAULT (''),
	[BusinessName] [varchar](100) NOT NULL CONSTRAINT [DF_Businesses_BusinessName]  DEFAULT (''),
	[Profession] [varchar](100) NOT NULL CONSTRAINT [DF_Businesses_Profession]  DEFAULT (''),
	[StartDate] [datetime] NOT NULL,
	[Amount] [money] NOT NULL CONSTRAINT [DF_Businesses_Amount]  DEFAULT ((0)),
	[Address] [varchar](100) NOT NULL CONSTRAINT [DF_Businesses_Address]  DEFAULT (''),
	[TaxPayerID] [int] NOT NULL,
	[CellID] [smallint] NOT NULL,
 CONSTRAINT [Businesses_PK] PRIMARY KEY CLUSTERED 
(
	[BusinessID] ASC,
	[CellID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FeePayments]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FeePayments](
	[PaymentID] [bigint] NOT NULL,
	[TaxPayerID] [int] NOT NULL,
	[Designation] [varchar](100) NOT NULL,
	[PaymentDate] [datetime] NOT NULL,
	[Amount] [money] NOT NULL,
	[CellID] [smallint] NOT NULL,
 CONSTRAINT [FeePayments_PK] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC,
	[CellID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LandParcels]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LandParcels](
	[LandParcelID] [int] NOT NULL,
	[TaxPayerID] [int] NOT NULL,
	[PlotNumber] [varchar](50) NOT NULL,
	[Year] [smallint] NOT NULL,
	[StandingLevel] [varchar](50) NOT NULL,
	[LandTitle] [varchar](50) NOT NULL,
	[TitleNumber] [varchar](50) NOT NULL,
	[Usage] [varchar](50) NOT NULL,
	[NumberOfHouses] [smallint] NOT NULL,
	[ContractNumber] [varchar](50) NOT NULL,
	[ContractDate] [datetime] NOT NULL,
	[Amount] [money] NOT NULL CONSTRAINT [DF__LandParce__Amoun__634EBE90]  DEFAULT ((0)),
	[CellID] [smallint] NOT NULL,
 CONSTRAINT [LandParcels_PK] PRIMARY KEY CLUSTERED 
(
	[LandParcelID] ASC,
	[CellID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BankAccounts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BankAccounts](
	[BankAccountID] [int] NOT NULL,
	[BankBranchID] [smallint] NOT NULL,
	[AccountNumber] [varchar](50) NOT NULL,
	[TaxPayerID] [int] NOT NULL,
	[CellID] [smallint] NOT NULL,
 CONSTRAINT [BankAccounts_PK] PRIMARY KEY CLUSTERED 
(
	[BankAccountID] ASC,
	[CellID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Properties]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Properties](
	[PropertyID] [int] NOT NULL,
	[PlotNumber] [varchar](50) NOT NULL CONSTRAINT [DF_Properties_PlotNumber]  DEFAULT (''),
	[OwnersName] [varchar](50) NOT NULL CONSTRAINT [DF_Properties_OwnersName]  DEFAULT (''),
	[Usage] [varchar](50) NOT NULL CONSTRAINT [DF_Properties_Usage]  DEFAULT (''),
	[DateOfAcquisition] [datetime] NOT NULL CONSTRAINT [DF_Properties_DateOfAcquisition]  DEFAULT (getdate()),
	[OwnerValuation] [money] NOT NULL CONSTRAINT [DF_Properties_OwnerValuation]  DEFAULT ((0)),
	[DistrictValuation] [money] NOT NULL CONSTRAINT [DF_Properties_DistrictValuation]  DEFAULT ((0)),
	[TaxPayerID] [int] NOT NULL,
	[Amount] [money] NOT NULL CONSTRAINT [DF__Propertie__Amoun__59063A47]  DEFAULT ((0)),
	[CellID] [smallint] NOT NULL,
 CONSTRAINT [Properties_PK] PRIMARY KEY CLUSTERED 
(
	[PropertyID] ASC,
	[CellID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPermissions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007   */

CREATE PROCEDURE [dbo].[GetPermissions]
 AS 
     SELECT * FROM dbo.Permissions
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertPermissions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[InsertPermissions]
@PermissionID tinyint, @PermissionName varchar(50) 
AS
IF @PermissionID=0
      BEGIN
         INSERT INTO dbo.Permissions(PermissionName  )
                    VALUES (@PermissionName )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.Permissions SET PermissionName=@PermissionName 
 WHERE PermissionID=@PermissionID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeletePermissions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeletePermissions]
 @ID tinyint
 AS 
     DELETE FROM dbo.Permissions WHERE PermissionID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[TaxPayerRegistry]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[TaxPayerRegistry]
AS
SELECT     t.TaxPayerID, t.CellID, t.FileNumber, t.Address, t.Telephone, t.Mobile, t.Profession, t.DateOfBirth, t.IDNumber, t.IDType, t.TIN, t.Email, t.Names, 
                      s.SectorName AS Sector, c.CellName AS Cell, ISNULL(SUM(b.Amount), 0) AS BusinessTax, ISNULL(SUM(p.Amount), 0) AS PropertyTax, 
                      ISNULL(SUM(h.Amount), 0) AS RentalTax, ISNULL(SUM(lp.Amount), 0) AS LandTax
FROM         dbo.TaxPayers AS t INNER JOIN
                      dbo.Cells AS c ON t.CellID = c.CellID INNER JOIN
                      dbo.Sectors AS s ON c.SectorID = s.SectorID LEFT OUTER JOIN
                      dbo.Businesses AS b ON t.TaxPayerID = b.TaxPayerID LEFT OUTER JOIN
                      dbo.Properties AS p ON t.TaxPayerID = p.TaxPayerID LEFT OUTER JOIN
                      dbo.HouseTenants AS h ON t.TaxPayerID = h.TaxPayerID LEFT OUTER JOIN
                      dbo.LandParcels AS lp ON t.TaxPayerID = lp.TaxPayerID
GROUP BY t.Names, t.TaxPayerID, t.CellID, t.FileNumber, t.Address, t.Telephone, t.Mobile, t.Profession, t.DateOfBirth, t.IDNumber, t.IDType, t.TIN, t.Email, 
                      s.SectorName, c.CellName
' 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[24] 4[25] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "t"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 244
               Bottom = 106
               Right = 412
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "s"
            Begin Extent = 
               Top = 108
               Left = 244
               Bottom = 208
               Right = 412
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 241
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 210
               Left = 244
               Bottom = 325
               Right = 427
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "h"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 361
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "lp"
            Begin Extent = 
               Top = 330
               Left = 244
               Bottom = 445
               Right = 425
            End
            DisplayFlags = 280
            TopColumn = 0
         End' ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'VIEW', @level1name=N'TaxPayerRegistry'

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'VIEW', @level1name=N'TaxPayerRegistry'

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'VIEW', @level1name=N'TaxPayerRegistry'

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProvinces]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetProvinces]
 AS 
     SELECT p.ProvinceID,p.ProvinceName,NumberOfDistricts=COUNT(d.DistrictID) 
		FROM dbo.Provinces p LEFT JOIN Districts d ON
		p.ProvinceID=d.ProvinceID
		GROUP BY p.ProvinceID,p.ProvinceName

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Regions]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[Regions]
AS
SELECT     p.ProvinceName, d.DistrictName, s.SectorName, c.CellName, c.CellID, s.SectorID, d.DistrictID, p.ProvinceID
FROM         dbo.Cells AS c INNER JOIN
                      dbo.Districts AS d INNER JOIN
                      dbo.Sectors AS s ON d.DistrictID = s.DistrictID ON c.SectorID = s.SectorID INNER JOIN
                      dbo.Provinces AS p ON d.ProvinceID = p.ProvinceID
' 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 106
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 8
               Left = 423
               Bottom = 108
               Right = 575
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "s"
            Begin Extent = 
               Top = 4
               Left = 215
               Bottom = 104
               Right = 367
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 19
               Left = 657
               Bottom = 104
               Right = 809
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'VIEW', @level1name=N'Regions'

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 ,@level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'VIEW', @level1name=N'Regions'

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProvinceByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROC [dbo].[GetProvinceByID]
@ID tinyint=0
AS
SET NOCOUNT ON
SELECT ProvinceName FROM Provinces
	WHERE ProvinceID=@ID' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertUserPermissions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[InsertUserPermissions]
@UserPermissionID smallint, @UserID smallint, @PermissionID tinyint 
AS
IF @UserPermissionID=0
      BEGIN
         INSERT INTO dbo.UserPermissions(UserID, PermissionID  )
                    VALUES (@UserID, @PermissionID )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.UserPermissions SET UserID=@UserID, PermissionID=@PermissionID 
 WHERE UserPermissionID=@UserPermissionID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteUserPermissions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteUserPermissions]
 @ID smallint
 AS 
     DELETE FROM dbo.UserPermissions WHERE UserPermissionID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUserPermissions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007   */

CREATE PROCEDURE [dbo].[GetUserPermissions]
 AS 
     SELECT * FROM dbo.UserPermissions
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistrictByName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetDistrictByName]
@name varchar(50)
AS
	SET NOCOUNT ON
	SELECT * FROM Districts 
		WHERE DistrictName=@name
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistrictByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetDistrictByID] 
@ID tinyint=0
AS
	SET NOCOUNT ON
	SELECT * FROM Districts 
		WHERE DistrictID=@ID
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistrictLog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROC [dbo].[GetDistrictLog]
AS
SELECT d.DistrictID,DistrictName=UPPER(d.DistrictName), 
	RecordsInserted=ISNULL(SUM(dl.RecordsInserted),0),RecordsUpdated=ISNULL(SUM(dl.RecordsUpdated),0),
	RecordsDeleted=ISNULL(SUM(dl.RecordsDeleted),0),Created=ISNULL(MAX(dl.Created),''19000101'')  
	FROM Districts d LEFT JOIN DistrictLog dl
	ON d.DistrictName=dl.District
	GROUP BY d.DistrictName,d.DistrictID
	ORDER BY d.DistrictName


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPayersList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROC [dbo].[GetTaxPayersList]
 AS 
    SELECT t.Names, s.SectorName AS Sector, c.CellName AS Cell,t.TaxPayerID,
      t.Address, Phone=
      CASE  WHEN DATALENGTH(t.Telephone)=0 THEN Mobile 
			WHEN t.Telephone IS NULL THEN Mobile END,
      t.Profession, t.IDNumber,d.DistrictName as District
	FROM dbo.TaxPayers AS t INNER JOIN
         dbo.Cells AS c ON t.CellID = c.CellID INNER JOIN
         dbo.Sectors AS s ON c.SectorID = s.SectorID JOIN Districts d
         ON s.DistrictID=d.DistrictID
    ORDER BY d.DistrictName,s.SectorName,c.CellName,t.Names
			' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPaymentsByPeriodAndType]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetTaxPaymentsByPeriodAndType]
@TaxType tinyint,
@Startdate datetime,
@enddate datetime
 AS 
 IF @TaxType>0
     SELECT tp.*,TaxPayerName=t.Names,TaxTypeName=ISNULL(tt.TaxTypeName,''''),Sector=s.Sectorname, Cell=c.CellName
     FROM dbo.TaxPayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID LEFT JOIN TaxTypes tt
     ON tp.TaxTypeID=tt.TaxTypeID JOIN Cells c
     ON t.CellID=c.CellID JOIN Sectors s ON
     s.SectorID=c.SectorID
     WHERE tp.Paymentdate>=@startdate AND tp.Paymentdate<=@enddate
     AND tt.TaxTypeID=@TaxType
   ELSE
       SELECT tp.*,TaxPayerName=t.Names,TaxTypeName=ISNULL(tt.TaxTypeName,''''),Sector=s.Sectorname, Cell=c.CellName
     FROM dbo.TaxPayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID LEFT JOIN TaxTypes tt
     ON tp.TaxTypeID=tt.TaxTypeID JOIN Cells c
     ON t.CellID=c.CellID JOIN Sectors s ON
     s.SectorID=c.SectorID
     WHERE tp.Paymentdate>=@startdate AND tp.Paymentdate<=@enddate
     
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPaymentsByPeriodAndSector]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetTaxPaymentsByPeriodAndSector]
@SectorID tinyint,
@Startdate datetime,
@enddate datetime
 AS 
 IF @SectorID>0
     SELECT tp.*,TaxPayerName=t.Names,TaxTypeName=ISNULL(tt.TaxTypeName,''''),Sector=s.Sectorname, Cell=c.CellName
     FROM dbo.TaxPayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID LEFT JOIN TaxTypes tt
     ON tp.TaxTypeID=tt.TaxTypeID JOIN Cells c
     ON t.CellID=c.CellID JOIN Sectors s ON
     s.SectorID=c.SectorID
     WHERE tp.Paymentdate>=@startdate AND tp.Paymentdate<=@enddate
     AND s.SectorID=@SectorID
   ELSE
       SELECT tp.*,TaxPayerName=t.Names,TaxTypeName=ISNULL(tt.TaxTypeName,''''),Sector=s.Sectorname, Cell=c.CellName
     FROM dbo.TaxPayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID LEFT JOIN TaxTypes tt
     ON tp.TaxTypeID=tt.TaxTypeID JOIN Cells c
     ON t.CellID=c.CellID JOIN Sectors s ON
     s.SectorID=c.SectorID
     WHERE tp.Paymentdate>=@startdate AND tp.Paymentdate<=@enddate
     
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPayersByPhrase]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetTaxPayersByPhrase]
@phrase varchar(200)
 AS 
     SELECT t.*,Sector=s.SectorName,Cell=c.CellName 
     FROM dbo.TaxPayers t JOIN Cells c 
     ON t.CellID=c.CellID JOIN Sectors s
     ON c.SectorID=s.SectorID
     WHERE Names LIKE ''%'' + @phrase + ''%''
     ORDER BY t.Names
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPayersBySector]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetTaxPayersBySector]
@SectorID smallint=0
 AS 
     SELECT t.*,Sector=s.SectorName,Cell=c.CellName 
     FROM dbo.TaxPayers t JOIN Cells c 
     ON t.CellID=c.CellID JOIN Sectors s
     ON c.SectorID=s.SectorID
     WHERE s.SectorID=@SectorID
     ORDER BY t.Names
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSectorByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetSectorByID]
@ID smallint
AS
	SET NOCOUNT ON
	SELECT * FROM Sectors WHERE SectorID=@ID
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPayerByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetTaxPayerByID]
@ID int
 AS 
     SELECT t.*,Sector=s.SectorName,Cell=c.CellName 
     FROM dbo.TaxPayers t JOIN Cells c 
     ON t.CellID=c.CellID JOIN Sectors s
     ON c.SectorID=s.SectorID
     WHERE TaxPayerID=@ID
     ORDER BY t.Names
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertUsers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[InsertUsers]
@UserID smallint, @DistrictID smallint, @UserName varchar(50), @Password varchar(200),
@FullName varchar(50), @Status bit=1
AS
IF @UserID=0
      BEGIN
         INSERT INTO dbo.Users(DistrictID, UserName, Password,FullName,Status  )
                    VALUES (@DistrictID, @UserName, @Password,@FullName,@Status )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.Users SET DistrictID=@DistrictID, UserName=@UserName, Password=@Password,
        FullName=@FullName,Status=@Status 
	WHERE UserID=@UserID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUserByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetUserByID]
@ID smallint=0
AS
	SET NOCOUNT ON
	SELECT * FROM Users
		WHERE UserID=@ID
		ORDER BY username
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCells]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetCells]
@SectorID smallint=0
 AS 
     SELECT * FROM dbo.Cells WHERE SectorID=@SectorID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCellByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetCellByID]
@ID smallint
AS
	SET NOCOUNT ON
	SELECT * FROM Cells WHERE CellID=@ID
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCellPayments]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[GetCellPayments](@taxtypeID int,@startdate datetime,@enddate datetime)
RETURNS @payments TABLE (CellID smallint,paymentdate datetime,amount money,taxtypeID varchar(50))
AS
BEGIN
	DECLARE @cell smallint
	DECLARE cellDistrict CURSOR FOR
		SELECT CellID FROM Cells

	OPEN cellDistrict
	FETCH NEXT FROM CellDistrict INTO @cell
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF EXISTS(SELECT * FROM Taxpayments WHERE CellID=@cell AND TaxTypeID=@TaxTypeID AND Paymentdate BETWEEN @startdate AND @enddate)
			INSERT INTO @payments SELECT @Cell,paymentdate,amount,TaxtypeID 
				FROM Taxpayments 
				WHERE CellID=@cell AND TaxTypeID=@TaxTypeID AND Paymentdate BETWEEN @startdate AND @enddate
		ELSE
			INSERT INTO @payments SELECT @cell,@startdate,0,@taxtypeID
		FETCH NEXT FROM CellDistrict INTO @cell
	END
	CLOSE CellDistrict
	DEALLOCATE CellDistrict
	RETURN
END' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteBanks]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DeleteBanks]
 @BankID int,@DistrictID smallint
 AS 
     DELETE FROM dbo.Banks WHERE BankID=@BankID AND DistrictID=@DistrictID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateBank]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UpdateBank]
@BankID tinyint, @BankName varchar(100), @DistrictID smallint 
AS
       UPDATE dbo.Banks SET BankName=@BankName
       WHERE DistrictID=@DistrictID AND BankID=@BankID
  ' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateBankBranch]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UpdateBankBranch]
@BankBranchID smallint, @BankID tinyint, @BankBranchName varchar(50), @DistrictID smallint 
AS
UPDATE dbo.BankBranches SET BankID=@BankID, BankBranchName=@BankBranchName
WHERE BankBranchID=@BankBranchID AND DistrictID=@DistrictID                   ' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteBankBranches]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DeleteBankBranches]
 @BankBranchID int,@DistrictID smallint
 AS 
     DELETE FROM dbo.BankBranches WHERE BankBranchID=@BankBranchID AND DistrictID=@DistrictID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetLatestDistrictLog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROC [dbo].[GetLatestDistrictLog]
@Name varchar(50)
AS
SELECT LogID,District, 
	RecordsInserted=ISNULL(dl.RecordsInserted,0),RecordsUpdated=ISNULL(dl.RecordsUpdated,0),
	RecordsDeleted=ISNULL(dl.RecordsDeleted,0),Created=ISNULL(MAX(dl.Created),''19000102'')  
	FROM DistrictLog dl
	WHERE District=@Name AND [Text] LIKE ''Success%''
	GROUP BY logID,District,RecordsInserted,RecordsUpdated,RecordsDeleted


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertDistrictLog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[InsertDistrictLog]
@LogID bigint, @District varchar(50), @RecordsInserted int, @RecordsUpdated int,
 @RecordsDeleted int, @Created datetime ,@Text varchar(1000)
AS
IF @LogID=0
      BEGIN
         INSERT INTO dbo.DistrictLog(District, RecordsInserted, RecordsUpdated, RecordsDeleted, Created,[Text]  )
                    VALUES (@District, @RecordsInserted, @RecordsUpdated, @RecordsDeleted, @Created,@Text )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.DistrictLog SET District=@District, RecordsInserted=@RecordsInserted,
         RecordsUpdated=@RecordsUpdated, RecordsDeleted=@RecordsDeleted, Created=@Created,
         [Text]=@Text 
 WHERE LogID=@LogID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteDistrictLog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 10/2/2008  */

CREATE PROCEDURE [dbo].[DeleteDistrictLog]
 @ID bigint
 AS 
     DELETE FROM dbo.DistrictLog WHERE LogID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistrictServers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetDistrictServers]
 AS 
     SELECT * FROM dbo.DistrictServers
		ORDER BY District

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistrictServerByDistrict]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetDistrictServerByDistrict]
@Name varchar(50)
 AS 
     SELECT * FROM dbo.DistrictServers WHERE District=@Name
		

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertTaxPayers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* Stored Proc: Scripted 08/2/2008  */

CREATE PROCEDURE [dbo].[InsertTaxPayers]
@TaxPayerID int, @CellID smallint, @FileNumber varchar(30), @Address varchar(100), @Telephone varchar(30), @Mobile varchar(30), @Profession varchar(50), @DateOfBirth datetime, @IDNumber varchar(20), @IDType varchar(20), @TIN varchar(50), @Email varchar(100), @Names varchar(100) 
AS

      BEGIN
         INSERT INTO dbo.TaxPayers(TaxPayerID,CellID,FileNumber, Address, Telephone, Mobile, Profession, DateOfBirth, IDNumber, IDType, TIN, Email, Names  )
                    VALUES (@TaxPayerID,@CellID,@FileNumber, @Address, @Telephone, @Mobile, @Profession, @DateOfBirth, @IDNumber, @IDType, @TIN, @Email, @Names )
           SELECT SCOPE_IDENTITY() AS NewID
        END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPaymentsByPeriod]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetTaxPaymentsByPeriod]
@Startdate datetime,
@enddate datetime
 AS 
     SELECT * FROM (
     SELECT DistrictName=ISNULL(r.DistrictName,''''),SectorName=ISNULL(r.SectorName,''''),
     CellName=ISNULL(r.CellName,''''), TaxTypeName=ISNULL(tt.TaxTypeName,''''),
     CASE WHEN tp.PaymentDate BETWEEN @startdate AND @enddate
                      THEN tp.Amount ELSE 0 END AS Amount
     FROM Regions r FULL JOIN Taxpayments tp 
     ON r.CellID=tp.CellID  FULL JOIN TaxTypes tt
	 ON tp.TaxTypeID=tt.TaxTypeID ) as p
	 
	 WHERE DATALENGTH(p.DistrictName)>0 AND DATALENGTH(p.TaxTypeName)>0
	 
   


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteTaxPayments]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DeleteTaxPayments]
 @PaymentID bigint,@CellID smallint
 AS 
     DELETE FROM dbo.TaxPayments WHERE PaymentID=@PaymentID AND CellID=@CellID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxTypeNameFromID]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[GetTaxTypeNameFromID](@TaxTypeID tinyint)
RETURNS varchar(50)
AS
	BEGIN
		DECLARE @taxname varchar(50)
		SET @taxname=(SELECT TaxTypeName FROM TaxTypes WHERE TaxTypeID=@TaxTypeID)
		RETURN @taxname
	END' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxTypes]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetTaxTypes]
 AS 
     SELECT * FROM dbo.TaxTypes
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertTaxTypes]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[InsertTaxTypes]
@TaxTypeID tinyint, @TaxTypeName varchar(50) 
AS
IF @TaxTypeID=0
      BEGIN
         INSERT INTO dbo.TaxTypes(TaxTypeName  )
                    VALUES (@TaxTypeName )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.TaxTypes SET TaxTypeName=@TaxTypeName 
 WHERE TaxTypeID=@TaxTypeID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteTaxTypes]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DeleteTaxTypes]
 @ID tinyint
 AS 
     DELETE FROM dbo.TaxTypes WHERE TaxTypeID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxTypeByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetTaxTypeByID]
@ID tinyint=0
AS
	SET NOCOUNT ON
	SELECT * FROM TaxTypes
		WHERE TaxtypeID=@ID
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPayments]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetTaxPayments]
 AS 
     SELECT tp.*,TaxPayerName=t.Names,TaxType=ISNULL(tt.TaxTypeName,'''') 
     FROM dbo.TaxPayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID LEFT JOIN TaxTypes tt
     ON tp.TaxTypeID=tt.TaxTypeID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPaymentsBySectorAndPeriod]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetTaxPaymentsBySectorAndPeriod]
@Startdate datetime,
@enddate datetime,
@SectorID smallint
 AS 
     
     SELECT * FROM (
     SELECT SectorName=ISNULL(r.SectorName,''''),
     CellName=ISNULL(r.CellName,''''), TaxTypeName=ISNULL(tt.TaxTypeName,''''),
     CASE WHEN tp.PaymentDate BETWEEN @startdate AND @enddate
                      THEN tp.Amount ELSE 0 END AS Amount
     FROM Regions r FULL JOIN Taxpayments tp 
     ON r.CellID=tp.CellID  FULL JOIN TaxTypes tt
	 ON tp.TaxTypeID=tt.TaxTypeID 
	 WHERE r.SectorID=@SectorID
	 ) as p
	 WHERE DATALENGTH(p.SectorName)>0 
	 
	 
	 
   


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPaymentsByPeriodAndDistrict]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetTaxPaymentsByPeriodAndDistrict]
@Startdate datetime,
@enddate datetime,
@DistrictID smallint
 AS 
     
     SELECT * FROM (
     SELECT DistrictName=ISNULL(r.DistrictName,''''),SectorName=ISNULL(r.SectorName,''''),
     CellName=ISNULL(r.CellName,''''), TaxTypeName=ISNULL(tt.TaxTypeName,''''),
     CASE WHEN tp.PaymentDate BETWEEN @startdate AND @enddate
                      THEN tp.Amount ELSE 0 END AS Amount
     FROM Regions r FULL JOIN Taxpayments tp 
     ON r.CellID=tp.CellID  FULL JOIN TaxTypes tt
	 ON tp.TaxTypeID=tt.TaxTypeID 
	 WHERE r.DistrictID=@DistrictID
	 ) as p
	 WHERE DATALENGTH(p.DistrictName)>0 
	 
	 
	 
   


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistricts]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetDistricts]
@ProvinceID tinyint=0
 AS 
 IF @ProvinceID>0
     SELECT d.DistrictID,d.ProvinceID,d.DistrictName,NumberOfSectors=COUNT(s.SectorID) 
		FROM dbo.Districts d LEFT JOIN Sectors s
		ON d.DistrictID=s.DistrictID
		WHERE d.ProvinceID=@ProvinceID
		GROUP BY d.DistrictName,d.DistrictID,d.ProvinceID
 ELSE
	 SELECT r.ProvinceID,r.DistrictID,r.ProvinceName,r.DistrictName
		FROM dbo.Regions r
		ORDER BY r.DistrictName
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPaymentsByTaxTypeAndPeriod]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetTaxPaymentsByTaxTypeAndPeriod]
@TaxtypeID smallint,@startdate datetime,@enddate datetime
AS
SELECT District=dbo.GetDistrictNameFromCellID(CellID),Amount,
		[Tax Type]=dbo.GetTaxTypeNameFromID(TaxTypeID)
 FROM dbo.GetCellPayments(@TaxTypeID,@startdate,@enddate)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSectorTaxPayerRegistry]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetSectorTaxPayerRegistry]
@SectorID smallint=0
 AS 
     SELECT t.* 
     FROM dbo.TaxPayerRegistry t JOIN Cells c 
     ON t.CellID=c.CellID JOIN Sectors s
     ON c.SectorID=s.SectorID
     WHERE s.SectorID=@SectorID
     ORDER BY t.Names
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPayersForDistrict]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetTaxPayersForDistrict]
@DistrictID smallint
 AS 
 
     SELECT tg.TaxPayerID,tg.CellID,FileNumber,Address,Telephone,Mobile,
     Profession=CASE WHEN DATALENGTH(LTRIM(Profession))=0 THEN ''NOT SPECIFIED''ELSE Profession END,
     DateOfBirth,
     IDNumber=CASE WHEN IDNumber IS NULL THEN ''-'' 
				WHEN DATALENGTH(LTRIM(IDNumber))=0 THEN ''-'' 
				WHEN IDNumber=''0'' THEN ''-'' ELSE IDNUmber END,IDType,TIN,Email,Names,tg.Sector,tg.Cell,
     BusinessTax,PropertyTax,RentalTax,LandTax,r.DistrictName
     FROM dbo.TaxPayerRegistry tg JOIN Regions r
		ON tg.CellID=r.CellID 
		WHERE r.DistrictID=@DistrictID

' 
END
GO
USE [MINALOCTMS]
GO
USE [MINALOCTMS]
GO
USE [MINALOCTMS]
GO
USE [MINALOCTMS]
GO
USE [MINALOCTMS]
GO
USE [MINALOCTMS]
GO
USE [MINALOCTMS]
GO
USE [MINALOCTMS]
GO
USE [MINALOCTMS]
GO
USE [MINALOCTMS]
GO
USE [MINALOCTMS]
GO
USE [MINALOCTMS]
GO
USE [MINALOCTMS]
GO
USE [MINALOCTMS]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[Permissions_UserPermissions_FK1]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserPermissions]'))
ALTER TABLE [dbo].[UserPermissions]  WITH CHECK ADD  CONSTRAINT [Permissions_UserPermissions_FK1] FOREIGN KEY([PermissionID])
REFERENCES [dbo].[Permissions] ([PermissionID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[Users_UserPermissions_FK1]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserPermissions]'))
ALTER TABLE [dbo].[UserPermissions]  WITH CHECK ADD  CONSTRAINT [Users_UserPermissions_FK1] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[Provinces_Districts_FK1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Districts]'))
ALTER TABLE [dbo].[Districts]  WITH CHECK ADD  CONSTRAINT [Provinces_Districts_FK1] FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[Provinces] ([ProvinceID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[Districts_Sectors_FK1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Sectors]'))
ALTER TABLE [dbo].[Sectors]  WITH CHECK ADD  CONSTRAINT [Districts_Sectors_FK1] FOREIGN KEY([DistrictID])
REFERENCES [dbo].[Districts] ([DistrictID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[Districts_Users_FK1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [Districts_Users_FK1] FOREIGN KEY([DistrictID])
REFERENCES [dbo].[Districts] ([DistrictID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Banks_Districts]') AND parent_object_id = OBJECT_ID(N'[dbo].[Banks]'))
ALTER TABLE [dbo].[Banks]  WITH CHECK ADD  CONSTRAINT [FK_Banks_Districts] FOREIGN KEY([DistrictID])
REFERENCES [dbo].[Districts] ([DistrictID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BankBranches_Districts]') AND parent_object_id = OBJECT_ID(N'[dbo].[BankBranches]'))
ALTER TABLE [dbo].[BankBranches]  WITH CHECK ADD  CONSTRAINT [FK_BankBranches_Districts] FOREIGN KEY([DistrictID])
REFERENCES [dbo].[Districts] ([DistrictID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[Sectors_Cells_FK1]') AND parent_object_id = OBJECT_ID(N'[dbo].[Cells]'))
ALTER TABLE [dbo].[Cells]  WITH CHECK ADD  CONSTRAINT [Sectors_Cells_FK1] FOREIGN KEY([SectorID])
REFERENCES [dbo].[Sectors] ([SectorID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[Cells_TaxPayers_FK1]') AND parent_object_id = OBJECT_ID(N'[dbo].[TaxPayers]'))
ALTER TABLE [dbo].[TaxPayers]  WITH CHECK ADD  CONSTRAINT [Cells_TaxPayers_FK1] FOREIGN KEY([CellID])
REFERENCES [dbo].[Cells] ([CellID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TaxPayments_TaxPayers]') AND parent_object_id = OBJECT_ID(N'[dbo].[TaxPayments]'))
ALTER TABLE [dbo].[TaxPayments]  WITH CHECK ADD  CONSTRAINT [FK_TaxPayments_TaxPayers] FOREIGN KEY([TaxPayerID], [CellID])
REFERENCES [dbo].[TaxPayers] ([TaxPayerID], [CellID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Businesses_TaxPayers]') AND parent_object_id = OBJECT_ID(N'[dbo].[Businesses]'))
ALTER TABLE [dbo].[Businesses]  WITH CHECK ADD  CONSTRAINT [FK_Businesses_TaxPayers] FOREIGN KEY([TaxPayerID], [CellID])
REFERENCES [dbo].[TaxPayers] ([TaxPayerID], [CellID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FeePayments_TaxPayers]') AND parent_object_id = OBJECT_ID(N'[dbo].[FeePayments]'))
ALTER TABLE [dbo].[FeePayments]  WITH CHECK ADD  CONSTRAINT [FK_FeePayments_TaxPayers] FOREIGN KEY([TaxPayerID], [CellID])
REFERENCES [dbo].[TaxPayers] ([TaxPayerID], [CellID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_LandParcels_TaxPayers]') AND parent_object_id = OBJECT_ID(N'[dbo].[LandParcels]'))
ALTER TABLE [dbo].[LandParcels]  WITH CHECK ADD  CONSTRAINT [FK_LandParcels_TaxPayers] FOREIGN KEY([TaxPayerID], [CellID])
REFERENCES [dbo].[TaxPayers] ([TaxPayerID], [CellID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_BankAccounts_TaxPayers]') AND parent_object_id = OBJECT_ID(N'[dbo].[BankAccounts]'))
ALTER TABLE [dbo].[BankAccounts]  WITH CHECK ADD  CONSTRAINT [FK_BankAccounts_TaxPayers] FOREIGN KEY([TaxPayerID], [CellID])
REFERENCES [dbo].[TaxPayers] ([TaxPayerID], [CellID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Properties_TaxPayers]') AND parent_object_id = OBJECT_ID(N'[dbo].[Properties]'))
ALTER TABLE [dbo].[Properties]  WITH CHECK ADD  CONSTRAINT [FK_Properties_TaxPayers] FOREIGN KEY([TaxPayerID], [CellID])
REFERENCES [dbo].[TaxPayers] ([TaxPayerID], [CellID])
