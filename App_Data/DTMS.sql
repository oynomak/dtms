USE [master]
GO
CREATE DATABASE [DTMS]
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'DTMS', @new_cmptlevel=90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DTMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DTMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DTMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DTMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DTMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DTMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [DTMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DTMS] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [DTMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DTMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DTMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DTMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DTMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DTMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DTMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DTMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DTMS] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DTMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DTMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DTMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DTMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DTMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DTMS] SET  READ_WRITE 
GO
ALTER DATABASE [DTMS] SET RECOVERY FULL 
GO
ALTER DATABASE [DTMS] SET  MULTI_USER 
GO
ALTER DATABASE [DTMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DTMS] SET DB_CHAINING OFF 
USE [DTMS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[PermissionID] [tinyint] NOT NULL,
	[PermissionName] [varchar](50) NOT NULL,
	[Created] [datetime] NOT NULL DEFAULT (getdate()),
	[Modified] [datetime] NOT NULL DEFAULT (getdate()),
	[RowVersion] [int] NOT NULL DEFAULT ((1)),
 CONSTRAINT [Permissions_PK] PRIMARY KEY CLUSTERED 
(
	[PermissionID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBankBranchByID]
@ID tinyint=0
 AS 
     SELECT * FROM dbo.BankBranches
     WHERE BankBranchID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banks](
	[BankID] [tinyint] IDENTITY(1,1) NOT NULL,
	[BankName] [varchar](100) NOT NULL,
 CONSTRAINT [Banks_PK] PRIMARY KEY CLUSTERED 
(
	[BankID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [Banks_Delete]
ON [dbo].[Banks] FOR Delete
AS
DECLARE @DistrictID smallint
SET @DistrictID=(SELECT DistrictID FROM Settings)
INSERT INTO [Banks_Audit]
           ([BankID]
           ,[BankName]
           ,[DistrictID]
           ,[Action])
	SELECT [BankID]
           ,[BankName]
           ,@DistrictID
           ,'D'	FROM Deleted

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [Banks_Insert]
ON [dbo].[Banks] FOR Insert
AS
DECLARE @DistrictID smallint
SET @DistrictID=(SELECT DistrictID FROM Settings)

INSERT INTO [Banks_Audit]
           ([BankID]
           ,[BankName]
           ,[DistrictID]
           ,[Action])
	SELECT [BankID]
           ,[BankName]
           ,@DistrictID
           ,'I'	FROM Inserted

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [Banks_Update]
ON [dbo].[Banks] FOR Update
AS
DECLARE @DistrictID smallint
SET @DistrictID=(SELECT DistrictID FROM Settings)

INSERT INTO [Banks_Audit]
           ([BankID]
           ,[BankName]
           ,[DistrictID]
           ,[Action])
	SELECT [BankID]
           ,[BankName]
           ,@DistrictID
           ,'U'	FROM Inserted

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetHouseTenantsByPhrase]
@phrase varchar(200)
 AS 
     SELECT * FROM dbo.HouseTenants
     WHERE FullName LIKE '%' + @phrase + '%'

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLandParcelsByTaxPayerID]
@TaxPayerID int
 AS 
     SELECT * FROM dbo.LandParcels
     WHERE TaxPayerID=@TaxPayerID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLandParcelByID]
@ID int
 AS 
     SELECT * FROM dbo.LandParcels
     WHERE LandParcelID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007   */

CREATE PROCEDURE [dbo].[GetBankAccounts]
 AS 
     SELECT * FROM dbo.BankAccounts

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[InsertBankAccounts]
@BankAccountID int, @BankBranchID smallint, @AccountNumber varchar(50), @TaxPayerID int 
AS
IF @BankAccountID=0
      BEGIN
         INSERT INTO dbo.BankAccounts(BankBranchID, AccountNumber, TaxPayerID  )
                    VALUES (@BankBranchID, @AccountNumber, @TaxPayerID )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.BankAccounts SET BankBranchID=@BankBranchID, AccountNumber=@AccountNumber, TaxPayerID=@TaxPayerID 
 WHERE BankAccountID=@BankAccountID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteBankAccounts]
 @ID int
 AS 
     DELETE FROM dbo.BankAccounts WHERE BankAccountID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBankBranches]
@ID tinyint=0
 AS 
     SELECT * FROM dbo.BankBranches
     WHERE BankID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[InsertBankBranches]
@BankBranchID smallint, @BankID tinyint, @BankBranchName varchar(50) 
AS
IF @BankBranchID=0
      BEGIN
         INSERT INTO dbo.BankBranches(BankID, BankBranchName  )
                    VALUES (@BankID, @BankBranchName )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.BankBranches SET BankID=@BankID, BankBranchName=@BankBranchName 
 WHERE BankBranchID=@BankBranchID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteBankBranches]
 @ID smallint
 AS 
     DELETE FROM dbo.BankBranches WHERE BankBranchID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007   */

CREATE PROCEDURE [dbo].[GetBusinesses]
 AS 
     SELECT * FROM dbo.Businesses

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteBusinesses]
 @ID int
 AS 
     DELETE FROM dbo.Businesses WHERE BusinessID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Properties_Audit](
	[PropertyID] [int] NOT NULL,
	[PlotNumber] [varchar](50) NULL DEFAULT (''),
	[OwnersName] [varchar](50) NULL DEFAULT (''),
	[Usage] [varchar](50) NULL DEFAULT (''),
	[DateOfAcquisition] [datetime] NOT NULL DEFAULT ('19000101'),
	[OwnerValuation] [money] NOT NULL DEFAULT ((0)),
	[DistrictValuation] [money] NOT NULL DEFAULT ((0)),
	[TaxPayerID] [int] NOT NULL,
	[Amount] [money] NOT NULL DEFAULT ((0)),
	[CellID] [smallint] NOT NULL,
	[Action] [char](1) NOT NULL,
	[Created] [datetime] NOT NULL DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetHouseTenantByID]
@ID int
 AS 
     SELECT * FROM dbo.HouseTenants
     WHERE HouseID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteDistricts]
 @ID smallint
 AS 
     DELETE FROM dbo.Districts WHERE DistrictID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007   */

CREATE PROCEDURE [dbo].[GetFeePayments]
 AS 
     SELECT * FROM dbo.FeePayments

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[InsertFeePayments]
@PaymentID bigint, @TaxPayerID int, @Designation varchar(100), @PaymentDate datetime, @Amount money 
AS
IF @PaymentID=0
      BEGIN
         INSERT INTO dbo.FeePayments(TaxPayerID, Designation, PaymentDate, Amount  )
                    VALUES (@TaxPayerID, @Designation, @PaymentDate, @Amount )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.FeePayments SET TaxPayerID=@TaxPayerID, Designation=@Designation, PaymentDate=@PaymentDate, Amount=@Amount 
 WHERE PaymentID=@PaymentID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteFeePayments]
 @ID bigint
 AS 
     DELETE FROM dbo.FeePayments WHERE PaymentID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteCells]
 @ID smallint
 AS 
     DELETE FROM dbo.Cells WHERE CellID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007   */

CREATE PROCEDURE [dbo].[GetHouseTenants]
 AS 
     SELECT * FROM dbo.HouseTenants

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banks_Audit](
	[BankID] [tinyint] NOT NULL,
	[BankName] [varchar](100) NOT NULL,
	[DistrictID] [smallint] NOT NULL,
	[Action] [char](1) NOT NULL,
	[Created] [datetime] NOT NULL DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteHouseTenants]
 @ID int
 AS 
     DELETE FROM dbo.HouseTenants WHERE HouseID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007   */

CREATE PROCEDURE [dbo].[GetLandParcels]
 AS 
     SELECT * FROM dbo.LandParcels

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankBranches_Audit](
	[BankBranchID] [smallint] NOT NULL,
	[BankID] [tinyint] NOT NULL,
	[BankBranchName] [varchar](50) NOT NULL,
	[DistrictID] [smallint] NOT NULL,
	[Action] [char](1) NOT NULL,
	[Created] [datetime] NOT NULL DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[InsertLandParcels]
@LandParcelID varchar(50), @TaxPayerID int, @PlotNumber varchar(50), 
@Year smallint, @StandingLevel varchar(50), @LandTitle varchar(50), 
@TitleNumber varchar(50), @Usage varchar(50), @NumberOfHouses smallint, 
@ContractNumber varchar(50), @ContractDate datetime ,
@Amount money
AS
IF @LandParcelID=0
      BEGIN
         INSERT INTO dbo.LandParcels(TaxPayerID, PlotNumber, Year, StandingLevel, LandTitle, TitleNumber, Usage, NumberOfHouses, ContractNumber, ContractDate,Amount )
                    VALUES (@TaxPayerID, @PlotNumber, @Year, @StandingLevel, @LandTitle, @TitleNumber, @Usage, @NumberOfHouses, @ContractNumber, @ContractDate,@Amount )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.LandParcels SET TaxPayerID=@TaxPayerID, PlotNumber=@PlotNumber, Year=@Year, StandingLevel=@StandingLevel, LandTitle=@LandTitle, 
		TitleNumber=@TitleNumber, Usage=@Usage, NumberOfHouses=@NumberOfHouses, 
		ContractNumber=@ContractNumber, ContractDate=@ContractDate,Amount=@Amount 
 WHERE LandParcelID=@LandParcelID


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteLandParcels]
 @ID varchar
 AS 
     DELETE FROM dbo.LandParcels WHERE LandParcelID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPropertyByID]
@ID int
 AS 
     SELECT * FROM dbo.Properties
     WHERE PropertyID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007   */

CREATE PROCEDURE [dbo].[GetProperties]
 AS 
     SELECT * FROM dbo.Properties

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Audit](
	[AuditID] [bigint] IDENTITY(1,1) NOT NULL,
	[AuditDate] [datetime] NOT NULL,
	[HostName] [sysname] NOT NULL,
	[SysUser] [varchar](50) NOT NULL,
	[Application] [varchar](50) NOT NULL,
	[TableName] [sysname] NOT NULL,
	[Operation] [char](1) NOT NULL,
	[PrimaryKey] [varchar](20) NOT NULL,
	[RowDescription] [varchar](50) NULL,
	[SecondaryRow] [varchar](50) NULL,
	[ColumnName] [sysname] NULL,
	[OldValue] [varchar](50) NULL,
	[NewValue] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteProperties]
 @ID int
 AS 
     DELETE FROM dbo.Properties WHERE PropertyID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[AutoAudit] (
   @SchemaName VARCHAR(50),
   @TableName VARCHAR(50)
) 
AS 
SET NoCount ON

-- script to create autoAudit triggers
DECLARE 
   @SQL NVARCHAR(max),
   @ColumnName  sysname,
   @PKColumnName sysname

-- drop existing insert trigger
SET @SQL = 'If EXISTS (Select * from sys.objects where name = '
       + '''' + @TableName + '_Audit_Insert' + ''' )'
       + ' DROP TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Insert'
EXEC (@SQL)

-- drop existing update trigger
SET @SQL = 'If EXISTS (Select * from sys.objects where name = '
       + '''' + @TableName + '_Audit_Update' + ''' )'
       + ' DROP TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Update'
EXEC (@SQL)

-- drop existing modified trigger
SET @SQL = 'If EXISTS (Select * from sys.objects where name = '
       + '''' + @TableName + '_Modified' + ''' )'
       + ' DROP TRIGGER ' + @SchemaName + '.' + @TableName + '_Modified'
EXEC (@SQL)

-- drop existing delete trigger
SET @SQL = 'If EXISTS (Select * from sys.objects where name = '
       + '''' + @TableName + '_Audit_Delete' + ''' )'
       + ' DROP TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Delete'
EXEC (@SQL)

-- drop existing delete view
SET @SQL = 'If EXISTS (Select * from sys.objects where name = '
       + '''v' + @TableName + '_Deleted' + ''' )'
       + ' DROP VIEW ' + @SchemaName + '.v' + @TableName + '_Deleted'
EXEC (@SQL)



-- add created column 
IF not exists (select *
			  from sys.tables t
				join sys.schemas s
				  on s.schema_id = t.schema_id
				join sys.columns c
				  on t.object_id = c.object_id
			  where  t.name = @TableName AND s.name = @SchemaName and c.name = 'created')
  BEGIN
    SET @SQL = 'ALTER TABLE ' + @SchemaName + '.' + @TableName + ' ADD Created DateTime NOT NULL DEFAULT(GetDate())'
    EXEC (@SQL)
  END

-- add modified column 
IF not exists( select *
			  from sys.tables t
				join sys.schemas s
				  on s.schema_id = t.schema_id
				join sys.columns c
				  on t.object_id = c.object_id
			  where  t.name = @TableName AND s.name = @SchemaName and c.name = 'modified')
  BEGIN   
    SET @SQL = 'ALTER TABLE ' + @SchemaName + '.' + @TableName + ' ADD Modified DateTime NOT NULL DEFAULT(GetDate())'
    EXEC (@SQL)
  END

-- add RowVersion column 
IF not exists( select *
			  from sys.tables t
				join sys.schemas s
				  on s.schema_id = t.schema_id
				join sys.columns c
				  on t.object_id = c.object_id
			  where  t.name = @TableName AND s.name = @SchemaName and c.name = 'RowVersion')
  BEGIN   
    SET @SQL = 'ALTER TABLE ' + @SchemaName + '.' + @TableName + ' ADD RowVersion INT NOT NULL DEFAULT(1)'
    EXEC (@SQL)
  END


-- get PK Column (1)  
select @PKColumnName = c.name
  from sys.tables t
    join sys.schemas s
      on s.schema_id = t.schema_id
    join sys.indexes i
      on t.object_id = i.object_id
    join sys.index_columns ic
  	  on i.object_id = ic.object_id
      and i.index_id = ic.index_id
    join sys.columns c
      on ic.object_id = c.object_id
      and ic.column_id = c.column_id
  where is_primary_key = 1 AND t.name = @TableName AND s.name = @SchemaName AND ic.index_column_id = 1

-- build modified trigger 
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Modified' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Update' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen ' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)

       + ' Begin Try ' + Char(13) + Char(10)
       + ' If Trigger_NestLevel(object_ID(N''[' + @SchemaName + '].[' + @TableName + '_Modified]'')) > 1 Return;' + Char(13) + Char(10)

       + ' If (Update(Created) or Update(Modified)) AND Trigger_NestLevel() = 1' + Char(13) + Char(10)
       + ' Begin; Raiserror(''Update failed.'', 16, 1); Rollback;  Return; End;' + Char(13) + Char(10)

       + ' -- Update the Modified date' + Char(13) + Char(10)
       + ' UPDATE [' + @SchemaName + '].[' + @TableName + ']'+ Char(13) + Char(10)
       + ' SET Modified = getdate(), ' + Char(13) + Char(10)
       + '        [RowVersion] = [' + @TableName + '].[RowVersion] + 1 ' + Char(13) + Char(10)
       + '   FROM [' + @SchemaName + '].[' + @TableName + ']' + Char(13) + Char(10)
       + '     JOIN Inserted'  + Char(13) + Char(10)
       + '       ON [' + @TableName + '].[' + @PKColumnName + '] = Inserted.[' + @PKColumnName + ']'
       + ' End Try ' + Char(13) + Char(10)
       + ' Begin Catch ' + Char(13) + Char(10)
       + '   Raiserror(''error in [' + + @SchemaName + '].[' + @TableName +'_modified] trigger'', 16, 1 ) with log' + Char(13) + Char(10)
       + ' End Catch ' 

print @sql 
    EXEC (@SQL)

--------------------------------------------------------------------------------------------
-- build insert trigger 
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Insert' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Insert' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen ' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)
       + ' Begin Try ' + Char(13) + Char(10)

-- for each column
	select @SQL = @SQL + 
		     '   INSERT dbo.Audit (AuditDate, SysUser, Application, Hostname, TableName, Operation, PrimaryKey, RowDescription, SecondaryRow, ColumnName, NewValue)' + Char(13) + Char(10)
          + '   SELECT  @AuditTime, suser_sname(), APP_NAME(), Host_Name(), ' 
          + '''' + @SchemaName + '.' + @TableName + ''', ''i'','   
          + ' Inserted.[' + @PKColumnName + '],' + Char(13) + Char(10) 
          + '        NULL,     -- Row Description (e.g. Order Number)' + Char(13) + Char(10)   
          + '        NULL,     -- Secondary Row Value (e.g. Oder Number for an Order Detail Line)' + Char(13) + Char(10)
          + '        ''[' + c.name + ']'','   
          + ' Cast(Inserted.[' + c.name + '] as VARCHAR(50))' + Char(13) + Char(10)
          + '          FROM Inserted' + Char(13) + Char(10)
          + '          WHERE Inserted.['+ c.name + '] is not null' + Char(13) + Char(10)+ Char(13) + Char(10)
	  from sys.tables as t
		join sys.columns as c
		  on t.object_id = c.object_id
		join sys.schemas as s
		  on s.schema_id = t.schema_id
		join sys.types as ty
		  on ty.user_type_id = c.user_type_id
		join sys.types st
		  on ty.system_type_id = st.user_type_id
      where t.name = @TableName AND s.name = @SchemaName 
         AND c.name NOT IN ('created', 'modified','RowVersion')
         AND c.is_computed = 0
        AND st.name IN ('tinyint', 'smallint', 'int', 'money', 'smallmoney', 'decimal', 'bigint', 'datetime', 'smalldateteime', 'numeric',  'varchar', 'nvarchar', 'char', 'nchar', 'bit')
	  order by c.column_id

	select @SQL = @SQL + 
       + ' End Try ' + Char(13) + Char(10)
       + ' Begin Catch ' + Char(13) + Char(10)
       + '   Raiserror(''error in [' + + @SchemaName + '].[' + @TableName +'_audit_insert] trigger'', 16, 1 ) with log' + Char(13) + Char(10)
       + ' End Catch ' 


EXEC (@SQL)

--------------------------------------------------------------------------------------------
-- build update trigger 

SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Update' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Update' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen ' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)
       + ' Begin Try ' + Char(13) + Char(10)
-- for each column
	select @SQL = @SQL + 
	   +  ' IF UPDATE([' + c.name + '])' + Char(13) + Char(10)
       + '   INSERT dbo.Audit (AuditDate, SysUser, Application, HostName, TableName, Operation, PrimaryKey, RowDescription, SecondaryRow, ColumnName, OldValue, NewValue)' + Char(13) + Char(10)
       + '   SELECT  @AuditTime, suser_sname(), APP_NAME(), Host_Name(), ' 
       + '''' + @SchemaName + '.' + @TableName + ''', ''u'','   
       + ' Inserted.[' + @PKColumnName + '],' + Char(13) + Char(10) 
       + '        NULL,     -- Row Description (e.g. Order Number)' + Char(13) + Char(10)   
       + '        NULL,     -- Secondary Row Value (e.g. Oder Number for an Order Detail Line)' + Char(13) + Char(10)
       + '        ''[' + c.name+ ']'','   
       + ' Cast(Deleted.[' + c.name + '] as VARCHAR(50)), ' 
       + ' Cast(Inserted.[' + c.name + '] as VARCHAR(50))' + Char(13) + Char(10)
       + '          FROM Inserted' + Char(13) + Char(10)
       + '             JOIN Deleted' + Char(13) + Char(10)
       + '               ON Inserted.[' + @PKColumnName + '] = Deleted.[' + @PKColumnName + ']' + Char(13) + Char(10)
       + '               AND isnull(Inserted.[' + c.name + '],'''') <> isnull(Deleted.[' + c.name + '],'''')' + Char(13) + Char(10)+ Char(13) + Char(10)
	  from sys.tables as t
		join sys.columns as c
		  on t.object_id = c.object_id
		join sys.schemas as s
		  on s.schema_id = t.schema_id
		join sys.types as ty
		  on ty.user_type_id = c.user_type_id
		join sys.types st
		  on ty.system_type_id = st.user_type_id
      where t.name = @TableName AND s.name = @SchemaName 
         AND c.name NOT IN ('created', 'modified','RowVersion')
         AND c.is_computed = 0
        AND st.name IN ('tinyint', 'smallint', 'int', 'money', 'smallmoney', 'decimal', 'bigint', 'datetime', 'smalldateteime', 'numeric',  'varchar', 'nvarchar', 'char', 'nchar', 'bit')
	  order by c.column_id

	select @SQL = @SQL + 
       + ' End Try ' + Char(13) + Char(10)
       + ' Begin Catch ' + Char(13) + Char(10)
       + '   Raiserror(''error in [' + + @SchemaName + '].[' + @TableName +'_audit_update] trigger'', 16, 1 ) with log' + Char(13) + Char(10)
       + ' End Catch ' 


EXEC (@SQL)


--------------------------
-- build delete trigger 
SET @SQL = 'CREATE TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Delete' + ' ON '+ @SchemaName + '.' + @TableName + Char(13) + Char(10)
       + ' AFTER Delete' + Char(13) + Char(10) + ' NOT FOR REPLICATION AS' + Char(13) + Char(10)
       + ' SET NoCount On ' + Char(13) + Char(10)
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen ' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'DECLARE @AuditTime DATETIME' + Char(13) + Char(10)
       + 'SET @AuditTime = GetDate()' + Char(13) + Char(10) + Char(13) + Char(10)
       + ' Begin Try ' + Char(13) + Char(10)

-- for each column
	select @SQL = @SQL + 
		     '   INSERT dbo.Audit (AuditDate, SysUser, Application, HostName, TableName, Operation, PrimaryKey, RowDescription, SecondaryRow, ColumnName, OldValue)' + Char(13) + Char(10)
          + '   SELECT  @AuditTime, suser_sname(), APP_NAME(), Host_Name(),' 
          + '''' + @SchemaName + '.' + @TableName + ''', ''d'','   
          + ' deleted.[' + @PKColumnName + '],' + Char(13) + Char(10) 
          + '        NULL,     -- Row Description (e.g. Order Number)' + Char(13) + Char(10)   
          + '        NULL,     -- Secondary Row Value (e.g. Oder Number for an Order Detail Line)' + Char(13) + Char(10)
          + '        ''[' + c.name + ']'','   
          + ' Cast(deleted.[' + c.name + '] as VARCHAR(50))' + Char(13) + Char(10)
          + '          FROM deleted' + Char(13) + Char(10)
          + '          WHERE deleted.['+ c.name + '] is not null' + Char(13) + Char(10)+ Char(13) + Char(10)
	  from sys.tables as t
		join sys.columns as c
		  on t.object_id = c.object_id
		join sys.schemas as s
		  on s.schema_id = t.schema_id
		join sys.types as ty
		  on ty.user_type_id = c.user_type_id
		join sys.types st
		  on ty.system_type_id = st.user_type_id
      where t.name = @TableName AND s.name = @SchemaName 
         -- AND c.name NOT IN ('created', 'modified','RowVersion')
         AND c.is_computed = 0
        AND st.name IN ('tinyint', 'smallint', 'int', 'money', 'smallmoney', 'decimal', 'bigint', 'datetime', 'smalldateteime', 'numeric',  'varchar', 'nvarchar', 'char', 'nchar', 'bit')
	  order by c.column_id

	select @SQL = @SQL + 
       + ' End Try ' + Char(13) + Char(10)
       + ' Begin Catch ' + Char(13) + Char(10)
       + '   Raiserror(''error in [' + + @SchemaName + '].[' + @TableName +'_audit_delete trigger'', 16, 1 ) with log' + Char(13) + Char(10)
       + ' End Catch ' 

EXEC (@SQL)


--------------------------------------------------------------------------------------------
-- build _Deleted view

/* Sample: 
CREATE VIEW Production.vCulture_Deleted
as
	SELECT 
		Max(Case ColumnName WHEN '[CultureID]' THEN OldValue ELSE '' END) AS [CultureID],
		Max(Case ColumnName WHEN '[Name]' THEN OldValue ELSE '' END) AS [Name],
		Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
		Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS Modified,
		Max(Case ColumnName WHEN '[Rowversion]' THEN OldValue ELSE '' END) AS [Rowversion],
        MAX(AuditDate) AS 'Deleted'
	FROM Audit 
	Where TableName = 'Production.Culture' AND Operation = 'd'
	GROUP BY PrimaryKey 
*/

SET @SQL = 'CREATE VIEW ' + @SchemaName + '.v' + @TableName + '_Deleted' + Char(13) + Char(10)
       + 'AS ' + Char(13) + Char(10) 
       + ' -- generated by AutoAudit on ' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + ' -- created by Paul Nielsen ' + Char(13) + Char(10)
       + ' -- www.SQLServerBible.com ' + Char(13) + Char(10) + Char(13) + Char(10)
       + 'SELECT ' + Char(13) + Char(10)

-- for each column
SELECT @SQL = @SQL +
		  '     Max(Case ColumnName WHEN ''[' + c.name + ']'' THEN OldValue ELSE '''' END) AS [' + c.name +'],'  + Char(13) + Char(10)
	  from sys.tables as t
		join sys.columns as c
		  on t.object_id = c.object_id
		join sys.schemas as s
		  on s.schema_id = t.schema_id
		join sys.types as ty
		  on ty.user_type_id = c.user_type_id
		join sys.types st
		  on ty.system_type_id = st.user_type_id
      where t.name = @TableName AND s.name = @SchemaName 
         AND c.is_computed = 0
        AND st.name IN ('tinyint', 'smallint', 'int', 'money', 'smallmoney', 'decimal', 'bigint', 'datetime', 'smalldateteime', 'numeric',  'varchar', 'nvarchar', 'char', 'nchar', 'bit')
	  order by c.column_id

SET @SQL = @SQL
        + '      MAX(AuditDate) AS ''Deleted'''  + Char(13) + Char(10)
	    + '  FROM Audit'   + Char(13) + Char(10)
	    + '  Where TableName = ''' +@SchemaName + '.' + @TableName + ''' AND Operation = ''d'''  + Char(13) + Char(10)
	    + '  GROUP BY PrimaryKey' 

EXEC (@SQL)

RETURN -- END OF SPROC


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteProvinces]
 @ID tinyint
 AS 
     DELETE FROM dbo.Provinces WHERE ProvinceID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
CREATE PROC [dbo].[AutoAuditDrop] (
   @SchemaName VARCHAR(50),
   @TableName VARCHAR(50)
) 
AS 
SET NoCount ON

DECLARE 
   @SQL NVARCHAR(max)

-- drop existing insert trigger
SET @SQL = 'If EXISTS (Select * from sys.objects where name = '
       + '''' + @TableName + '_Audit_Insert' + ''' )'
       + ' DROP TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Insert'
EXEC (@SQL)

-- drop existing update trigger
SET @SQL = 'If EXISTS (Select * from sys.objects where name = '
       + '''' + @TableName + '_Audit_Update' + ''' )'
       + ' DROP TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Update'
EXEC (@SQL)

-- drop existing modified trigger
SET @SQL = 'If EXISTS (Select * from sys.objects where name = '
       + '''' + @TableName + '_Modified' + ''' )'
       + ' DROP TRIGGER ' + @SchemaName + '.' + @TableName + '_Modified'
EXEC (@SQL)

-- drop existing delete trigger
SET @SQL = 'If EXISTS (Select * from sys.objects where name = '
       + '''' + @TableName + '_Audit_Delete' + ''' )'
       + ' DROP TRIGGER ' + @SchemaName + '.' + @TableName + '_Audit_Delete'
EXEC (@SQL)


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
CREATE PROC [dbo].[AutoAuditAll] 
AS 
SET NoCount ON 
DECLARE 
   @TableName VARCHAR(50), 
   @SchemaName VARCHAR(50), 
   @SQL NVARCHAR(max)
-- for each table
-- 1
DECLARE cTables CURSOR FAST_FORWARD READ_ONLY
  FOR  SELECT s.name, t.name 
			  from sys.tables t
				join sys.schemas s
				  on t.schema_id = s.schema_id
			 where t.name <> 'audit'
--2 
OPEN cTables
--3 
FETCH cTables INTO @SchemaName, @TableName   -- prime the cursor
WHILE @@Fetch_Status = 0 
  BEGIN
		SET @SQL = 'EXEC AutoAudit ''' + @SchemaName + ''', ''' + @TableName + ''''
		EXEC (@SQL)
      FETCH cTables INTO @SchemaName, @TableName   -- fetch next
  END
-- 4  
CLOSE cTables
-- 5
DEALLOCATE cTables


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
CREATE PROC [dbo].[AutoAuditDropAll] 
AS 
SET NoCount ON 
DECLARE 
   @TableName VARCHAR(50), 
   @SchemaName VARCHAR(50), 
   @SQL NVARCHAR(max)
-- for each table
-- 1
DECLARE cTables CURSOR FAST_FORWARD READ_ONLY
  FOR  SELECT s.name, t.name 
			  from sys.tables t
				join sys.schemas s
				  on t.schema_id = s.schema_id
			 where t.name <> 'audit'
--2 
OPEN cTables
--3 
FETCH cTables INTO @SchemaName, @TableName   -- prime the cursor
WHILE @@Fetch_Status = 0 
  BEGIN
		SET @SQL = 'EXEC AutoAuditDrop ''' + @SchemaName + ''', ''' + @TableName + ''''
		EXEC (@SQL)
      FETCH cTables INTO @SchemaName, @TableName   -- fetch next
  END
-- 4  
CLOSE cTables
-- 5
DEALLOCATE cTables

-- end of file





GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteSectors]
 @ID smallint
 AS 
     DELETE FROM dbo.Sectors WHERE SectorID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteTaxPayers]
 @ID int
 AS 
     DELETE FROM dbo.TaxPayers WHERE TaxPayerID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteTaxPayments]
 @ID bigint
 AS 
     DELETE FROM dbo.TaxPayments WHERE PaymentID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteUsers]
 @ID smallint
 AS 
     DELETE FROM dbo.Users WHERE UserID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provinces](
	[ProvinceID] [tinyint] IDENTITY(1,1) NOT NULL,
	[ProvinceName] [varchar](50) NOT NULL,
	[Created] [datetime] NOT NULL DEFAULT (getdate()),
	[Modified] [datetime] NOT NULL DEFAULT (getdate()),
	[RowVersion] [int] NOT NULL DEFAULT ((1)),
 CONSTRAINT [Provinces_PK] PRIMARY KEY CLUSTERED 
(
	[ProvinceID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007   */

CREATE PROCEDURE [dbo].[GetUsers]
 AS 
     SELECT * FROM dbo.Users

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings](
	[DistrictID] [smallint] NOT NULL DEFAULT ((0)),
	[ProvinceID] [smallint] NOT NULL DEFAULT ((0))
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaxPayers_Audit](
	[TaxPayerID] [int] NOT NULL,
	[CellID] [smallint] NOT NULL,
	[FileNumber] [varchar](30) NOT NULL CONSTRAINT [DF_TaxPayers_Audit_FileNumber]  DEFAULT (''),
	[Address] [varchar](100) NOT NULL CONSTRAINT [DF_TaxPayers_Audit_Address]  DEFAULT (''),
	[Telephone] [varchar](30) NOT NULL CONSTRAINT [DF_TaxPayers_Audit_Telephone]  DEFAULT (''),
	[Mobile] [varchar](30) NOT NULL CONSTRAINT [DF_TaxPayers_Audit_Mobile]  DEFAULT (''),
	[Profession] [varchar](50) NOT NULL CONSTRAINT [DF_TaxPayers_Audit_Profession]  DEFAULT (''),
	[DateOfBirth] [datetime] NOT NULL CONSTRAINT [DF_TaxPayers_Audit_DateOfBirth]  DEFAULT (getdate()),
	[IDNumber] [varchar](20) NOT NULL CONSTRAINT [DF_TaxPayers_Audit_IDNumber]  DEFAULT (''),
	[IDType] [varchar](20) NOT NULL CONSTRAINT [DF_TaxPayers_Audit_IDType]  DEFAULT ('Identity Card'),
	[TIN] [varchar](50) NOT NULL CONSTRAINT [DF_TaxPayers_Audit_TIN]  DEFAULT (''),
	[Email] [varchar](100) NOT NULL CONSTRAINT [DF_TaxPayers_Audit_Email]  DEFAULT (''),
	[Names] [varchar](100) NOT NULL CONSTRAINT [DF_TaxPayers_Audit_Names]  DEFAULT (''),
	[Action] [char](1) NOT NULL,
	[Created] [datetime] NOT NULL DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaxPayments_Audit](
	[PaymentID] [bigint] NOT NULL,
	[TaxPayerID] [int] NOT NULL,
	[PaymentDate] [datetime] NOT NULL DEFAULT (getdate()),
	[Amount] [money] NOT NULL DEFAULT ((0)),
	[Description] [varchar](100) NOT NULL DEFAULT (''),
	[Cashier] [varchar](50) NOT NULL DEFAULT (''),
	[TaxTypeID] [tinyint] NOT NULL DEFAULT ((0)),
	[CellID] [smallint] NOT NULL,
	[Action] [char](1) NOT NULL,
	[Created] [datetime] NOT NULL DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeePayments_Audit](
	[PaymentID] [bigint] NOT NULL,
	[TaxPayerID] [int] NOT NULL,
	[Designation] [varchar](100) NOT NULL DEFAULT (''),
	[PaymentDate] [datetime] NOT NULL DEFAULT (getdate()),
	[Amount] [money] NOT NULL DEFAULT ((0)),
	[CellID] [smallint] NOT NULL,
	[Action] [char](1) NOT NULL,
	[Created] [datetime] NOT NULL DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankAccounts_Audit](
	[BankAccountID] [int] NOT NULL,
	[BankBranchID] [smallint] NOT NULL,
	[AccountNumber] [varchar](50) NOT NULL,
	[TaxPayerID] [int] NOT NULL,
	[CellID] [smallint] NOT NULL,
	[Action] [char](1) NOT NULL,
	[Created] [datetime] NOT NULL DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Businesses_Audit](
	[BusinessID] [int] NOT NULL,
	[PlotNumber] [varchar](50) NULL DEFAULT (''),
	[BusinessName] [varchar](100) NULL DEFAULT (''),
	[Profession] [varchar](100) NULL DEFAULT (''),
	[StartDate] [datetime] NOT NULL,
	[Amount] [money] NOT NULL DEFAULT ((0)),
	[Address] [varchar](100) NULL DEFAULT (''),
	[TaxPayerID] [int] NOT NULL,
	[CellID] [smallint] NOT NULL,
	[Action] [char](1) NOT NULL,
	[Created] [datetime] NOT NULL DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HouseTenants_Audit](
	[HouseID] [int] NOT NULL,
	[PlotNumber] [int] NOT NULL DEFAULT (''),
	[FullName] [varchar](50) NULL DEFAULT (''),
	[Telephone] [varchar](30) NULL DEFAULT (''),
	[Address] [varchar](100) NULL DEFAULT (''),
	[Amount] [money] NOT NULL DEFAULT ((0)),
	[TaxPayerID] [int] NOT NULL,
	[CellID] [smallint] NOT NULL,
	[Action] [char](1) NOT NULL,
	[Created] [datetime] NOT NULL DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaxTypes](
	[TaxTypeID] [tinyint] IDENTITY(1,1) NOT NULL,
	[TaxTypeName] [varchar](50) NOT NULL CONSTRAINT [DF_TaxTypes_TaxTypeName]  DEFAULT (''),
	[Created] [datetime] NOT NULL DEFAULT (getdate()),
	[Modified] [datetime] NOT NULL DEFAULT (getdate()),
	[RowVersion] [int] NOT NULL DEFAULT ((1)),
 CONSTRAINT [PK_TaxTypes] PRIMARY KEY CLUSTERED 
(
	[TaxTypeID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LandParcels_Audit](
	[LandParcelID] [int] NOT NULL,
	[TaxPayerID] [int] NOT NULL,
	[PlotNumber] [varchar](50) NOT NULL DEFAULT (''),
	[Year] [smallint] NOT NULL DEFAULT ((0)),
	[StandingLevel] [varchar](50) NOT NULL DEFAULT (''),
	[LandTitle] [varchar](50) NOT NULL DEFAULT (''),
	[TitleNumber] [varchar](50) NOT NULL DEFAULT (''),
	[Usage] [varchar](50) NOT NULL DEFAULT (''),
	[NumberOfHouses] [smallint] NOT NULL DEFAULT ((0)),
	[ContractNumber] [varchar](50) NOT NULL DEFAULT (''),
	[ContractDate] [datetime] NOT NULL DEFAULT ('19000101'),
	[Amount] [money] NOT NULL DEFAULT ((0)),
	[CellID] [smallint] NOT NULL,
	[Action] [char](1) NOT NULL,
	[Created] [datetime] NOT NULL DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBusinessesByPhrase]
@phrase varchar(200)
 AS 
     SELECT * FROM dbo.Businesses
		WHERE BusinessName Like '%' +  @phrase + '%'

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLandParcelsByPhrase]
@phrase varchar(200)
 AS 
     SELECT * FROM dbo.LandParcels
     WHERE PlotNumber Like '%' + @phrase + '%'

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPermissions](
	[UserPermissionID] [smallint] NOT NULL,
	[UserID] [smallint] NULL,
	[PermissionID] [tinyint] NULL,
	[Created] [datetime] NOT NULL DEFAULT (getdate()),
	[Modified] [datetime] NOT NULL DEFAULT (getdate()),
	[RowVersion] [int] NOT NULL DEFAULT ((1)),
 CONSTRAINT [UserPermissions_PK] PRIMARY KEY CLUSTERED 
(
	[UserPermissionID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankBranches](
	[BankBranchID] [smallint] IDENTITY(1,1) NOT NULL,
	[BankID] [tinyint] NOT NULL,
	[BankBranchName] [varchar](50) NOT NULL,
 CONSTRAINT [BankBranches_PK] PRIMARY KEY CLUSTERED 
(
	[BankBranchID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [BankBranches_Delete]
ON [dbo].[BankBranches] FOR DELETE
AS
DECLARE @DistrictID smallint
SET @DistrictID=(SELECT DistrictID FROM Settings)

INSERT INTO [BankBranches_Audit]
           ([BankBranchID]
           ,[BankID]
           ,[BankBranchName]
           ,[DistrictID]
           ,[Action])
	SELECT [BankBranchID]
           ,[BankID]
           ,[BankBranchName]
           ,@DistrictID
           ,'D'	FROM deleted

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [BankBranches_Insert]
ON [dbo].[BankBranches] FOR Insert
AS
DECLARE @DistrictID smallint
SET @DistrictID=(SELECT DistrictID FROM Settings)

INSERT INTO [BankBranches_Audit]
           ([BankBranchID]
           ,[BankID]
           ,[BankBranchName]
           ,[DistrictID]
           ,[Action])
	SELECT [BankBranchID]
           ,[BankID]
           ,[BankBranchName]
           ,@DistrictID
           ,'I'	FROM Inserted

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [BankBranches_Update]
ON [dbo].[BankBranches] FOR Update
AS
DECLARE @DistrictID smallint
SET @DistrictID=(SELECT DistrictID FROM Settings)

INSERT INTO [BankBranches_Audit]
           ([BankBranchID]
           ,[BankID]
           ,[BankBranchName]
           ,[DistrictID]
           ,[Action])
	SELECT [BankBranchID]
           ,[BankID]
           ,[BankBranchName]
           ,@DistrictID
           ,'U'	FROM Inserted

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Districts](
	[DistrictID] [smallint] IDENTITY(1,1) NOT NULL,
	[ProvinceID] [tinyint] NOT NULL,
	[DistrictName] [varchar](50) NOT NULL,
	[Created] [datetime] NOT NULL DEFAULT (getdate()),
	[Modified] [datetime] NOT NULL DEFAULT (getdate()),
	[RowVersion] [int] NOT NULL DEFAULT ((1)),
 CONSTRAINT [Districts_PK] PRIMARY KEY CLUSTERED 
(
	[DistrictID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankAccounts](
	[BankAccountID] [int] IDENTITY(1,1) NOT NULL,
	[BankBranchID] [smallint] NOT NULL,
	[AccountNumber] [varchar](50) NOT NULL,
	[TaxPayerID] [int] NOT NULL,
 CONSTRAINT [BankAccounts_PK] PRIMARY KEY CLUSTERED 
(
	[BankAccountID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [BankAccounts_Delete]
ON [dbo].[BankAccounts] FOR DELETE
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN deleted i
				ON t.TaxpayerID=i.TaxpayerID)

INSERT INTO [BankAccounts_Audit]
           ([BankAccountID]
           ,[BankBranchID]
           ,[AccountNumber]
           ,[TaxPayerID]
           ,[CellID]
           ,[Action])
	SELECT [BankAccountID]
           ,[BankBranchID]
           ,[AccountNumber]
           ,[TaxPayerID]
           ,@CellID
           ,'D' FROM deleted

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [BankAccounts_Insert]
ON [dbo].[BankAccounts] FOR INSERT
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN inserted i
				ON t.TaxpayerID=i.TaxpayerID)

INSERT INTO [BankAccounts_Audit]
           ([BankAccountID]
           ,[BankBranchID]
           ,[AccountNumber]
           ,[TaxPayerID]
           ,[CellID]
           ,[Action])
	SELECT [BankAccountID]
           ,[BankBranchID]
           ,[AccountNumber]
           ,[TaxPayerID]
           ,@CellID
           ,'I' FROM inserted

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [BankAccounts_Update]
ON [dbo].[BankAccounts] FOR UPDATE
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN inserted i
				ON t.TaxpayerID=i.TaxpayerID)

INSERT INTO [BankAccounts_Audit]
           ([BankAccountID]
           ,[BankBranchID]
           ,[AccountNumber]
           ,[TaxPayerID]
           ,[CellID]
           ,[Action])
	SELECT [BankAccountID]
           ,[BankBranchID]
           ,[AccountNumber]
           ,[TaxPayerID]
           ,@CellID
           ,'U' FROM inserted

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sectors](
	[SectorID] [smallint] IDENTITY(1,1) NOT NULL,
	[DistrictID] [smallint] NOT NULL,
	[SectorName] [varchar](50) NOT NULL,
 CONSTRAINT [Sectors_PK] PRIMARY KEY CLUSTERED 
(
	[SectorID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [smallint] IDENTITY(1,1) NOT NULL,
	[DistrictID] [smallint] NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](200) NOT NULL CONSTRAINT [DF_Users_Password]  DEFAULT (''),
	[FullName] [varchar](50) NOT NULL CONSTRAINT [DF_Users_FullName]  DEFAULT (''),
	[Status] [bit] NOT NULL CONSTRAINT [DF_Users_Status]  DEFAULT ((0)),
	[Created] [datetime] NOT NULL DEFAULT (getdate()),
	[Modified] [datetime] NOT NULL DEFAULT (getdate()),
	[RowVersion] [int] NOT NULL DEFAULT ((1)),
 CONSTRAINT [Users_PK] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cells](
	[CellID] [smallint] IDENTITY(1,1) NOT NULL,
	[SectorID] [smallint] NOT NULL,
	[CellName] [varchar](50) NOT NULL,
	[Created] [datetime] NOT NULL DEFAULT (getdate()),
	[Modified] [datetime] NOT NULL DEFAULT (getdate()),
	[RowVersion] [int] NOT NULL DEFAULT ((1)),
 CONSTRAINT [Cells_PK] PRIMARY KEY CLUSTERED 
(
	[CellID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaxPayers](
	[TaxPayerID] [int] IDENTITY(1,1) NOT NULL,
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
	[TaxPayerID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [TaxPayers_Audit_Delete]
ON [dbo].[TaxPayers] FOR DELETE
AS
INSERT INTO [TaxPayers_Audit](
			[TaxPayerID],[CellID],[FileNumber] ,[Address]
           ,[Telephone] ,[Mobile],[Profession] ,[DateOfBirth]
           ,[IDNumber],[IDType],[TIN],[Email],[Names],[Action])
     SELECT [TaxPayerID],[CellID],[FileNumber],[Address]
           ,[Telephone] ,[Mobile],[Profession],[DateOfBirth]
           ,[IDNumber]  ,[IDType],[TIN],[Email],[Names],'D' 
			FROM deleted
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [TaxPayers_Audit_Insert]
ON [dbo].[TaxPayers] FOR INSERT
AS
INSERT INTO [TaxPayers_Audit](
			[TaxPayerID],[CellID],[FileNumber] ,[Address]
           ,[Telephone] ,[Mobile],[Profession] ,[DateOfBirth]
           ,[IDNumber],[IDType],[TIN],[Email],[Names],[Action])
     SELECT [TaxPayerID],[CellID],[FileNumber],[Address]
           ,[Telephone] ,[Mobile],[Profession],[DateOfBirth]
           ,[IDNumber]  ,[IDType],[TIN],[Email],[Names],'I' 
			FROM inserted
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [TaxPayers_Audit_Update]
ON [dbo].[TaxPayers] FOR UPDATE
AS
INSERT INTO [TaxPayers_Audit](
			[TaxPayerID],[CellID],[FileNumber] ,[Address]
           ,[Telephone] ,[Mobile],[Profession] ,[DateOfBirth]
           ,[IDNumber],[IDType],[TIN],[Email],[Names],[Action])
     SELECT [TaxPayerID],[CellID],[FileNumber],[Address]
           ,[Telephone] ,[Mobile],[Profession],[DateOfBirth]
           ,[IDNumber]  ,[IDType],[TIN],[Email],[Names],'U' 
			FROM inserted
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaxPayments](
	[PaymentID] [bigint] IDENTITY(1,1) NOT NULL,
	[TaxPayerID] [int] NOT NULL,
	[PaymentDate] [datetime] NOT NULL,
	[Amount] [money] NOT NULL,
	[Description] [varchar](100) NOT NULL,
	[Cashier] [varchar](50) NOT NULL CONSTRAINT [DF_TaxPayments_Cashier]  DEFAULT (''),
	[TaxTypeID] [tinyint] NOT NULL CONSTRAINT [DF_TaxPayments_TaxTypeID]  DEFAULT ((0)),
 CONSTRAINT [TaxPayments_PK] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [TaxPayments_Audit_Delete]
ON [dbo].[TaxPayments]
FOR DELETE
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN deleted i
				ON t.TaxpayerID=i.TaxpayerID)

INSERT INTO [TaxPayments_Audit]
           ([PaymentID]
           ,[TaxPayerID]
           ,[PaymentDate]
           ,[Amount]
           ,[Description]
           ,[Cashier]
           ,[TaxTypeID]
           ,[CellID]
           ,[Action])
     SELECT 
			[PaymentID]
           ,[TaxPayerID]
           ,[PaymentDate]
           ,[Amount]
           ,[Description]
           ,[Cashier]
           ,[TaxTypeID]
           ,@CellID
           ,'D' FROM deleted
           
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [TaxPayments_Audit_Insert]
ON [dbo].[TaxPayments]
FOR INSERT
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN Inserted i
				ON t.TaxpayerID=i.TaxpayerID)

INSERT INTO [TaxPayments_Audit]
           ([PaymentID]
           ,[TaxPayerID]
           ,[PaymentDate]
           ,[Amount]
           ,[Description]
           ,[Cashier]
           ,[TaxTypeID]
           ,[CellID]
           ,[Action])
     SELECT 
			[PaymentID]
           ,[TaxPayerID]
           ,[PaymentDate]
           ,[Amount]
           ,[Description]
           ,[Cashier]
           ,[TaxTypeID]
           ,@CellID
           ,'I' FROM inserted
           
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [TaxPayments_Audit_Update]
ON [dbo].[TaxPayments]
FOR UPDATE
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN Inserted i
				ON t.TaxpayerID=i.TaxpayerID)

INSERT INTO [TaxPayments_Audit]
           ([PaymentID]
           ,[TaxPayerID]
           ,[PaymentDate]
           ,[Amount]
           ,[Description]
           ,[Cashier]
           ,[TaxTypeID]
           ,[CellID]
           ,[Action])
     SELECT 
			[PaymentID]
           ,[TaxPayerID]
           ,[PaymentDate]
           ,[Amount]
           ,[Description]
           ,[Cashier]
           ,[TaxTypeID]
           ,@CellID
           ,'U' FROM inserted
           
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HouseTenants](
	[HouseID] [int] IDENTITY(1,1) NOT NULL,
	[PlotNumber] [int] NOT NULL CONSTRAINT [DF_HouseTenants_PlotNumber]  DEFAULT (''),
	[FullName] [varchar](50) NOT NULL CONSTRAINT [DF_HouseTenants_FullName]  DEFAULT (''),
	[Telephone] [varchar](30) NOT NULL CONSTRAINT [DF_HouseTenants_Telephone]  DEFAULT (''),
	[Address] [varchar](100) NOT NULL CONSTRAINT [DF_HouseTenants_Address]  DEFAULT (''),
	[Amount] [money] NOT NULL CONSTRAINT [DF_HouseTenants_Amount]  DEFAULT ((0)),
	[TaxPayerID] [int] NOT NULL,
 CONSTRAINT [HouseTenants_PK] PRIMARY KEY CLUSTERED 
(
	[HouseID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [HouseTenants_Delete]
ON [dbo].[HouseTenants] FOR Delete
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN Deleted i
				ON t.TaxpayerID=i.TaxpayerID)

INSERT INTO [HouseTenants_Audit]
           ([HouseID]
           ,[PlotNumber]
           ,[FullName]
           ,[Telephone]
           ,[Address]
           ,[Amount]
           ,[TaxPayerID]
           ,[CellID]
           ,[Action])
SELECT [HouseID]
           ,[PlotNumber]
           ,[FullName]
           ,[Telephone]
           ,[Address]
           ,[Amount]
           ,[TaxPayerID]
           ,@CellID ,'D'
		FROM Deleted

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [HouseTenants_Insert]
ON [dbo].[HouseTenants] FOR INSERT
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN inserted i
				ON t.TaxpayerID=i.TaxpayerID)

INSERT INTO [HouseTenants_Audit]
           ([HouseID]
           ,[PlotNumber]
           ,[FullName]
           ,[Telephone]
           ,[Address]
           ,[Amount]
           ,[TaxPayerID]
           ,[CellID]
           ,[Action])
SELECT [HouseID]
           ,[PlotNumber]
           ,[FullName]
           ,[Telephone]
           ,[Address]
           ,[Amount]
           ,[TaxPayerID]
           ,@CellID ,'I'
		FROM inserted

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [HouseTenants_update]
ON [dbo].[HouseTenants] FOR update
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN inserted i
				ON t.TaxpayerID=i.TaxpayerID)

INSERT INTO [HouseTenants_Audit]
           ([HouseID]
           ,[PlotNumber]
           ,[FullName]
           ,[Telephone]
           ,[Address]
           ,[Amount]
           ,[TaxPayerID]
           ,[CellID]
           ,[Action])
SELECT [HouseID]
           ,[PlotNumber]
           ,[FullName]
           ,[Telephone]
           ,[Address]
           ,[Amount]
           ,[TaxPayerID]
           ,@CellID ,'U'
		FROM inserted

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LandParcels](
	[LandParcelID] [int] IDENTITY(1,1) NOT NULL,
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
 CONSTRAINT [LandParcels_PK] PRIMARY KEY CLUSTERED 
(
	[LandParcelID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [LandParcels_Delete]
ON [dbo].[LandParcels] FOR Delete
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN Deleted i
				ON t.TaxpayerID=i.TaxpayerID)

INSERT INTO [LandParcels_Audit]
           ([LandParcelID]
           ,[TaxPayerID]
           ,[PlotNumber]
           ,[Year]
           ,[StandingLevel]
           ,[LandTitle]
           ,[TitleNumber]
           ,[Usage]
           ,[NumberOfHouses]
           ,[ContractNumber]
           ,[ContractDate]
           ,[Amount]
           ,[CellID]
           ,[Action])
SELECT [LandParcelID]
           ,[TaxPayerID]
           ,[PlotNumber]
           ,[Year]
           ,[StandingLevel]
           ,[LandTitle]
           ,[TitleNumber]
           ,[Usage]
           ,[NumberOfHouses]
           ,[ContractNumber]
           ,[ContractDate]
           ,[Amount]
           ,@CellID
           ,'D'	FROM Deleted

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [LandParcels_Insert]
ON [dbo].[LandParcels] FOR Insert
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN Inserted i
				ON t.TaxpayerID=i.TaxpayerID)

INSERT INTO [LandParcels_Audit]
           ([LandParcelID]
           ,[TaxPayerID]
           ,[PlotNumber]
           ,[Year]
           ,[StandingLevel]
           ,[LandTitle]
           ,[TitleNumber]
           ,[Usage]
           ,[NumberOfHouses]
           ,[ContractNumber]
           ,[ContractDate]
           ,[Amount]
           ,[CellID]
           ,[Action])
SELECT [LandParcelID]
           ,[TaxPayerID]
           ,[PlotNumber]
           ,[Year]
           ,[StandingLevel]
           ,[LandTitle]
           ,[TitleNumber]
           ,[Usage]
           ,[NumberOfHouses]
           ,[ContractNumber]
           ,[ContractDate]
           ,[Amount]
           ,@CellID
           ,'I'	FROM Inserted

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [LandParcels_Update]
ON [dbo].[LandParcels] FOR Update
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN Inserted i
				ON t.TaxpayerID=i.TaxpayerID)

INSERT INTO [LandParcels_Audit]
           ([LandParcelID]
           ,[TaxPayerID]
           ,[PlotNumber]
           ,[Year]
           ,[StandingLevel]
           ,[LandTitle]
           ,[TitleNumber]
           ,[Usage]
           ,[NumberOfHouses]
           ,[ContractNumber]
           ,[ContractDate]
           ,[Amount]
           ,[CellID]
           ,[Action])
SELECT [LandParcelID]
           ,[TaxPayerID]
           ,[PlotNumber]
           ,[Year]
           ,[StandingLevel]
           ,[LandTitle]
           ,[TitleNumber]
           ,[Usage]
           ,[NumberOfHouses]
           ,[ContractNumber]
           ,[ContractDate]
           ,[Amount]
           ,@CellID
           ,'U'	FROM Inserted

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeePayments](
	[PaymentID] [bigint] IDENTITY(1,1) NOT NULL,
	[TaxPayerID] [int] NOT NULL,
	[Designation] [varchar](100) NOT NULL,
	[PaymentDate] [datetime] NOT NULL,
	[Amount] [money] NOT NULL,
 CONSTRAINT [FeePayments_PK] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [FeePayments_Delete]
ON [dbo].[FeePayments] FOR DELETE
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN deleted i
				ON t.TaxpayerID=i.TaxpayerID)
INSERT INTO [FeePayments_Audit]
           ([PaymentID]
           ,[TaxPayerID]
           ,[Designation]
           ,[PaymentDate]
           ,[Amount]
           ,[CellID]
           ,[Action])
     SELECT [PaymentID]
           ,[TaxPayerID]
           ,[Designation]
           ,[PaymentDate]
           ,[Amount]
           ,@CellID
           ,'D' FROM deleted

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [FeePayments_Insert]
ON [dbo].[FeePayments] FOR INSERT
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN Inserted i
				ON t.TaxpayerID=i.TaxpayerID)
INSERT INTO [FeePayments_Audit]
           ([PaymentID]
           ,[TaxPayerID]
           ,[Designation]
           ,[PaymentDate]
           ,[Amount]
           ,[CellID]
           ,[Action])
     SELECT [PaymentID]
           ,[TaxPayerID]
           ,[Designation]
           ,[PaymentDate]
           ,[Amount]
           ,@CellID
           ,'I' FROM inserted

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [FeePayments_Update]
ON [dbo].[FeePayments] FOR UPDATE
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN Inserted i
				ON t.TaxpayerID=i.TaxpayerID)
INSERT INTO [FeePayments_Audit]
           ([PaymentID]
           ,[TaxPayerID]
           ,[Designation]
           ,[PaymentDate]
           ,[Amount]
           ,[CellID]
           ,[Action])
     SELECT [PaymentID]
           ,[TaxPayerID]
           ,[Designation]
           ,[PaymentDate]
           ,[Amount]
           ,@CellID
           ,'U' FROM inserted

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Properties](
	[PropertyID] [int] IDENTITY(1,1) NOT NULL,
	[PlotNumber] [varchar](50) NOT NULL CONSTRAINT [DF_Properties_PlotNumber]  DEFAULT (''),
	[OwnersName] [varchar](50) NOT NULL CONSTRAINT [DF_Properties_OwnersName]  DEFAULT (''),
	[Usage] [varchar](50) NOT NULL CONSTRAINT [DF_Properties_Usage]  DEFAULT (''),
	[DateOfAcquisition] [datetime] NOT NULL CONSTRAINT [DF_Properties_DateOfAcquisition]  DEFAULT (getdate()),
	[OwnerValuation] [money] NOT NULL CONSTRAINT [DF_Properties_OwnerValuation]  DEFAULT ((0)),
	[DistrictValuation] [money] NOT NULL CONSTRAINT [DF_Properties_DistrictValuation]  DEFAULT ((0)),
	[TaxPayerID] [int] NOT NULL,
	[Amount] [money] NOT NULL DEFAULT ((0)),
 CONSTRAINT [Properties_PK] PRIMARY KEY CLUSTERED 
(
	[PropertyID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [Properties_Delete]
ON [dbo].[Properties] FOR Delete
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN Deleted i
				ON t.TaxpayerID=i.TaxpayerID)
INSERT INTO [Properties_Audit]
 ([PropertyID] ,[PlotNumber]
 ,[OwnersName] ,[Usage]
 ,[DateOfAcquisition] ,[OwnerValuation]
 ,[DistrictValuation] ,[TaxPayerID]
 ,[Amount] ,[CellID]
 ,[Action])
SELECT [PropertyID] ,[PlotNumber]
 ,[OwnersName] ,[Usage]
 ,[DateOfAcquisition] ,[OwnerValuation]
 ,[DistrictValuation] ,[TaxPayerID]
 ,[Amount] ,@CellID
 ,'D'	FROM Deleted

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [Properties_Insert]
ON [dbo].[Properties] FOR Insert
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN Inserted i
				ON t.TaxpayerID=i.TaxpayerID)
INSERT INTO [Properties_Audit]
           ([PropertyID]
           ,[PlotNumber]
           ,[OwnersName]
           ,[Usage]
           ,[DateOfAcquisition]
           ,[OwnerValuation]
           ,[DistrictValuation]
           ,[TaxPayerID]
           ,[Amount]
           ,[CellID]
           ,[Action])
SELECT [PropertyID]
           ,[PlotNumber]
           ,[OwnersName]
           ,[Usage]
           ,[DateOfAcquisition]
           ,[OwnerValuation]
           ,[DistrictValuation]
           ,[TaxPayerID]
           ,[Amount]
           ,@CellID
           ,'I'	FROM Inserted

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [Properties_Update]
ON [dbo].[Properties] FOR Update
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN Inserted i
				ON t.TaxpayerID=i.TaxpayerID)
INSERT INTO [Properties_Audit]
           ([PropertyID]
           ,[PlotNumber]
           ,[OwnersName]
           ,[Usage]
           ,[DateOfAcquisition]
           ,[OwnerValuation]
           ,[DistrictValuation]
           ,[TaxPayerID]
           ,[Amount]
           ,[CellID]
           ,[Action])
SELECT [PropertyID]
           ,[PlotNumber]
           ,[OwnersName]
           ,[Usage]
           ,[DateOfAcquisition]
           ,[OwnerValuation]
           ,[DistrictValuation]
           ,[TaxPayerID]
           ,[Amount]
           ,@CellID
           ,'U'	FROM Inserted

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Businesses](
	[BusinessID] [int] IDENTITY(1,1) NOT NULL,
	[PlotNumber] [varchar](50) NOT NULL CONSTRAINT [DF_Businesses_LandParcelID]  DEFAULT (''),
	[BusinessName] [varchar](100) NOT NULL CONSTRAINT [DF_Businesses_BusinessName]  DEFAULT (''),
	[Profession] [varchar](100) NOT NULL CONSTRAINT [DF_Businesses_Profession]  DEFAULT (''),
	[StartDate] [datetime] NOT NULL,
	[Amount] [money] NOT NULL CONSTRAINT [DF_Businesses_Amount]  DEFAULT ((0)),
	[Address] [varchar](100) NOT NULL CONSTRAINT [DF_Businesses_Address]  DEFAULT (''),
	[TaxPayerID] [int] NOT NULL,
 CONSTRAINT [Businesses_PK] PRIMARY KEY CLUSTERED 
(
	[BusinessID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [Businesses_delete]
ON [dbo].[Businesses] FOR delete
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN deleted i
				ON t.TaxpayerID=i.TaxpayerID)

INSERT INTO [Businesses_Audit]
           ([BusinessID]
           ,[PlotNumber]
           ,[BusinessName]
           ,[Profession]
           ,[StartDate]
           ,[Amount]
           ,[Address]
           ,[TaxPayerID]
           ,[CellID]
           ,[Action]
           )
SELECT [BusinessID]
           ,[PlotNumber]
           ,[BusinessName]
           ,[Profession]
           ,[StartDate]
           ,[Amount]
           ,[Address]
           ,[TaxPayerID]
           ,@CellID,'D'
		FROM deleted

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [Businesses_Insert]
ON [dbo].[Businesses] FOR INSERT
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN inserted i
				ON t.TaxpayerID=i.TaxpayerID)

INSERT INTO [Businesses_Audit]
           ([BusinessID]
           ,[PlotNumber]
           ,[BusinessName]
           ,[Profession]
           ,[StartDate]
           ,[Amount]
           ,[Address]
           ,[TaxPayerID]
           ,[CellID]
           ,[Action]
           )
SELECT [BusinessID]
           ,[PlotNumber]
           ,[BusinessName]
           ,[Profession]
           ,[StartDate]
           ,[Amount]
           ,[Address]
           ,[TaxPayerID]
           ,@CellID,'I'
		FROM inserted

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [Businesses_update]
ON [dbo].[Businesses] FOR update
AS
DECLARE @CellID smallint
SET @CellID=(SELECT TOP 1 t.CellID FROM TaxPayers t JOIN inserted i
				ON t.TaxpayerID=i.TaxpayerID)

INSERT INTO [Businesses_Audit]
           ([BusinessID]
           ,[PlotNumber]
           ,[BusinessName]
           ,[Profession]
           ,[StartDate]
           ,[Amount]
           ,[Address]
           ,[TaxPayerID]
           ,[CellID]
           ,[Action]
           )
SELECT [BusinessID]
           ,[PlotNumber]
           ,[BusinessName]
           ,[Profession]
           ,[StartDate]
           ,[Amount]
           ,[Address]
           ,[TaxPayerID]
           ,@CellID,'U'
		FROM inserted

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007   */

CREATE PROCEDURE [dbo].[GetPermissions]
 AS 
     SELECT * FROM dbo.Permissions

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeletePermissions]
 @ID tinyint
 AS 
     DELETE FROM dbo.Permissions WHERE PermissionID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBankAccountsByTaxpayerID]
@ID int=0
 AS 
     SELECT ba.*,BranchName=b.BankName + '-' + bb.BankBranchName
     FROM dbo.BankAccounts ba JOIN BankBranches bb
     ON ba.BankBranchID=bb.BankBranchID JOIN Banks b
     ON bb.BankID=b.BankID
     WHERE TaxPayerID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBankByID]
@ID tinyint=0
 AS 
     SELECT * FROM dbo.Banks
		WHERE BankID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBankAccountID]
@ID smallint=0
 AS 
     SELECT ba.*,BranchName=b.BankName + '-' + bb.BankBranchName
     FROM dbo.BankAccounts ba JOIN BankBranches bb
     ON ba.BankBranchID=bb.BankBranchID JOIN Banks b
     ON bb.BankID=b.BankID
     WHERE BankAccountID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNewBanks]
@lastdate datetime
AS
	SET NOCOUNT ON
	DECLARE @DistrictID smallint
	
	IF EXISTS(SELECT * FROM Banks_Audit)
		SELECT * FROM Banks_Audit WHERE Created>@lastdate
	ELSE
		BEGIN
			SET @DistrictID=(SELECT DistrictID FROM Settings)
			SELECT *,District=@DistrictID,Action='I' FROM Banks
		END
	RETURN

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007   */

CREATE PROCEDURE [dbo].[GetBanks]
 AS 
     SELECT * FROM dbo.Banks

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[InsertBanks]
@BankID tinyint, @BankName varchar(100) 
AS
IF @BankID=0
      BEGIN
         INSERT INTO dbo.Banks(BankName  )
                    VALUES (@BankName )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.Banks SET BankName=@BankName 
 WHERE BankID=@BankID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteBanks]
 @ID tinyint
 AS 
     DELETE FROM dbo.Banks WHERE BankID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNewBankBranches] 
@lastdate datetime
AS
	SET NOCOUNT ON
	DECLARE @DistrictID smallint
	
	IF EXISTS(SELECT * FROM BankBranches_Audit)
		SELECT * FROM BankBranches_Audit WHERE Created>@lastdate
	ELSE
		SET @DistrictID=(SELECT DistrictID FROM Settings)
		SELECT *,DistrictID=@DistrictID,Action='I' FROM BankBranches
	RETURN

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDistricts_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[DistrictID]' THEN OldValue ELSE '' END) AS [DistrictID],
     Max(Case ColumnName WHEN '[ProvinceID]' THEN OldValue ELSE '' END) AS [ProvinceID],
     Max(Case ColumnName WHEN '[DistrictName]' THEN OldValue ELSE '' END) AS [DistrictName],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.Districts' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vProperties_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  3:13PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[PropertyID]' THEN OldValue ELSE '' END) AS [PropertyID],
     Max(Case ColumnName WHEN '[PlotNumber]' THEN OldValue ELSE '' END) AS [PlotNumber],
     Max(Case ColumnName WHEN '[OwnersName]' THEN OldValue ELSE '' END) AS [OwnersName],
     Max(Case ColumnName WHEN '[Usage]' THEN OldValue ELSE '' END) AS [Usage],
     Max(Case ColumnName WHEN '[DateOfAcquisition]' THEN OldValue ELSE '' END) AS [DateOfAcquisition],
     Max(Case ColumnName WHEN '[OwnerValuation]' THEN OldValue ELSE '' END) AS [OwnerValuation],
     Max(Case ColumnName WHEN '[DistrictValuation]' THEN OldValue ELSE '' END) AS [DistrictValuation],
     Max(Case ColumnName WHEN '[TaxPayerID]' THEN OldValue ELSE '' END) AS [TaxPayerID],
     Max(Case ColumnName WHEN '[Amount]' THEN OldValue ELSE '' END) AS [Amount],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.Properties' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vLandparcels_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  3:13PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[LandParcelID]' THEN OldValue ELSE '' END) AS [LandParcelID],
     Max(Case ColumnName WHEN '[TaxPayerID]' THEN OldValue ELSE '' END) AS [TaxPayerID],
     Max(Case ColumnName WHEN '[PlotNumber]' THEN OldValue ELSE '' END) AS [PlotNumber],
     Max(Case ColumnName WHEN '[Year]' THEN OldValue ELSE '' END) AS [Year],
     Max(Case ColumnName WHEN '[StandingLevel]' THEN OldValue ELSE '' END) AS [StandingLevel],
     Max(Case ColumnName WHEN '[LandTitle]' THEN OldValue ELSE '' END) AS [LandTitle],
     Max(Case ColumnName WHEN '[TitleNumber]' THEN OldValue ELSE '' END) AS [TitleNumber],
     Max(Case ColumnName WHEN '[Usage]' THEN OldValue ELSE '' END) AS [Usage],
     Max(Case ColumnName WHEN '[NumberOfHouses]' THEN OldValue ELSE '' END) AS [NumberOfHouses],
     Max(Case ColumnName WHEN '[ContractNumber]' THEN OldValue ELSE '' END) AS [ContractNumber],
     Max(Case ColumnName WHEN '[ContractDate]' THEN OldValue ELSE '' END) AS [ContractDate],
     Max(Case ColumnName WHEN '[Amount]' THEN OldValue ELSE '' END) AS [Amount],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.Landparcels' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vTaxPayments_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  3:12PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[PaymentID]' THEN OldValue ELSE '' END) AS [PaymentID],
     Max(Case ColumnName WHEN '[TaxPayerID]' THEN OldValue ELSE '' END) AS [TaxPayerID],
     Max(Case ColumnName WHEN '[PaymentDate]' THEN OldValue ELSE '' END) AS [PaymentDate],
     Max(Case ColumnName WHEN '[Amount]' THEN OldValue ELSE '' END) AS [Amount],
     Max(Case ColumnName WHEN '[Description]' THEN OldValue ELSE '' END) AS [Description],
     Max(Case ColumnName WHEN '[Cashier]' THEN OldValue ELSE '' END) AS [Cashier],
     Max(Case ColumnName WHEN '[TaxTypeID]' THEN OldValue ELSE '' END) AS [TaxTypeID],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.TaxPayments' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vBanks_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[BankID]' THEN OldValue ELSE '' END) AS [BankID],
     Max(Case ColumnName WHEN '[BankName]' THEN OldValue ELSE '' END) AS [BankName],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.Banks' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vTaxPayers_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  3:10PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[TaxPayerID]' THEN OldValue ELSE '' END) AS [TaxPayerID],
     Max(Case ColumnName WHEN '[CellID]' THEN OldValue ELSE '' END) AS [CellID],
     Max(Case ColumnName WHEN '[FileNumber]' THEN OldValue ELSE '' END) AS [FileNumber],
     Max(Case ColumnName WHEN '[Address]' THEN OldValue ELSE '' END) AS [Address],
     Max(Case ColumnName WHEN '[Telephone]' THEN OldValue ELSE '' END) AS [Telephone],
     Max(Case ColumnName WHEN '[Mobile]' THEN OldValue ELSE '' END) AS [Mobile],
     Max(Case ColumnName WHEN '[Profession]' THEN OldValue ELSE '' END) AS [Profession],
     Max(Case ColumnName WHEN '[DateOfBirth]' THEN OldValue ELSE '' END) AS [DateOfBirth],
     Max(Case ColumnName WHEN '[IDNumber]' THEN OldValue ELSE '' END) AS [IDNumber],
     Max(Case ColumnName WHEN '[IDType]' THEN OldValue ELSE '' END) AS [IDType],
     Max(Case ColumnName WHEN '[TIN]' THEN OldValue ELSE '' END) AS [TIN],
     Max(Case ColumnName WHEN '[Email]' THEN OldValue ELSE '' END) AS [Email],
     Max(Case ColumnName WHEN '[Names]' THEN OldValue ELSE '' END) AS [Names],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.TaxPayers' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vTaxTypes_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[TaxTypeID]' THEN OldValue ELSE '' END) AS [TaxTypeID],
     Max(Case ColumnName WHEN '[TaxTypeName]' THEN OldValue ELSE '' END) AS [TaxTypeName],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.TaxTypes' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vHouseTenants_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  3:12PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[HouseID]' THEN OldValue ELSE '' END) AS [HouseID],
     Max(Case ColumnName WHEN '[PlotNumber]' THEN OldValue ELSE '' END) AS [PlotNumber],
     Max(Case ColumnName WHEN '[FullName]' THEN OldValue ELSE '' END) AS [FullName],
     Max(Case ColumnName WHEN '[Telephone]' THEN OldValue ELSE '' END) AS [Telephone],
     Max(Case ColumnName WHEN '[Address]' THEN OldValue ELSE '' END) AS [Address],
     Max(Case ColumnName WHEN '[Amount]' THEN OldValue ELSE '' END) AS [Amount],
     Max(Case ColumnName WHEN '[TaxPayerID]' THEN OldValue ELSE '' END) AS [TaxPayerID],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.HouseTenants' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vBankBranches_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[BankBranchID]' THEN OldValue ELSE '' END) AS [BankBranchID],
     Max(Case ColumnName WHEN '[BankID]' THEN OldValue ELSE '' END) AS [BankID],
     Max(Case ColumnName WHEN '[BankBranchName]' THEN OldValue ELSE '' END) AS [BankBranchName],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.BankBranches' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vFeePayments_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  3:12PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[PaymentID]' THEN OldValue ELSE '' END) AS [PaymentID],
     Max(Case ColumnName WHEN '[TaxPayerID]' THEN OldValue ELSE '' END) AS [TaxPayerID],
     Max(Case ColumnName WHEN '[Designation]' THEN OldValue ELSE '' END) AS [Designation],
     Max(Case ColumnName WHEN '[PaymentDate]' THEN OldValue ELSE '' END) AS [PaymentDate],
     Max(Case ColumnName WHEN '[Amount]' THEN OldValue ELSE '' END) AS [Amount],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.FeePayments' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vProvinces_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[ProvinceID]' THEN OldValue ELSE '' END) AS [ProvinceID],
     Max(Case ColumnName WHEN '[ProvinceName]' THEN OldValue ELSE '' END) AS [ProvinceName],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.Provinces' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vBankAccounts_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  3:12PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[BankAccountID]' THEN OldValue ELSE '' END) AS [BankAccountID],
     Max(Case ColumnName WHEN '[BankBranchID]' THEN OldValue ELSE '' END) AS [BankBranchID],
     Max(Case ColumnName WHEN '[AccountNumber]' THEN OldValue ELSE '' END) AS [AccountNumber],
     Max(Case ColumnName WHEN '[TaxPayerID]' THEN OldValue ELSE '' END) AS [TaxPayerID],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.BankAccounts' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vUserPermissions_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[UserPermissionID]' THEN OldValue ELSE '' END) AS [UserPermissionID],
     Max(Case ColumnName WHEN '[UserID]' THEN OldValue ELSE '' END) AS [UserID],
     Max(Case ColumnName WHEN '[PermissionID]' THEN OldValue ELSE '' END) AS [PermissionID],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.UserPermissions' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vBusinesses_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  3:12PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[BusinessID]' THEN OldValue ELSE '' END) AS [BusinessID],
     Max(Case ColumnName WHEN '[PlotNumber]' THEN OldValue ELSE '' END) AS [PlotNumber],
     Max(Case ColumnName WHEN '[BusinessName]' THEN OldValue ELSE '' END) AS [BusinessName],
     Max(Case ColumnName WHEN '[Profession]' THEN OldValue ELSE '' END) AS [Profession],
     Max(Case ColumnName WHEN '[StartDate]' THEN OldValue ELSE '' END) AS [StartDate],
     Max(Case ColumnName WHEN '[Amount]' THEN OldValue ELSE '' END) AS [Amount],
     Max(Case ColumnName WHEN '[Address]' THEN OldValue ELSE '' END) AS [Address],
     Max(Case ColumnName WHEN '[TaxPayerID]' THEN OldValue ELSE '' END) AS [TaxPayerID],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.Businesses' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPermissions_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[PermissionID]' THEN OldValue ELSE '' END) AS [PermissionID],
     Max(Case ColumnName WHEN '[PermissionName]' THEN OldValue ELSE '' END) AS [PermissionName],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.Permissions' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vCells_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[CellID]' THEN OldValue ELSE '' END) AS [CellID],
     Max(Case ColumnName WHEN '[SectorID]' THEN OldValue ELSE '' END) AS [SectorID],
     Max(Case ColumnName WHEN '[CellName]' THEN OldValue ELSE '' END) AS [CellName],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.Cells' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vUsers_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[UserID]' THEN OldValue ELSE '' END) AS [UserID],
     Max(Case ColumnName WHEN '[DistrictID]' THEN OldValue ELSE '' END) AS [DistrictID],
     Max(Case ColumnName WHEN '[UserName]' THEN OldValue ELSE '' END) AS [UserName],
     Max(Case ColumnName WHEN '[Password]' THEN OldValue ELSE '' END) AS [Password],
     Max(Case ColumnName WHEN '[FullName]' THEN OldValue ELSE '' END) AS [FullName],
     Max(Case ColumnName WHEN '[Status]' THEN OldValue ELSE '' END) AS [Status],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.Users' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vSectors_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN '[SectorID]' THEN OldValue ELSE '' END) AS [SectorID],
     Max(Case ColumnName WHEN '[DistrictID]' THEN OldValue ELSE '' END) AS [DistrictID],
     Max(Case ColumnName WHEN '[SectorName]' THEN OldValue ELSE '' END) AS [SectorName],
     Max(Case ColumnName WHEN '[Created]' THEN OldValue ELSE '' END) AS [Created],
     Max(Case ColumnName WHEN '[Modified]' THEN OldValue ELSE '' END) AS [Modified],
     Max(Case ColumnName WHEN '[RowVersion]' THEN OldValue ELSE '' END) AS [RowVersion],
      MAX(AuditDate) AS 'Deleted'
  FROM Audit
  Where TableName = 'dbo.Sectors' AND Operation = 'd'
  GROUP BY PrimaryKey
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetProvinceByID]
@ID tinyint=0
AS
SET NOCOUNT ON
SELECT ProvinceName FROM Provinces
	WHERE ProvinceID=@ID
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProvinces]
 AS 
     SELECT p.ProvinceID,p.ProvinceName,NumberOfDistricts=COUNT(d.DistrictID) 
		FROM dbo.Provinces p LEFT JOIN Districts d ON
		p.ProvinceID=d.ProvinceID
		GROUP BY p.ProvinceID,p.ProvinceName


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007   */

CREATE PROCEDURE [dbo].[GetUserPermissions]
 AS 
     SELECT * FROM dbo.UserPermissions

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteUserPermissions]
 @ID smallint
 AS 
     DELETE FROM dbo.UserPermissions WHERE UserPermissionID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDistricts]
@ProvinceID tinyint=0
 AS 
     SELECT d.DistrictID,d.ProvinceID,d.DistrictName,NumberOfSectors=COUNT(s.SectorID) 
		FROM dbo.Districts d LEFT JOIN Sectors s
		ON d.DistrictID=s.DistrictID
		WHERE d.ProvinceID=@ProvinceID
		GROUP BY d.DistrictName,d.DistrictID,d.ProvinceID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSettings]
@DistrictName varchar(50)
AS
	SET NOCOUNT ON
	
	DECLARE @DistrictID smallint, @ProvinceID smallint
	SELECT @DistrictID=DistrictID,@ProvinceID=ProvinceID FROM Districts WHERE DistrictName=@DistrictName
	IF EXISTS(SELECT * FROM Settings)
		UPDATE Settings SET DistrictID=@DistrictID,ProvinceID=@ProvinceID
	ELSE
		INSERT INTO Settings(DistrictID,ProvinceID)
			VALUES (@DistrictID,@ProvinceID)
	RETURN

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDistrictByName]
@name varchar(50)
AS
	SET NOCOUNT ON
	SELECT * FROM Districts 
		WHERE DistrictName=@name
	RETURN

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDistrictByID] 
@ID tinyint=0
AS
	SET NOCOUNT ON
	SELECT * FROM Districts 
		WHERE DistrictID=@ID
	RETURN

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetTaxPayersList]
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
			
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetSectors]
@districtID tinyint
 AS 
     SELECT s.*,NumberOfCells=COUNT(c.CellID) 
		FROM dbo.Sectors s LEFT JOIN Cells c
		ON s.SectorID=c.SectorID
		WHERE s.DistrictID=@districtID
		GROUP BY s.SectorName,s.SectorID, s.DistrictID
		ORDER BY s.SectorName


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTaxPayersByPhrase]
@phrase varchar(200)
 AS 
     SELECT t.*,Sector=s.SectorName,Cell=c.CellName 
     FROM dbo.TaxPayers t JOIN Cells c 
     ON t.CellID=c.CellID JOIN Sectors s
     ON c.SectorID=s.SectorID
     WHERE Names LIKE '%' + @phrase + '%'
     ORDER BY t.Names

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTaxPayersBySector]
@SectorID smallint=0
 AS 
     SELECT t.*,Sector=s.SectorName,Cell=c.CellName 
     FROM dbo.TaxPayers t JOIN Cells c 
     ON t.CellID=c.CellID JOIN Sectors s
     ON c.SectorID=s.SectorID
     WHERE s.SectorID=@SectorID
     ORDER BY t.Names

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSectorByID]
@ID smallint
AS
	SET NOCOUNT ON
	SELECT * FROM Sectors WHERE SectorID=@ID
	RETURN

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTaxPayerByID]
@ID int
 AS 
     SELECT t.*,Sector=s.SectorName,Cell=c.CellName 
     FROM dbo.TaxPayers t JOIN Cells c 
     ON t.CellID=c.CellID JOIN Sectors s
     ON c.SectorID=s.SectorID
     WHERE TaxPayerID=@ID
     ORDER BY t.Names

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFeePaymentsByPeriodAndSector]
@SectorID tinyint,
@Startdate datetime,
@enddate datetime
 AS 
 IF @SectorID>0
     SELECT tp.*,TaxPayerName=t.Names,Sector=s.Sectorname, Cell=c.CellName
     FROM dbo.FeePayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID JOIN Cells c
     ON t.CellID=c.CellID JOIN Sectors s ON
     s.SectorID=c.SectorID
     WHERE tp.Paymentdate>=@startdate AND tp.Paymentdate<=@enddate
     AND s.SectorID=@SectorID
   ELSE
       SELECT tp.*,TaxPayerName=t.Names,Sector=s.Sectorname, Cell=c.CellName
     FROM dbo.FeePayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID JOIN Cells c
     ON t.CellID=c.CellID JOIN Sectors s ON
     s.SectorID=c.SectorID
     WHERE tp.Paymentdate>=@startdate AND tp.Paymentdate<=@enddate
     

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [dbo].[TaxPayerRegistry]
 AS 
     SELECT t.*,Sector=s.SectorName,Cell=c.CellName,
	 BusinessTax=SUM(b.Amount),PropertyTax=SUM(p.Amount),
	 RentalTax=SUM(h.Amount),LandTax=SUM(lp.Amount)
     FROM dbo.TaxPayers t JOIN Cells c 
     ON t.CellID=c.CellID JOIN Sectors s
     ON c.SectorID=s.SectorID LEFT JOIN Businesses b
	 ON t.TaxpayerID=b.TaxpayerID LEFT JOIN Properties p
	 ON t.TaxpayerID=p.TaxpayerID LEFT JOIN HouseTenants h
	 ON t.TaxpayerID=h.TaxpayerID LEFT JOIN LandParcels lp
	 ON t.TaxpayerID=lp.TaxpayerID
     GROUP BY t.Names,t.TaxpayerID,t.CellID,t.FileNumber,t.Address,t.Telephone,t.Mobile,t.profession,
		t.DateOfBirth,t.IDNumber,t.IDtype,t.TIN,t.Email,s.SectorName,c.CellName


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTaxPaymentsByPeriodAndType]
@TaxType tinyint,
@Startdate datetime,
@enddate datetime
 AS 
 IF @TaxType>0
     SELECT tp.*,TaxPayerName=t.Names,TaxTypeName=ISNULL(tt.TaxTypeName,''),Sector=s.Sectorname, Cell=c.CellName
     FROM dbo.TaxPayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID LEFT JOIN TaxTypes tt
     ON tp.TaxTypeID=tt.TaxTypeID JOIN Cells c
     ON t.CellID=c.CellID JOIN Sectors s ON
     s.SectorID=c.SectorID
     WHERE tp.Paymentdate>=@startdate AND tp.Paymentdate<=@enddate
     AND tt.TaxTypeID=@TaxType
   ELSE
       SELECT tp.*,TaxPayerName=t.Names,TaxTypeName=ISNULL(tt.TaxTypeName,''),Sector=s.Sectorname, Cell=c.CellName
     FROM dbo.TaxPayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID LEFT JOIN TaxTypes tt
     ON tp.TaxTypeID=tt.TaxTypeID JOIN Cells c
     ON t.CellID=c.CellID JOIN Sectors s ON
     s.SectorID=c.SectorID
     WHERE tp.Paymentdate>=@startdate AND tp.Paymentdate<=@enddate
     

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTaxPaymentsByPeriodAndSector]
@SectorID tinyint,
@Startdate datetime,
@enddate datetime
 AS 
 IF @SectorID>0
     SELECT tp.*,TaxPayerName=t.Names,TaxTypeName=ISNULL(tt.TaxTypeName,''),Sector=s.Sectorname, Cell=c.CellName
     FROM dbo.TaxPayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID LEFT JOIN TaxTypes tt
     ON tp.TaxTypeID=tt.TaxTypeID JOIN Cells c
     ON t.CellID=c.CellID JOIN Sectors s ON
     s.SectorID=c.SectorID
     WHERE tp.Paymentdate>=@startdate AND tp.Paymentdate<=@enddate
     AND s.SectorID=@SectorID
   ELSE
       SELECT tp.*,TaxPayerName=t.Names,TaxTypeName=ISNULL(tt.TaxTypeName,''),Sector=s.Sectorname, Cell=c.CellName
     FROM dbo.TaxPayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID LEFT JOIN TaxTypes tt
     ON tp.TaxTypeID=tt.TaxTypeID JOIN Cells c
     ON t.CellID=c.CellID JOIN Sectors s ON
     s.SectorID=c.SectorID
     WHERE tp.Paymentdate>=@startdate AND tp.Paymentdate<=@enddate
     

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertUsers]
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

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserByID]
@ID smallint=0
AS
	SET NOCOUNT ON
	SELECT * FROM Users
		WHERE UserID=@ID
		ORDER BY username
	RETURN

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCells]
@SectorID smallint=0
 AS 
     SELECT * FROM dbo.Cells WHERE SectorID=@SectorID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCellByID]
@ID smallint
AS
	SET NOCOUNT ON
	SELECT * FROM Cells WHERE CellID=@ID
	RETURN

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTaxPayments]
 AS 
     SELECT tp.*,TaxPayerName=t.Names,TaxType=ISNULL(tt.TaxTypeName,'') 
     FROM dbo.TaxPayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID LEFT JOIN TaxTypes tt
     ON tp.TaxTypeID=tt.TaxTypeID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[InsertTaxPayers]
@TaxPayerID int, @CellID smallint, @FileNumber varchar(30), @Address varchar(100),
@Telephone varchar(30), @Mobile varchar(30), @Profession varchar(50), 
@DateOfBirth datetime, @IDNumber varchar(20), @IDType varchar(20), 
@TIN varchar(50), @Email varchar(100),@Names varchar(100)
AS
IF @TaxPayerID=0
      BEGIN
         INSERT INTO dbo.TaxPayers(CellID, FileNumber, Address, Telephone, Mobile, Profession, DateOfBirth, IDNumber, IDType, TIN, Email,Names  )
                    VALUES (@CellID, @FileNumber, @Address, @Telephone, @Mobile, @Profession, @DateOfBirth, @IDNumber, @IDType, @TIN, @Email,@Names )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.TaxPayers SET CellID=@CellID, FileNumber=@FileNumber, Address=@Address, 
        Telephone=@Telephone, Mobile=@Mobile, Profession=@Profession, DateOfBirth=@DateOfBirth, 
        IDNumber=@IDNumber, IDType=@IDType, TIN=@TIN, Email=@Email ,Names=@Names
 WHERE TaxPayerID=@TaxPayerID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTaxPaymentsByPeriod]
@Startdate datetime,
@enddate datetime
 AS 
     SELECT tp.*,TaxPayerName=t.Names 
     FROM dbo.TaxPayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID
     WHERE tp.Paymentdate BETWEEN @startdate AND @enddate

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTaxPaymentByID]
@ID int
 AS 
     SELECT tp.*,TaxPayerName=t.Names 
     FROM dbo.TaxPayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID
     WHERE PaymentID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetCellIDFromTaxpayerID](@TaxpayerID int)
RETURNS smallint
AS
	BEGIN
		DECLARE @CellID smallint
		SET @CellID=(SELECT CellID FROM Taxpayers WHERE TaxPayerID=@TaxPayerID)
		RETURN @CellID
	END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetNewTaxpayers]
@lastdate datetime
AS
IF EXISTS(SELECT * FROM Taxpayers_Audit)
	SELECT * FROM Taxpayers_Audit WHERE created>@lastdate
ELSE
	SELECT *,Action='I' FROM Taxpayers 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTotalTaxpayments]
AS
	SET NOCOUNT ON
	DECLARE @TTotal money
	DECLARE @FTotal money
	SET @TTotal=(SELECT SUM(Amount) FROM Taxpayments)
	SET @FTotal=(SELECT SUM(Amount) FROM Feepayments)
	SELECT Total=@TTotal + @FTotal
	RETURN

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertTaxPayments]
@PaymentID bigint, @TaxPayerID int, @PaymentDate datetime, 
@Amount money, @Description varchar(100),@Cashier varchar(50)='' ,
@TaxTypeID tinyint=0
AS
IF @PaymentID=0
      BEGIN
         INSERT INTO dbo.TaxPayments(TaxPayerID, PaymentDate, Amount, Description,Cashier ,TaxTypeID )
                    VALUES (@TaxPayerID, @PaymentDate, @Amount, @Description,@Cashier,@TaxTypeID )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.TaxPayments SET TaxPayerID=@TaxPayerID, PaymentDate=@PaymentDate, 
				Amount=@Amount, Description=@Description,Cashier=@Cashier,TaxTypeID=@TaxTypeID 
		WHERE PaymentID=@PaymentID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertProperties]
@PropertyID int, @PlotNumber varchar(50), @OwnersName varchar(50),
 @Usage varchar(50), @DateOfAcquisition datetime, @OwnerValuation money,
  @DistrictValuation money ,@TaxPayerID int=0,
@Amount money

AS
IF @PropertyID=0
      BEGIN
         INSERT INTO dbo.Properties(PlotNumber, OwnersName, Usage, DateOfAcquisition, OwnerValuation, DistrictValuation ,TaxPayerID,Amount )
                    VALUES (@PlotNumber, @OwnersName, @Usage, @DateOfAcquisition, @OwnerValuation, @DistrictValuation,@TaxPayerID,@Amount )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.Properties SET PlotNumber=@PlotNumber, OwnersName=@OwnersName, Usage=@Usage, 
        DateOfAcquisition=@DateOfAcquisition, OwnerValuation=@OwnerValuation, 
        DistrictValuation=@DistrictValuation ,TaxPayerID=@TaxPayerID,Amount=@Amount
 WHERE PropertyID=@PropertyID


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPropertiesByTaxPayerID]
@TaxPayerID int
 AS 
     SELECT * FROM dbo.Properties
     WHERE TaxPayerID=@TaxPayerID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetTaxPayersForRemote]
@lastdate datetime
 AS 
     SELECT * 
     FROM dbo.TaxPayers_Audit
     WHERE created>@lastdate
     
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertHouseTenants]
@HouseID int, @PlotNumber varchar(50), @FullName varchar(50), 
@Telephone varchar(30), @Address varchar(100), @Amount money ,
@TaxPayerID int=0
AS
IF @HouseID=0
      BEGIN
         INSERT INTO dbo.HouseTenants(PlotNumber, FullName, Telephone, Address, Amount,TaxPayerID  )
                    VALUES (@PlotNumber, @FullName, @Telephone, @Address, @Amount,@TaxPayerID )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.HouseTenants SET PlotNumber=@PlotNumber, FullName=@FullName, 
        Telephone=@Telephone, Address=@Address, Amount=@Amount,TaxPayerID=@TaxPayerID 
 WHERE HouseID=@HouseID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetHouseTenantsByTaxPayerID]
@TaxPayerID int
 AS 
     SELECT * FROM dbo.HouseTenants
     WHERE TaxPayerID=@TaxPayerID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertBusinesses]
@BusinessID int, @PlotNumber varchar(50), @BusinessName varchar(100), 
@Profession varchar(100), @StartDate datetime, @Amount money, @Address varchar(100) ,
@TaxpayerID int

AS
IF @BusinessID=0
      BEGIN
         INSERT INTO dbo.Businesses(PlotNumber, BusinessName, Profession, StartDate, Amount, Address,TaxpayerID  )
                    VALUES (@PlotNumber, @BusinessName, @Profession, @StartDate, @Amount, @Address,@TaxpayerID )
           SELECT SCOPE_IDENTITY() AS NewID
        END
 ELSE
        UPDATE dbo.Businesses SET PlotNumber=@PlotNumber, BusinessName=@BusinessName, Profession=@Profession, 
        StartDate=@StartDate, Amount=@Amount, Address=@Address,TaxpayerID=@TaxpayerID 
 WHERE BusinessID=@BusinessID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBusinessesByTaxPayerID]
@TaxPayerID int
 AS 
     SELECT * FROM dbo.Businesses
     WHERE TaxPayerID=@TaxPayerID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBusinessByID]
@ID int
 AS 
     SELECT * FROM dbo.Businesses
     WHERE BusinessID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTaxTypes]
 AS 
     SELECT * FROM dbo.TaxTypes

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertTaxTypes]
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

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTaxTypeByID]
@ID tinyint=0
AS
	SET NOCOUNT ON
	SELECT * FROM TaxTypes
		WHERE TaxtypeID=@ID
	RETURN

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteTaxTypes]
 @ID tinyint
 AS 
     DELETE FROM dbo.TaxTypes WHERE TaxTypeID=@ID

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNewProperties]
@lastdate datetime
AS
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM Properties_Audit)
		SELECT * FROM Properties_Audit WHERE Created>@lastdate
	ELSE
		SELECT *,CellID=dbo.GetCellIDFromTaxpayerID(TaxpayerID),Action='I' FROM Properties
	
	RETURN

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNewBankAccounts] 
@lastdate datetime
AS
	SET NOCOUNT ON
		
	IF EXISTS(SELECT * FROM BankAccounts_Audit)
		SELECT * FROM BankAccounts_Audit WHERE Created>@lastdate
	ELSE
		SELECT *,CellID=dbo.GetCellIDFromTaxpayerID(TaxpayerID),Action='I' FROM BankAccounts
	RETURN

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNewTaxPayments] 
@lastdate datetime
AS
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM Taxpayments_Audit)
		SELECT * FROM Taxpayments_Audit WHERE created>@lastdate
	ELSE
		SELECT *,CellID=dbo.GetCellIDFromTaxpayerID(TaxpayerID),Action='I' FROM Taxpayments
	RETURN

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNewLandParcels]
@lastdate datetime
AS
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM LandParcels_Audit)
		SELECT * FROM LandParcels_Audit WHERE Created>@lastdate
	ELSE
		SELECT *,CellID=dbo.GetCellIDFromTaxpayerID(TaxpayerID),Action='I' FROM LandParcels
	RETURN

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNewFeePayments] 
@lastdate datetime
AS
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM FeePayments_Audit)
		SELECT * FROM FeePayments_Audit	WHERE created>@lastdate
	ELSE
		SELECT *,CellID=dbo.GetCellIDFromTaxpayerID(TaxpayerID),Action='I' FROM FeePayments
	RETURN

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNewHouseTenants]
@lastdate datetime
AS
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM Housetenants_Audit)
		SELECT * FROM Housetenants_Audit WHERE Created>@lastdate
	ELSE
		SELECT *,CellID=dbo.GetCellIDFromTaxpayerID(TaxpayerID),Action='I' FROM Housetenants
	RETURN

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNewBusinesses] 
	@lastdate datetime
AS
	SET NOCOUNT ON  
	DECLARE @CellID smallint
	IF EXISTS(SELECT * FROM Businesses_Audit)
		SELECT * FROM Businesses_Audit WHERE Created>@lastdate
	ELSE
		SELECT *,CellID=dbo.GetCellIDFromTaxPayerID(TaxpayerID),Action='I' FROM Businesses	
	RETURN

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetTaxPayers]
 AS 
     SELECT * 
     FROM dbo.TaxPayerRegistry
     
GO
USE [DTMS]
GO
USE [DTMS]
GO
USE [DTMS]
GO
USE [DTMS]
GO
USE [DTMS]
GO
USE [DTMS]
GO
USE [DTMS]
GO
USE [DTMS]
GO
USE [DTMS]
GO
USE [DTMS]
GO
USE [DTMS]
GO
USE [DTMS]
GO
USE [DTMS]
GO
USE [DTMS]
GO
ALTER TABLE [dbo].[UserPermissions]  WITH CHECK ADD  CONSTRAINT [Permissions_UserPermissions_FK1] FOREIGN KEY([PermissionID])
REFERENCES [dbo].[Permissions] ([PermissionID])
GO
ALTER TABLE [dbo].[UserPermissions]  WITH CHECK ADD  CONSTRAINT [Users_UserPermissions_FK1] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[BankBranches]  WITH CHECK ADD  CONSTRAINT [Banks_BankBranches_FK1] FOREIGN KEY([BankID])
REFERENCES [dbo].[Banks] ([BankID])
GO
ALTER TABLE [dbo].[Districts]  WITH CHECK ADD  CONSTRAINT [Provinces_Districts_FK1] FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[Provinces] ([ProvinceID])
GO
ALTER TABLE [dbo].[BankAccounts]  WITH CHECK ADD  CONSTRAINT [BankBranches_BankAccounts_FK1] FOREIGN KEY([BankBranchID])
REFERENCES [dbo].[BankBranches] ([BankBranchID])
GO
ALTER TABLE [dbo].[BankAccounts]  WITH CHECK ADD  CONSTRAINT [TaxPayers_BankAccounts_FK1] FOREIGN KEY([TaxPayerID])
REFERENCES [dbo].[TaxPayers] ([TaxPayerID])
GO
ALTER TABLE [dbo].[Sectors]  WITH CHECK ADD  CONSTRAINT [Districts_Sectors_FK1] FOREIGN KEY([DistrictID])
REFERENCES [dbo].[Districts] ([DistrictID])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [Districts_Users_FK1] FOREIGN KEY([DistrictID])
REFERENCES [dbo].[Districts] ([DistrictID])
GO
ALTER TABLE [dbo].[Cells]  WITH CHECK ADD  CONSTRAINT [Sectors_Cells_FK1] FOREIGN KEY([SectorID])
REFERENCES [dbo].[Sectors] ([SectorID])
GO
ALTER TABLE [dbo].[TaxPayers]  WITH CHECK ADD  CONSTRAINT [Cells_TaxPayers_FK1] FOREIGN KEY([CellID])
REFERENCES [dbo].[Cells] ([CellID])
GO
ALTER TABLE [dbo].[TaxPayments]  WITH CHECK ADD  CONSTRAINT [TaxPayers_TaxPayments_FK1] FOREIGN KEY([TaxPayerID])
REFERENCES [dbo].[TaxPayers] ([TaxPayerID])
GO
ALTER TABLE [dbo].[HouseTenants]  WITH CHECK ADD  CONSTRAINT [FK_TaxPayers_HouseTenants] FOREIGN KEY([TaxPayerID])
REFERENCES [dbo].[TaxPayers] ([TaxPayerID])
GO
ALTER TABLE [dbo].[LandParcels]  WITH CHECK ADD  CONSTRAINT [TaxPayers_LandParcels_FK1] FOREIGN KEY([TaxPayerID])
REFERENCES [dbo].[TaxPayers] ([TaxPayerID])
GO
ALTER TABLE [dbo].[FeePayments]  WITH CHECK ADD  CONSTRAINT [TaxPayers_FeePayments_FK1] FOREIGN KEY([TaxPayerID])
REFERENCES [dbo].[TaxPayers] ([TaxPayerID])
GO
ALTER TABLE [dbo].[Properties]  WITH CHECK ADD  CONSTRAINT [FK_TaxPayers_Properties] FOREIGN KEY([TaxPayerID])
REFERENCES [dbo].[TaxPayers] ([TaxPayerID])
GO
ALTER TABLE [dbo].[Businesses]  WITH CHECK ADD  CONSTRAINT [FK_TaxPayers_Businesses] FOREIGN KEY([TaxPayerID])
REFERENCES [dbo].[TaxPayers] ([TaxPayerID])
