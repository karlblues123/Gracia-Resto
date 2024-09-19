USE [GRDB]
GO

/****** Object:  StoredProcedure [Master].[spGET_TABLE_BY_CODE]    Script Date: 9/9/2024 3:04:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get table via code
-- =============================================
CREATE PROCEDURE [Master].[spGET_TABLE_BY_CODE] 
	-- Add the parameters for the stored procedure here
	@TABLECODE nvarchar(6)
AS
BEGIN
	
	SELECT *
	FROM [Master].[Tables_MF] A
	INNER JOIN [Master].[Table_Status_RF] B
	ON A.TableNumber = B.TableNumber
	WHERE TableCode = @TABLECODE

END

GO

