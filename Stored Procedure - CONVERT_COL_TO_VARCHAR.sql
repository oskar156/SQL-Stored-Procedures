/* Stored Procedure - CONVERT_COL_TO_VARCHAR
	
-lets you keep the same column name and values but converted to varchar

-1st parameter, tablename is required
-2nd parameter, column is required 
*/

USE [TEMP_OK]
GO
/****** Object:  StoredProcedure [dbo].[CONVERT_COL_TO_VARCHAR]    Script Date: 11/21/2023 2:21:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[CONVERT_COL_TO_VARCHAR]
	-- Add the parameters for the stored procedure here
	@TABLENAME VARCHAR(255)
	,@COLUMNNAME VARCHAR(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	exec(N'ALTER TABLE [' + @TABLENAME + '] ADD [TEMP_COLUMN] VARCHAR(255)')
	exec(N'UPDATE [' + @TABLENAME + '] SET [TEMP_COLUMN] = CAST([' + @COLUMNNAME + '] AS VARCHAR(255))')
	exec(N'ALTER TABLE [' + @TABLENAME + '] DROP COLUMN [' + @COLUMNNAME + ']')
	exec(N'ALTER TABLE [' + @TABLENAME + '] ADD [' + @COLUMNNAME + '] VARCHAR(255)')
	exec(N'UPDATE [' + @TABLENAME + '] SET [' + @COLUMNNAME + '] = [TEMP_COLUMN]')
	exec(N'ALTER TABLE [' + @TABLENAME + '] DROP COLUMN [TEMP_COLUMN]')

END

