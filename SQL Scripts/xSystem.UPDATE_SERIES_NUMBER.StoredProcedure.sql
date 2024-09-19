USE [GRDB]
GO
/****** Object:  StoredProcedure [xSystem].[UPDATE_SERIES_NUMBER]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	INCREMENT Selected Prefix
-- =============================================
CREATE PROCEDURE [xSystem].[UPDATE_SERIES_NUMBER] 
	-- Add the parameters for the stored procedure here
	@PREFIX nchar(5)
AS
BEGIN
	
	UPDATE [xSystem].SeriesNumber_RF
	SET Series = Series + 1
	WHERE Prefix = @PREFIX
	 
END


GO
