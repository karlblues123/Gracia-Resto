USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spGET_SALES_STATUSES]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the Sales Type RFs
-- =============================================
CREATE PROCEDURE [Trans].[spGET_SALES_STATUSES]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	
	SELECT *
	FROM Trans.Sales_Status_RF

END



GO
