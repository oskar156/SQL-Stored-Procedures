/* Stored Procedure - GRP
	
-concise way of grouping a table
-instead of typing SELECT X, COUNT(*) FROM TABLE GROUP BY X ORDER BY Y, just write GRP TABLE,'X','Y'

-1st parameter, tablename is required
-2nd parameter, cols is required
	-these are the columns to group by
-3rd parameter, order is optional
	-these are the columns to order by
	-if left blank, it will default to the columns to group by (COLS)
-4th parameter, dbname is optional 
	-if left blank it will use the DB currently in use
*/

USE [TEMP_OK]
GO
/****** Object:  StoredProcedure [dbo].[GRP]    Script Date: 11/29/2023 11:04:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GRP]
	-- Add the parameters for the stored procedure here
	@TABLENAME VARCHAR(255)
	,@COLS VARCHAR(255)
	,@ORDER VARCHAR(255)=''
	,@DBNAME VARCHAR(255)=''
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

    --Get count
    SET @Sql = N' SELECT ' + @COLS + ' , COUNT(*) AS [COUNT] FROM ' + @DBNAME + '..[' + @TABLENAME + '] '
    SET @Sql = @Sql + ' GROUP BY ' + @COLS
    
    IF @ORDER <> '' BEGIN
        SET @Sql = @Sql + ' ORDER BY ' + @ORDER
    END
    IF @ORDER = '' BEGIN
        SET @Sql = @Sql + ' ORDER BY ' + @COLS
    END
    EXECUTE sp_executesql @Sql
END
