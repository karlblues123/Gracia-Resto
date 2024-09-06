USE [CGDB]
GO

/****** Object:  StoredProcedure [Trans].[GET_SALES_STATUSES]    Script Date: 2/13/2024 11:25:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the Sales Type RFs
-- =============================================
CREATE PROCEDURE [Trans].[GET_SALES_STATUSES]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	
	SELECT *
	FROM Trans.Sales_Status_RF

END

GO


