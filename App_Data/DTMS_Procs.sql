USE DTMS
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
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007   */

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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertBankAccounts]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteBankAccounts]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteBankAccounts]
 @ID int
 AS 
     DELETE FROM dbo.BankAccounts WHERE BankAccountID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBankBranches]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetBankBranches]
@ID tinyint=0
 AS 
     SELECT * FROM dbo.BankBranches
     WHERE BankID=@ID
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
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteBankBranches]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteBankBranches]
 @ID smallint
 AS 
     DELETE FROM dbo.BankBranches WHERE BankBranchID=@ID
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
/*Stored Proc: Scripted 05/12/2007   */

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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteBusinesses]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteBusinesses]
 @ID int
 AS 
     DELETE FROM dbo.Businesses WHERE BusinessID=@ID
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
/*Stored Proc: Scripted 05/12/2007   */

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
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteFeePayments]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteFeePayments]
 @ID bigint
 AS 
     DELETE FROM dbo.FeePayments WHERE PaymentID=@ID
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
/*Stored Proc: Scripted 05/12/2007   */

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
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteHouseTenants]
 @ID int
 AS 
     DELETE FROM dbo.HouseTenants WHERE HouseID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetLandParcels]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007   */

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

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteLandParcels]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteLandParcels]
 @ID varchar
 AS 
     DELETE FROM dbo.LandParcels WHERE LandParcelID=@ID
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
/*Stored Proc: Scripted 05/12/2007   */

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
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteProperties]
 @ID int
 AS 
     DELETE FROM dbo.Properties WHERE PropertyID=@ID
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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AutoAudit]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
SET @SQL = ''If EXISTS (Select * from sys.objects where name = ''
       + '''''''' + @TableName + ''_Audit_Insert'' + '''''' )''
       + '' DROP TRIGGER '' + @SchemaName + ''.'' + @TableName + ''_Audit_Insert''
EXEC (@SQL)

-- drop existing update trigger
SET @SQL = ''If EXISTS (Select * from sys.objects where name = ''
       + '''''''' + @TableName + ''_Audit_Update'' + '''''' )''
       + '' DROP TRIGGER '' + @SchemaName + ''.'' + @TableName + ''_Audit_Update''
EXEC (@SQL)

-- drop existing modified trigger
SET @SQL = ''If EXISTS (Select * from sys.objects where name = ''
       + '''''''' + @TableName + ''_Modified'' + '''''' )''
       + '' DROP TRIGGER '' + @SchemaName + ''.'' + @TableName + ''_Modified''
EXEC (@SQL)

-- drop existing delete trigger
SET @SQL = ''If EXISTS (Select * from sys.objects where name = ''
       + '''''''' + @TableName + ''_Audit_Delete'' + '''''' )''
       + '' DROP TRIGGER '' + @SchemaName + ''.'' + @TableName + ''_Audit_Delete''
EXEC (@SQL)

-- drop existing delete view
SET @SQL = ''If EXISTS (Select * from sys.objects where name = ''
       + ''''''v'' + @TableName + ''_Deleted'' + '''''' )''
       + '' DROP VIEW '' + @SchemaName + ''.v'' + @TableName + ''_Deleted''
EXEC (@SQL)



-- add created column 
IF not exists (select *
			  from sys.tables t
				join sys.schemas s
				  on s.schema_id = t.schema_id
				join sys.columns c
				  on t.object_id = c.object_id
			  where  t.name = @TableName AND s.name = @SchemaName and c.name = ''created'')
  BEGIN
    SET @SQL = ''ALTER TABLE '' + @SchemaName + ''.'' + @TableName + '' ADD Created DateTime NOT NULL DEFAULT(GetDate())''
    EXEC (@SQL)
  END

-- add modified column 
IF not exists( select *
			  from sys.tables t
				join sys.schemas s
				  on s.schema_id = t.schema_id
				join sys.columns c
				  on t.object_id = c.object_id
			  where  t.name = @TableName AND s.name = @SchemaName and c.name = ''modified'')
  BEGIN   
    SET @SQL = ''ALTER TABLE '' + @SchemaName + ''.'' + @TableName + '' ADD Modified DateTime NOT NULL DEFAULT(GetDate())''
    EXEC (@SQL)
  END

-- add RowVersion column 
IF not exists( select *
			  from sys.tables t
				join sys.schemas s
				  on s.schema_id = t.schema_id
				join sys.columns c
				  on t.object_id = c.object_id
			  where  t.name = @TableName AND s.name = @SchemaName and c.name = ''RowVersion'')
  BEGIN   
    SET @SQL = ''ALTER TABLE '' + @SchemaName + ''.'' + @TableName + '' ADD RowVersion INT NOT NULL DEFAULT(1)''
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
SET @SQL = ''CREATE TRIGGER '' + @SchemaName + ''.'' + @TableName + ''_Modified'' + '' ON ''+ @SchemaName + ''.'' + @TableName + Char(13) + Char(10)
       + '' AFTER Update'' + Char(13) + Char(10) + '' NOT FOR REPLICATION AS'' + Char(13) + Char(10)
       + '' SET NoCount On '' + Char(13) + Char(10)
       + '' -- generated by AutoAudit on '' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + '' -- created by Paul Nielsen '' + Char(13) + Char(10)
       + '' -- www.SQLServerBible.com '' + Char(13) + Char(10) + Char(13) + Char(10)

       + '' Begin Try '' + Char(13) + Char(10)
       + '' If Trigger_NestLevel(object_ID(N''''['' + @SchemaName + ''].['' + @TableName + ''_Modified]'''')) > 1 Return;'' + Char(13) + Char(10)

       + '' If (Update(Created) or Update(Modified)) AND Trigger_NestLevel() = 1'' + Char(13) + Char(10)
       + '' Begin; Raiserror(''''Update failed.'''', 16, 1); Rollback;  Return; End;'' + Char(13) + Char(10)

       + '' -- Update the Modified date'' + Char(13) + Char(10)
       + '' UPDATE ['' + @SchemaName + ''].['' + @TableName + '']''+ Char(13) + Char(10)
       + '' SET Modified = getdate(), '' + Char(13) + Char(10)
       + ''        [RowVersion] = ['' + @TableName + ''].[RowVersion] + 1 '' + Char(13) + Char(10)
       + ''   FROM ['' + @SchemaName + ''].['' + @TableName + '']'' + Char(13) + Char(10)
       + ''     JOIN Inserted''  + Char(13) + Char(10)
       + ''       ON ['' + @TableName + ''].['' + @PKColumnName + ''] = Inserted.['' + @PKColumnName + '']''
       + '' End Try '' + Char(13) + Char(10)
       + '' Begin Catch '' + Char(13) + Char(10)
       + ''   Raiserror(''''error in ['' + + @SchemaName + ''].['' + @TableName +''_modified] trigger'''', 16, 1 ) with log'' + Char(13) + Char(10)
       + '' End Catch '' 

print @sql 
    EXEC (@SQL)

--------------------------------------------------------------------------------------------
-- build insert trigger 
SET @SQL = ''CREATE TRIGGER '' + @SchemaName + ''.'' + @TableName + ''_Audit_Insert'' + '' ON ''+ @SchemaName + ''.'' + @TableName + Char(13) + Char(10)
       + '' AFTER Insert'' + Char(13) + Char(10) + '' NOT FOR REPLICATION AS'' + Char(13) + Char(10)
       + '' SET NoCount On '' + Char(13) + Char(10)
       + '' -- generated by AutoAudit on '' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + '' -- created by Paul Nielsen '' + Char(13) + Char(10)
       + '' -- www.SQLServerBible.com '' + Char(13) + Char(10) + Char(13) + Char(10)
       + ''DECLARE @AuditTime DATETIME'' + Char(13) + Char(10)
       + ''SET @AuditTime = GetDate()'' + Char(13) + Char(10) + Char(13) + Char(10)
       + '' Begin Try '' + Char(13) + Char(10)

-- for each column
	select @SQL = @SQL + 
		     ''   INSERT dbo.Audit (AuditDate, SysUser, Application, Hostname, TableName, Operation, PrimaryKey, RowDescription, SecondaryRow, ColumnName, NewValue)'' + Char(13) + Char(10)
          + ''   SELECT  @AuditTime, suser_sname(), APP_NAME(), Host_Name(), '' 
          + '''''''' + @SchemaName + ''.'' + @TableName + '''''', ''''i'''',''   
          + '' Inserted.['' + @PKColumnName + ''],'' + Char(13) + Char(10) 
          + ''        NULL,     -- Row Description (e.g. Order Number)'' + Char(13) + Char(10)   
          + ''        NULL,     -- Secondary Row Value (e.g. Oder Number for an Order Detail Line)'' + Char(13) + Char(10)
          + ''        ''''['' + c.name + '']'''',''   
          + '' Cast(Inserted.['' + c.name + ''] as VARCHAR(50))'' + Char(13) + Char(10)
          + ''          FROM Inserted'' + Char(13) + Char(10)
          + ''          WHERE Inserted.[''+ c.name + ''] is not null'' + Char(13) + Char(10)+ Char(13) + Char(10)
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
         AND c.name NOT IN (''created'', ''modified'',''RowVersion'')
         AND c.is_computed = 0
        AND st.name IN (''tinyint'', ''smallint'', ''int'', ''money'', ''smallmoney'', ''decimal'', ''bigint'', ''datetime'', ''smalldateteime'', ''numeric'',  ''varchar'', ''nvarchar'', ''char'', ''nchar'', ''bit'')
	  order by c.column_id

	select @SQL = @SQL + 
       + '' End Try '' + Char(13) + Char(10)
       + '' Begin Catch '' + Char(13) + Char(10)
       + ''   Raiserror(''''error in ['' + + @SchemaName + ''].['' + @TableName +''_audit_insert] trigger'''', 16, 1 ) with log'' + Char(13) + Char(10)
       + '' End Catch '' 


EXEC (@SQL)

--------------------------------------------------------------------------------------------
-- build update trigger 

SET @SQL = ''CREATE TRIGGER '' + @SchemaName + ''.'' + @TableName + ''_Audit_Update'' + '' ON ''+ @SchemaName + ''.'' + @TableName + Char(13) + Char(10)
       + '' AFTER Update'' + Char(13) + Char(10) + '' NOT FOR REPLICATION AS'' + Char(13) + Char(10)
       + '' SET NoCount On '' + Char(13) + Char(10)
       + '' -- generated by AutoAudit on '' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + '' -- created by Paul Nielsen '' + Char(13) + Char(10)
       + '' -- www.SQLServerBible.com '' + Char(13) + Char(10) + Char(13) + Char(10)
       + ''DECLARE @AuditTime DATETIME'' + Char(13) + Char(10)
       + ''SET @AuditTime = GetDate()'' + Char(13) + Char(10) + Char(13) + Char(10)
       + '' Begin Try '' + Char(13) + Char(10)
-- for each column
	select @SQL = @SQL + 
	   +  '' IF UPDATE(['' + c.name + ''])'' + Char(13) + Char(10)
       + ''   INSERT dbo.Audit (AuditDate, SysUser, Application, HostName, TableName, Operation, PrimaryKey, RowDescription, SecondaryRow, ColumnName, OldValue, NewValue)'' + Char(13) + Char(10)
       + ''   SELECT  @AuditTime, suser_sname(), APP_NAME(), Host_Name(), '' 
       + '''''''' + @SchemaName + ''.'' + @TableName + '''''', ''''u'''',''   
       + '' Inserted.['' + @PKColumnName + ''],'' + Char(13) + Char(10) 
       + ''        NULL,     -- Row Description (e.g. Order Number)'' + Char(13) + Char(10)   
       + ''        NULL,     -- Secondary Row Value (e.g. Oder Number for an Order Detail Line)'' + Char(13) + Char(10)
       + ''        ''''['' + c.name+ '']'''',''   
       + '' Cast(Deleted.['' + c.name + ''] as VARCHAR(50)), '' 
       + '' Cast(Inserted.['' + c.name + ''] as VARCHAR(50))'' + Char(13) + Char(10)
       + ''          FROM Inserted'' + Char(13) + Char(10)
       + ''             JOIN Deleted'' + Char(13) + Char(10)
       + ''               ON Inserted.['' + @PKColumnName + ''] = Deleted.['' + @PKColumnName + '']'' + Char(13) + Char(10)
       + ''               AND isnull(Inserted.['' + c.name + ''],'''''''') <> isnull(Deleted.['' + c.name + ''],'''''''')'' + Char(13) + Char(10)+ Char(13) + Char(10)
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
         AND c.name NOT IN (''created'', ''modified'',''RowVersion'')
         AND c.is_computed = 0
        AND st.name IN (''tinyint'', ''smallint'', ''int'', ''money'', ''smallmoney'', ''decimal'', ''bigint'', ''datetime'', ''smalldateteime'', ''numeric'',  ''varchar'', ''nvarchar'', ''char'', ''nchar'', ''bit'')
	  order by c.column_id

	select @SQL = @SQL + 
       + '' End Try '' + Char(13) + Char(10)
       + '' Begin Catch '' + Char(13) + Char(10)
       + ''   Raiserror(''''error in ['' + + @SchemaName + ''].['' + @TableName +''_audit_update] trigger'''', 16, 1 ) with log'' + Char(13) + Char(10)
       + '' End Catch '' 


EXEC (@SQL)


--------------------------
-- build delete trigger 
SET @SQL = ''CREATE TRIGGER '' + @SchemaName + ''.'' + @TableName + ''_Audit_Delete'' + '' ON ''+ @SchemaName + ''.'' + @TableName + Char(13) + Char(10)
       + '' AFTER Delete'' + Char(13) + Char(10) + '' NOT FOR REPLICATION AS'' + Char(13) + Char(10)
       + '' SET NoCount On '' + Char(13) + Char(10)
       + '' -- generated by AutoAudit on '' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + '' -- created by Paul Nielsen '' + Char(13) + Char(10)
       + '' -- www.SQLServerBible.com '' + Char(13) + Char(10) + Char(13) + Char(10)
       + ''DECLARE @AuditTime DATETIME'' + Char(13) + Char(10)
       + ''SET @AuditTime = GetDate()'' + Char(13) + Char(10) + Char(13) + Char(10)
       + '' Begin Try '' + Char(13) + Char(10)

-- for each column
	select @SQL = @SQL + 
		     ''   INSERT dbo.Audit (AuditDate, SysUser, Application, HostName, TableName, Operation, PrimaryKey, RowDescription, SecondaryRow, ColumnName, OldValue)'' + Char(13) + Char(10)
          + ''   SELECT  @AuditTime, suser_sname(), APP_NAME(), Host_Name(),'' 
          + '''''''' + @SchemaName + ''.'' + @TableName + '''''', ''''d'''',''   
          + '' deleted.['' + @PKColumnName + ''],'' + Char(13) + Char(10) 
          + ''        NULL,     -- Row Description (e.g. Order Number)'' + Char(13) + Char(10)   
          + ''        NULL,     -- Secondary Row Value (e.g. Oder Number for an Order Detail Line)'' + Char(13) + Char(10)
          + ''        ''''['' + c.name + '']'''',''   
          + '' Cast(deleted.['' + c.name + ''] as VARCHAR(50))'' + Char(13) + Char(10)
          + ''          FROM deleted'' + Char(13) + Char(10)
          + ''          WHERE deleted.[''+ c.name + ''] is not null'' + Char(13) + Char(10)+ Char(13) + Char(10)
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
         -- AND c.name NOT IN (''created'', ''modified'',''RowVersion'')
         AND c.is_computed = 0
        AND st.name IN (''tinyint'', ''smallint'', ''int'', ''money'', ''smallmoney'', ''decimal'', ''bigint'', ''datetime'', ''smalldateteime'', ''numeric'',  ''varchar'', ''nvarchar'', ''char'', ''nchar'', ''bit'')
	  order by c.column_id

	select @SQL = @SQL + 
       + '' End Try '' + Char(13) + Char(10)
       + '' Begin Catch '' + Char(13) + Char(10)
       + ''   Raiserror(''''error in ['' + + @SchemaName + ''].['' + @TableName +''_audit_delete trigger'''', 16, 1 ) with log'' + Char(13) + Char(10)
       + '' End Catch '' 

EXEC (@SQL)


--------------------------------------------------------------------------------------------
-- build _Deleted view

/* Sample: 
CREATE VIEW Production.vCulture_Deleted
as
	SELECT 
		Max(Case ColumnName WHEN ''[CultureID]'' THEN OldValue ELSE '''' END) AS [CultureID],
		Max(Case ColumnName WHEN ''[Name]'' THEN OldValue ELSE '''' END) AS [Name],
		Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
		Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS Modified,
		Max(Case ColumnName WHEN ''[Rowversion]'' THEN OldValue ELSE '''' END) AS [Rowversion],
        MAX(AuditDate) AS ''Deleted''
	FROM Audit 
	Where TableName = ''Production.Culture'' AND Operation = ''d''
	GROUP BY PrimaryKey 
*/

SET @SQL = ''CREATE VIEW '' + @SchemaName + ''.v'' + @TableName + ''_Deleted'' + Char(13) + Char(10)
       + ''AS '' + Char(13) + Char(10) 
       + '' -- generated by AutoAudit on '' + Convert(VARCHAR(30), GetDate(),100)  + Char(13) + Char(10)
       + '' -- created by Paul Nielsen '' + Char(13) + Char(10)
       + '' -- www.SQLServerBible.com '' + Char(13) + Char(10) + Char(13) + Char(10)
       + ''SELECT '' + Char(13) + Char(10)

-- for each column
SELECT @SQL = @SQL +
		  ''     Max(Case ColumnName WHEN ''''['' + c.name + '']'''' THEN OldValue ELSE '''''''' END) AS ['' + c.name +''],''  + Char(13) + Char(10)
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
        AND st.name IN (''tinyint'', ''smallint'', ''int'', ''money'', ''smallmoney'', ''decimal'', ''bigint'', ''datetime'', ''smalldateteime'', ''numeric'',  ''varchar'', ''nvarchar'', ''char'', ''nchar'', ''bit'')
	  order by c.column_id

SET @SQL = @SQL
        + ''      MAX(AuditDate) AS ''''Deleted''''''  + Char(13) + Char(10)
	    + ''  FROM Audit''   + Char(13) + Char(10)
	    + ''  Where TableName = '''''' +@SchemaName + ''.'' + @TableName + '''''' AND Operation = ''''d''''''  + Char(13) + Char(10)
	    + ''  GROUP BY PrimaryKey'' 

EXEC (@SQL)

RETURN -- END OF SPROC

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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AutoAuditDrop]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--------------------------------------------------------------------------------------------
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
SET @SQL = ''If EXISTS (Select * from sys.objects where name = ''
       + '''''''' + @TableName + ''_Audit_Insert'' + '''''' )''
       + '' DROP TRIGGER '' + @SchemaName + ''.'' + @TableName + ''_Audit_Insert''
EXEC (@SQL)

-- drop existing update trigger
SET @SQL = ''If EXISTS (Select * from sys.objects where name = ''
       + '''''''' + @TableName + ''_Audit_Update'' + '''''' )''
       + '' DROP TRIGGER '' + @SchemaName + ''.'' + @TableName + ''_Audit_Update''
EXEC (@SQL)

-- drop existing modified trigger
SET @SQL = ''If EXISTS (Select * from sys.objects where name = ''
       + '''''''' + @TableName + ''_Modified'' + '''''' )''
       + '' DROP TRIGGER '' + @SchemaName + ''.'' + @TableName + ''_Modified''
EXEC (@SQL)

-- drop existing delete trigger
SET @SQL = ''If EXISTS (Select * from sys.objects where name = ''
       + '''''''' + @TableName + ''_Audit_Delete'' + '''''' )''
       + '' DROP TRIGGER '' + @SchemaName + ''.'' + @TableName + ''_Audit_Delete''
EXEC (@SQL)

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AutoAuditAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
			 where t.name <> ''audit''
--2 
OPEN cTables
--3 
FETCH cTables INTO @SchemaName, @TableName   -- prime the cursor
WHILE @@Fetch_Status = 0 
  BEGIN
		SET @SQL = ''EXEC AutoAudit '''''' + @SchemaName + '''''', '''''' + @TableName + ''''''''
		EXEC (@SQL)
      FETCH cTables INTO @SchemaName, @TableName   -- fetch next
  END
-- 4  
CLOSE cTables
-- 5
DEALLOCATE cTables

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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AutoAuditDropAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--------------------------------------------------------------------------------------------
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
			 where t.name <> ''audit''
--2 
OPEN cTables
--3 
FETCH cTables INTO @SchemaName, @TableName   -- prime the cursor
WHILE @@Fetch_Status = 0 
  BEGIN
		SET @SQL = ''EXEC AutoAuditDrop '''''' + @SchemaName + '''''', '''''' + @TableName + ''''''''
		EXEC (@SQL)
      FETCH cTables INTO @SchemaName, @TableName   -- fetch next
  END
-- 4  
CLOSE cTables
-- 5
DEALLOCATE cTables

-- end of file




' 
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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteTaxPayers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteTaxPayers]
 @ID int
 AS 
     DELETE FROM dbo.TaxPayers WHERE TaxPayerID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteTaxPayments]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteTaxPayments]
 @ID bigint
 AS 
     DELETE FROM dbo.TaxPayments WHERE PaymentID=@ID
' 
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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetColumnList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROC [dbo].[GetColumnList]
@table sysname
AS
DECLARE @columns table(
tbqual sysname,owner sysname,tbname sysname,colname sysname,
datatype smallint, typename sysname, precis int, length int, 
scale smallint,radix smallint, nullable smallint,remarks varchar(254),
coldef varchar(4000),sqldbtype int, sqldatetimesub int, octet int,
ordinal smallint,isnullable varchar(254), ssdatatype smallint
)
Insert into @columns EXEC sp_columns @table_name=@table

DECLARE @colstring varchar(8000)
SELECT @colstring=ISNULL(@colstring,'''') + colname + '', '' FROM @columns
SET @colstring=LEFT(@colstring,DATALENGTH(@colstring)-2)
PRINT @colstring


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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNewBanks]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetNewBanks]
@lastdate datetime
AS
	SET NOCOUNT ON
	DECLARE @DistrictID smallint
	
	IF EXISTS(SELECT * FROM Banks_Audit)
		SELECT * FROM Banks_Audit WHERE Created>@lastdate
	ELSE
		BEGIN
			SET @DistrictID=(SELECT DistrictID FROM Settings)
			SELECT *,District=@DistrictID,Action=''I'' FROM Banks
		END
	RETURN
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
/*Stored Proc: Scripted 05/12/2007   */

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
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteBanks]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*Stored Proc: Scripted 05/12/2007  */

CREATE PROCEDURE [dbo].[DeleteBanks]
 @ID tinyint
 AS 
     DELETE FROM dbo.Banks WHERE BankID=@ID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNewBankBranches]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetNewBankBranches] 
@lastdate datetime
AS
	SET NOCOUNT ON
	DECLARE @DistrictID smallint
	
	IF EXISTS(SELECT * FROM BankBranches_Audit)
		SELECT * FROM BankBranches_Audit WHERE Created>@lastdate
	ELSE
		SET @DistrictID=(SELECT DistrictID FROM Settings)
		SELECT *,DistrictID=@DistrictID,Action=''I'' FROM BankBranches
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vDistricts_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vDistricts_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[DistrictID]'' THEN OldValue ELSE '''' END) AS [DistrictID],
     Max(Case ColumnName WHEN ''[ProvinceID]'' THEN OldValue ELSE '''' END) AS [ProvinceID],
     Max(Case ColumnName WHEN ''[DistrictName]'' THEN OldValue ELSE '''' END) AS [DistrictName],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.Districts'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vLandparcels_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vLandparcels_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  3:13PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[LandParcelID]'' THEN OldValue ELSE '''' END) AS [LandParcelID],
     Max(Case ColumnName WHEN ''[TaxPayerID]'' THEN OldValue ELSE '''' END) AS [TaxPayerID],
     Max(Case ColumnName WHEN ''[PlotNumber]'' THEN OldValue ELSE '''' END) AS [PlotNumber],
     Max(Case ColumnName WHEN ''[Year]'' THEN OldValue ELSE '''' END) AS [Year],
     Max(Case ColumnName WHEN ''[StandingLevel]'' THEN OldValue ELSE '''' END) AS [StandingLevel],
     Max(Case ColumnName WHEN ''[LandTitle]'' THEN OldValue ELSE '''' END) AS [LandTitle],
     Max(Case ColumnName WHEN ''[TitleNumber]'' THEN OldValue ELSE '''' END) AS [TitleNumber],
     Max(Case ColumnName WHEN ''[Usage]'' THEN OldValue ELSE '''' END) AS [Usage],
     Max(Case ColumnName WHEN ''[NumberOfHouses]'' THEN OldValue ELSE '''' END) AS [NumberOfHouses],
     Max(Case ColumnName WHEN ''[ContractNumber]'' THEN OldValue ELSE '''' END) AS [ContractNumber],
     Max(Case ColumnName WHEN ''[ContractDate]'' THEN OldValue ELSE '''' END) AS [ContractDate],
     Max(Case ColumnName WHEN ''[Amount]'' THEN OldValue ELSE '''' END) AS [Amount],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.Landparcels'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vTaxPayments_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vTaxPayments_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  3:12PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[PaymentID]'' THEN OldValue ELSE '''' END) AS [PaymentID],
     Max(Case ColumnName WHEN ''[TaxPayerID]'' THEN OldValue ELSE '''' END) AS [TaxPayerID],
     Max(Case ColumnName WHEN ''[PaymentDate]'' THEN OldValue ELSE '''' END) AS [PaymentDate],
     Max(Case ColumnName WHEN ''[Amount]'' THEN OldValue ELSE '''' END) AS [Amount],
     Max(Case ColumnName WHEN ''[Description]'' THEN OldValue ELSE '''' END) AS [Description],
     Max(Case ColumnName WHEN ''[Cashier]'' THEN OldValue ELSE '''' END) AS [Cashier],
     Max(Case ColumnName WHEN ''[TaxTypeID]'' THEN OldValue ELSE '''' END) AS [TaxTypeID],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.TaxPayments'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vBanks_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vBanks_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[BankID]'' THEN OldValue ELSE '''' END) AS [BankID],
     Max(Case ColumnName WHEN ''[BankName]'' THEN OldValue ELSE '''' END) AS [BankName],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.Banks'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vTaxPayers_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vTaxPayers_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  3:10PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[TaxPayerID]'' THEN OldValue ELSE '''' END) AS [TaxPayerID],
     Max(Case ColumnName WHEN ''[CellID]'' THEN OldValue ELSE '''' END) AS [CellID],
     Max(Case ColumnName WHEN ''[FileNumber]'' THEN OldValue ELSE '''' END) AS [FileNumber],
     Max(Case ColumnName WHEN ''[Address]'' THEN OldValue ELSE '''' END) AS [Address],
     Max(Case ColumnName WHEN ''[Telephone]'' THEN OldValue ELSE '''' END) AS [Telephone],
     Max(Case ColumnName WHEN ''[Mobile]'' THEN OldValue ELSE '''' END) AS [Mobile],
     Max(Case ColumnName WHEN ''[Profession]'' THEN OldValue ELSE '''' END) AS [Profession],
     Max(Case ColumnName WHEN ''[DateOfBirth]'' THEN OldValue ELSE '''' END) AS [DateOfBirth],
     Max(Case ColumnName WHEN ''[IDNumber]'' THEN OldValue ELSE '''' END) AS [IDNumber],
     Max(Case ColumnName WHEN ''[IDType]'' THEN OldValue ELSE '''' END) AS [IDType],
     Max(Case ColumnName WHEN ''[TIN]'' THEN OldValue ELSE '''' END) AS [TIN],
     Max(Case ColumnName WHEN ''[Email]'' THEN OldValue ELSE '''' END) AS [Email],
     Max(Case ColumnName WHEN ''[Names]'' THEN OldValue ELSE '''' END) AS [Names],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.TaxPayers'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vTaxTypes_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vTaxTypes_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[TaxTypeID]'' THEN OldValue ELSE '''' END) AS [TaxTypeID],
     Max(Case ColumnName WHEN ''[TaxTypeName]'' THEN OldValue ELSE '''' END) AS [TaxTypeName],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.TaxTypes'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vHouseTenants_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vHouseTenants_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  3:12PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[HouseID]'' THEN OldValue ELSE '''' END) AS [HouseID],
     Max(Case ColumnName WHEN ''[PlotNumber]'' THEN OldValue ELSE '''' END) AS [PlotNumber],
     Max(Case ColumnName WHEN ''[FullName]'' THEN OldValue ELSE '''' END) AS [FullName],
     Max(Case ColumnName WHEN ''[Telephone]'' THEN OldValue ELSE '''' END) AS [Telephone],
     Max(Case ColumnName WHEN ''[Address]'' THEN OldValue ELSE '''' END) AS [Address],
     Max(Case ColumnName WHEN ''[Amount]'' THEN OldValue ELSE '''' END) AS [Amount],
     Max(Case ColumnName WHEN ''[TaxPayerID]'' THEN OldValue ELSE '''' END) AS [TaxPayerID],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.HouseTenants'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vBankBranches_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vBankBranches_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[BankBranchID]'' THEN OldValue ELSE '''' END) AS [BankBranchID],
     Max(Case ColumnName WHEN ''[BankID]'' THEN OldValue ELSE '''' END) AS [BankID],
     Max(Case ColumnName WHEN ''[BankBranchName]'' THEN OldValue ELSE '''' END) AS [BankBranchName],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.BankBranches'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vFeePayments_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vFeePayments_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  3:12PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[PaymentID]'' THEN OldValue ELSE '''' END) AS [PaymentID],
     Max(Case ColumnName WHEN ''[TaxPayerID]'' THEN OldValue ELSE '''' END) AS [TaxPayerID],
     Max(Case ColumnName WHEN ''[Designation]'' THEN OldValue ELSE '''' END) AS [Designation],
     Max(Case ColumnName WHEN ''[PaymentDate]'' THEN OldValue ELSE '''' END) AS [PaymentDate],
     Max(Case ColumnName WHEN ''[Amount]'' THEN OldValue ELSE '''' END) AS [Amount],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.FeePayments'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vProvinces_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vProvinces_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[ProvinceID]'' THEN OldValue ELSE '''' END) AS [ProvinceID],
     Max(Case ColumnName WHEN ''[ProvinceName]'' THEN OldValue ELSE '''' END) AS [ProvinceName],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.Provinces'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vBankAccounts_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vBankAccounts_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  3:12PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[BankAccountID]'' THEN OldValue ELSE '''' END) AS [BankAccountID],
     Max(Case ColumnName WHEN ''[BankBranchID]'' THEN OldValue ELSE '''' END) AS [BankBranchID],
     Max(Case ColumnName WHEN ''[AccountNumber]'' THEN OldValue ELSE '''' END) AS [AccountNumber],
     Max(Case ColumnName WHEN ''[TaxPayerID]'' THEN OldValue ELSE '''' END) AS [TaxPayerID],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.BankAccounts'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vUserPermissions_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vUserPermissions_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[UserPermissionID]'' THEN OldValue ELSE '''' END) AS [UserPermissionID],
     Max(Case ColumnName WHEN ''[UserID]'' THEN OldValue ELSE '''' END) AS [UserID],
     Max(Case ColumnName WHEN ''[PermissionID]'' THEN OldValue ELSE '''' END) AS [PermissionID],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.UserPermissions'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vBusinesses_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vBusinesses_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  3:12PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[BusinessID]'' THEN OldValue ELSE '''' END) AS [BusinessID],
     Max(Case ColumnName WHEN ''[PlotNumber]'' THEN OldValue ELSE '''' END) AS [PlotNumber],
     Max(Case ColumnName WHEN ''[BusinessName]'' THEN OldValue ELSE '''' END) AS [BusinessName],
     Max(Case ColumnName WHEN ''[Profession]'' THEN OldValue ELSE '''' END) AS [Profession],
     Max(Case ColumnName WHEN ''[StartDate]'' THEN OldValue ELSE '''' END) AS [StartDate],
     Max(Case ColumnName WHEN ''[Amount]'' THEN OldValue ELSE '''' END) AS [Amount],
     Max(Case ColumnName WHEN ''[Address]'' THEN OldValue ELSE '''' END) AS [Address],
     Max(Case ColumnName WHEN ''[TaxPayerID]'' THEN OldValue ELSE '''' END) AS [TaxPayerID],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.Businesses'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vPermissions_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vPermissions_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[PermissionID]'' THEN OldValue ELSE '''' END) AS [PermissionID],
     Max(Case ColumnName WHEN ''[PermissionName]'' THEN OldValue ELSE '''' END) AS [PermissionName],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.Permissions'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vCells_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vCells_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[CellID]'' THEN OldValue ELSE '''' END) AS [CellID],
     Max(Case ColumnName WHEN ''[SectorID]'' THEN OldValue ELSE '''' END) AS [SectorID],
     Max(Case ColumnName WHEN ''[CellName]'' THEN OldValue ELSE '''' END) AS [CellName],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.Cells'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vProperties_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vProperties_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  3:13PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[PropertyID]'' THEN OldValue ELSE '''' END) AS [PropertyID],
     Max(Case ColumnName WHEN ''[PlotNumber]'' THEN OldValue ELSE '''' END) AS [PlotNumber],
     Max(Case ColumnName WHEN ''[OwnersName]'' THEN OldValue ELSE '''' END) AS [OwnersName],
     Max(Case ColumnName WHEN ''[Usage]'' THEN OldValue ELSE '''' END) AS [Usage],
     Max(Case ColumnName WHEN ''[DateOfAcquisition]'' THEN OldValue ELSE '''' END) AS [DateOfAcquisition],
     Max(Case ColumnName WHEN ''[OwnerValuation]'' THEN OldValue ELSE '''' END) AS [OwnerValuation],
     Max(Case ColumnName WHEN ''[DistrictValuation]'' THEN OldValue ELSE '''' END) AS [DistrictValuation],
     Max(Case ColumnName WHEN ''[TaxPayerID]'' THEN OldValue ELSE '''' END) AS [TaxPayerID],
     Max(Case ColumnName WHEN ''[Amount]'' THEN OldValue ELSE '''' END) AS [Amount],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.Properties'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vSectors_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vSectors_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[SectorID]'' THEN OldValue ELSE '''' END) AS [SectorID],
     Max(Case ColumnName WHEN ''[DistrictID]'' THEN OldValue ELSE '''' END) AS [DistrictID],
     Max(Case ColumnName WHEN ''[SectorName]'' THEN OldValue ELSE '''' END) AS [SectorName],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.Sectors'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vUsers_Deleted]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vUsers_Deleted]
AS 
 -- generated by AutoAudit on Feb  7 2008  2:54PM
 -- created by Paul Nielsen 
 -- www.SQLServerBible.com 

SELECT 
     Max(Case ColumnName WHEN ''[UserID]'' THEN OldValue ELSE '''' END) AS [UserID],
     Max(Case ColumnName WHEN ''[DistrictID]'' THEN OldValue ELSE '''' END) AS [DistrictID],
     Max(Case ColumnName WHEN ''[UserName]'' THEN OldValue ELSE '''' END) AS [UserName],
     Max(Case ColumnName WHEN ''[Password]'' THEN OldValue ELSE '''' END) AS [Password],
     Max(Case ColumnName WHEN ''[FullName]'' THEN OldValue ELSE '''' END) AS [FullName],
     Max(Case ColumnName WHEN ''[Status]'' THEN OldValue ELSE '''' END) AS [Status],
     Max(Case ColumnName WHEN ''[Created]'' THEN OldValue ELSE '''' END) AS [Created],
     Max(Case ColumnName WHEN ''[Modified]'' THEN OldValue ELSE '''' END) AS [Modified],
     Max(Case ColumnName WHEN ''[RowVersion]'' THEN OldValue ELSE '''' END) AS [RowVersion],
      MAX(AuditDate) AS ''Deleted''
  FROM Audit
  Where TableName = ''dbo.Users'' AND Operation = ''d''
  GROUP BY PrimaryKey' 
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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistricts]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetDistricts]
@ProvinceID tinyint=0
 AS 
     SELECT d.DistrictID,d.ProvinceID,d.DistrictName,NumberOfSectors=COUNT(s.SectorID) 
		FROM dbo.Districts d LEFT JOIN Sectors s
		ON d.DistrictID=s.DistrictID
		WHERE d.ProvinceID=@ProvinceID
		GROUP BY d.DistrictName,d.DistrictID,d.ProvinceID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateSettings]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[UpdateSettings]
@DistrictName varchar(50)
AS
	SET NOCOUNT ON
	
	DECLARE @DistrictID smallint, @ProvinceID smallint
	SELECT @DistrictID=DistrictID,@ProvinceID=ProvinceID FROM Districts WHERE DistrictName=@DistrictName
	DELETE Settings
		INSERT INTO Settings(DistrictID,ProvinceID)
			VALUES (@DistrictID,@ProvinceID)
	RETURN

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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSectors]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[GetSectors]
@districtID tinyint
 AS 
     SELECT s.*,NumberOfCells=COUNT(c.CellID) 
		FROM dbo.Sectors s LEFT JOIN Cells c
		ON s.SectorID=c.SectorID
		WHERE s.DistrictID=@districtID
		GROUP BY s.SectorName,s.SectorID, s.DistrictID
		ORDER BY s.SectorName

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
--@SectorID smallint=0
 AS 
     SELECT t.*,Sector=s.SectorName,Cell=c.CellName,SectorID=s.SectorID 
     FROM dbo.TaxPayers t JOIN Cells c 
     ON t.CellID=c.CellID JOIN Sectors s
     ON c.SectorID=s.SectorID
     --WHERE s.SectorID=@SectorID
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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetFeePaymentsByPeriodAndSector]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetFeePaymentsByPeriodAndSector]
--@SectorID tinyint,
--@Startdate datetime,
--@enddate datetime
 AS 
 --IF @SectorID>0
     SELECT tp.*,TaxPayerName=t.Names,Sector=s.Sectorname, Cell=c.CellName, SectorID=s.SectorID
     FROM dbo.FeePayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID JOIN Cells c
     ON t.CellID=c.CellID JOIN Sectors s ON
     s.SectorID=c.SectorID
     --WHERE tp.Paymentdate>=@startdate AND tp.Paymentdate<=@enddate
     --AND s.SectorID=@SectorID
   /*
   ELSE
       SELECT tp.*,TaxPayerName=t.Names,Sector=s.Sectorname, Cell=c.CellName
     FROM dbo.FeePayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID JOIN Cells c
     ON t.CellID=c.CellID JOIN Sectors s ON
     s.SectorID=c.SectorID
     WHERE tp.Paymentdate>=@startdate AND tp.Paymentdate<=@enddate
    */
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[TaxPayerRegistry]'))
EXEC dbo.sp_executesql @statement = N'CREATE View [dbo].[TaxPayerRegistry]
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

' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPaymentsByPeriodAndType]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetTaxPaymentsByPeriodAndType]
--@TaxType tinyint,
--@Startdate datetime,
--@enddate datetime
 AS 
 --IF @TaxType>0
     SELECT tp.*,TaxPayerName=t.Names,TaxTypeName=ISNULL(tt.TaxTypeName,''''),Sector=s.Sectorname, Cell=c.CellName
     FROM dbo.TaxPayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID LEFT JOIN TaxTypes tt
     ON tp.TaxTypeID=tt.TaxTypeID JOIN Cells c
     ON t.CellID=c.CellID JOIN Sectors s ON
     s.SectorID=c.SectorID
     --WHERE tp.Paymentdate>=@startdate AND tp.Paymentdate<=@enddate
     --AND tt.TaxTypeID=@TaxType
   --ELSE
   --    SELECT tp.*,TaxPayerName=t.Names,TaxTypeName=ISNULL(tt.TaxTypeName,''''),Sector=s.Sectorname, Cell=c.CellName
    -- FROM dbo.TaxPayments tp JOIN TaxPayers t
     --ON tp.TaxPayerID=t.TaxPayerID LEFT JOIN TaxTypes tt
     --ON tp.TaxTypeID=tt.TaxTypeID JOIN Cells c
     --ON t.CellID=c.CellID JOIN Sectors s ON
     --s.SectorID=c.SectorID
     --WHERE tp.Paymentdate>=@startdate AND tp.Paymentdate<=@enddate
     
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
--@SectorID tinyint,
--@Startdate datetime,
--@enddate datetime
 AS 
 --IF @SectorID>0
     SELECT tp.*,TaxPayerName=t.Names,TaxTypeName=ISNULL(tt.TaxTypeName,''''),Sector=s.Sectorname, Cell=c.CellName,SectorID=s.SectorID
     FROM dbo.TaxPayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID LEFT JOIN TaxTypes tt
     ON tp.TaxTypeID=tt.TaxTypeID JOIN Cells c
     ON t.CellID=c.CellID JOIN Sectors s ON
     s.SectorID=c.SectorID
     --WHERE tp.Paymentdate>=@startdate AND tp.Paymentdate<=@enddate
     --AND s.SectorID=@SectorID
   --ELSE
     /*  SELECT tp.*,TaxPayerName=t.Names,TaxTypeName=ISNULL(tt.TaxTypeName,''''),Sector=s.Sectorname, Cell=c.CellName
     FROM dbo.TaxPayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID LEFT JOIN TaxTypes tt
     ON tp.TaxTypeID=tt.TaxTypeID JOIN Cells c
     ON t.CellID=c.CellID JOIN Sectors s ON
     s.SectorID=c.SectorID
     WHERE tp.Paymentdate>=@startdate AND tp.Paymentdate<=@enddate
     */
     
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUserByUserName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetUserByUserName]
@username varchar(30)
AS
	SET NOCOUNT ON
	SELECT * FROM Users
		WHERE Username=@username
		
	RETURN
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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCellIDFromTaxpayerID]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[GetCellIDFromTaxpayerID](@TaxpayerID int)
RETURNS smallint
AS
	BEGIN
		DECLARE @CellID smallint
		SET @CellID=(SELECT CellID FROM Taxpayers WHERE TaxPayerID=@TaxPayerID)
		RETURN @CellID
	END' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertTaxPayers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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
 AS 
     SELECT tp.*,TaxPayerName=t.Names 
     FROM dbo.TaxPayments tp JOIN TaxPayers t
     ON tp.TaxPayerID=t.TaxPayerID
     --WHERE tp.Paymentdate BETWEEN @startdate AND @enddate
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
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[TaxPayersWithoutPayments]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[TaxPayersWithoutPayments]
AS
SELECT taxpayerID from taxpayers
EXCEPT 
SELECT taxpayerID from taxpayments' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNewTaxpayers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROC [dbo].[GetNewTaxpayers]
@lastdate datetime
AS
IF EXISTS(SELECT * FROM Taxpayers_Audit)
	SELECT * FROM Taxpayers_Audit WHERE created>@lastdate
ELSE
	SELECT *,Action=''I'' FROM Taxpayers ' 
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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertTaxPayments]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[InsertTaxPayments]
@PaymentID bigint, @TaxPayerID int, @PaymentDate datetime, 
@Amount money, @Description varchar(100),@Cashier varchar(50)='''' ,
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
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPeriods]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[GetTaxPeriods]()
RETURNS tinyint
AS
BEGIN
	DECLARE @years tinyint
	SET @years=(Select period=DATEDIFF(Year,Min(paymentdate),GETDATE())+1 from taxpayments)
	RETURN @years
END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTotalPayments]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[GetTotalPayments](@TaxpayerID int)
RETURNS money
AS
BEGIN
	DECLARE @total money
	SET @total=(SELECT SUM(Amount) FROM Taxpayments WHERE TaxpayerID=@TaxpayerID)
	RETURN ISNULL(@total,0)
END' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertProperties]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
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

' 
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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPayersForRemote]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROC [dbo].[GetTaxPayersForRemote]
@lastdate datetime
 AS 
     SELECT * 
     FROM dbo.TaxPayers_Audit
     WHERE created>@lastdate
     ' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertHouseTenants]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[InsertHouseTenants]
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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertBusinesses]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[InsertBusinesses]
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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNewProperties]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetNewProperties]
@lastdate datetime
AS
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM Properties_Audit)
		SELECT * FROM Properties_Audit WHERE Created>@lastdate
	ELSE
		SELECT *,CellID=dbo.GetCellIDFromTaxpayerID(TaxpayerID),Action=''I'' FROM Properties
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNewBankAccounts]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetNewBankAccounts] 
@lastdate datetime
AS
	SET NOCOUNT ON
		
	IF EXISTS(SELECT * FROM BankAccounts_Audit)
		SELECT * FROM BankAccounts_Audit WHERE Created>@lastdate
	ELSE
		SELECT *,CellID=dbo.GetCellIDFromTaxpayerID(TaxpayerID),Action=''I'' FROM BankAccounts
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNewTaxPayments]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetNewTaxPayments] 
@lastdate datetime
AS
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM Taxpayments_Audit)
		SELECT * FROM Taxpayments_Audit WHERE created>@lastdate
	ELSE
		SELECT *,CellID=dbo.GetCellIDFromTaxpayerID(TaxpayerID),Action=''I'' FROM Taxpayments
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNewLandParcels]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetNewLandParcels]
@lastdate datetime
AS
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM LandParcels_Audit)
		SELECT * FROM LandParcels_Audit WHERE Created>@lastdate
	ELSE
		SELECT *,CellID=dbo.GetCellIDFromTaxpayerID(TaxpayerID),Action=''I'' FROM LandParcels
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNewFeePayments]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetNewFeePayments] 
@lastdate datetime
AS
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM FeePayments_Audit)
		SELECT * FROM FeePayments_Audit	WHERE created>@lastdate
	ELSE
		SELECT *,CellID=dbo.GetCellIDFromTaxpayerID(TaxpayerID),Action=''I'' FROM FeePayments
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNewHouseTenants]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetNewHouseTenants]
@lastdate datetime
AS
	SET NOCOUNT ON
	IF EXISTS(SELECT * FROM Housetenants_Audit)
		SELECT * FROM Housetenants_Audit WHERE Created>@lastdate
	ELSE
		SELECT *,CellID=dbo.GetCellIDFromTaxpayerID(TaxpayerID),Action=''I'' FROM Housetenants
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNewBusinesses]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetNewBusinesses] 
	@lastdate datetime
AS
	SET NOCOUNT ON  
	DECLARE @CellID smallint
	IF EXISTS(SELECT * FROM Businesses_Audit)
		SELECT * FROM Businesses_Audit WHERE Created>@lastdate
	ELSE
		SELECT *,CellID=dbo.GetCellIDFromTaxPayerID(TaxpayerID),Action=''I'' FROM Businesses	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDefaulters]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetDefaulters]
AS
DECLARE @periods tinyint;
SET @periods=(SELECT dbo.GetTaxPeriods());

WITH payments AS
(
Select *, Expected=(ISNULL(BusinessTax,0) + ISNULL(landtax,0) + ISNULL(propertytax,0) + ISNULL(RentalTax,0)) * @periods , 
Payed=dbo.GetTotalPayments(taxpayerid),Years=@periods
From taxpayerregistry
)

SELECT * FROM payments WHERE Expected>Payed' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTaxPayers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROC [dbo].[GetTaxPayers]
 AS 
     SELECT * 
     FROM dbo.TaxPayerRegistry
     
' 
END
