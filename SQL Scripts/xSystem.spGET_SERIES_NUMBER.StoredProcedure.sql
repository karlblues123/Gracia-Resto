USE [GRDB]
GO
/****** Object:  StoredProcedure [xSystem].[spGET_SERIES_NUMBER]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	GET the current series number of a given prefix
-- =============================================
CREATE PROCEDURE [xSystem].[spGET_SERIES_NUMBER] 
	-- Add the parameters for the stored procedure here
	@PREFIX nchar(5)
AS
BEGIN
	
	SELECT Series
	FROM xSystem.SeriesNumber_RF
	WHERE Prefix = @PREFIX

END



GO
