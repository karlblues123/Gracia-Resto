USE [CGDB]
GO

/****** Object:  StoredProcedure [xSystem].[GET_SERIES_NUMBER]    Script Date: 2/3/2024 10:54:06 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	GET the current series number of a given prefix
-- =============================================
CREATE PROCEDURE [xSystem].[GET_SERIES_NUMBER] 
	-- Add the parameters for the stored procedure here
	@PREFIX nchar(5)
AS
BEGIN
	
	SELECT Series
	FROM xSystem.SeriesNumber_RF
	WHERE Prefix = @PREFIX

END

GO

