USE [GRDB]
GO

/****** Object:  StoredProcedure [Trans].[spGET_PAID_SALES]    Script Date: 9/7/2024 11:37:00 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the Paid Sales based on given time frame
-- =============================================
CREATE PROCEDURE [Trans].[spGET_PAID_SALES] 
	-- Add the parameters for the stored procedure here
	@STARTDATE datetime, 
	@ENDDATE datetime
AS
BEGIN
	
	SELECT H.*
	FROM Trans.Sales_Hdr H
	WHERE H.Status = 2
	AND H.Date BETWEEN @STARTDATE AND @ENDDATE

END


GO

