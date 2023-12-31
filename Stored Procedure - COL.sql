/* Stored Procedure - COL
	
-shows a list of columns in the table
-columns displayed are bracketed []

-1st parameter, tablename is required
-2nd parameter, dbname is optional 
	-if left blank it will use the DB currently in use
-3rd parameter, prefix is optional 
	-adds a string to the left of each column name (useful for A., B, etc...)

*/

USE [TEMP_OK]
GO
/****** Object:  StoredProcedure [dbo].[COL]    Script Date: 11/21/2023 2:21:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[COL]
	-- Add the parameters for the stored procedure here
	@TABLENAME VARCHAR(255)
	,@DBNAME VARCHAR(255)=''
	,@PREFIX VARCHAR(255)=''
AS

BEGIN

    IF @DBNAME IS NULL OR @DBNAME = '' BEGIN
        SET @DBNAME = DB_NAME()
    END

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--SELECT <@Param1, sysname, @p1>, <@Param2, sysname, @p2>
    DECLARE @Sql NVARCHAR(4000);

    --Get all Column Names in a Table and surround them with ,[] (original order)
	SET @Sql = N' SELECT CONCAT(''' + @PREFIX + '['',COLUMN_NAME,'']'') as ['+ TRIM(@DBNAME + ' ' + @TABLENAME) + ' COLUMN_NAMES]'
	SET @Sql = @Sql + ' FROM ' + @DBNAME + '.information_schema.columns '
	SET @Sql = @Sql + ' WHERE table_name = ''' + @TABLENAME + ''' '
	EXECUTE sp_executesql @Sql
END

