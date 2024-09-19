USE [GRDB]
GO

/****** Object:  StoredProcedure [Trans].[spGET_SALES_HDR]    Script Date: 9/7/2024 11:25:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the Hdr of the selected Sales Transaction
-- =============================================
CREATE PROCEDURE [Trans].[spGET_SALES_HDR] 
	-- Add the parameters for the stored procedure here
	@SALESCODE nvarchar(15)
AS
BEGIN
	
	SELECT H.*
	FROM Trans.Sales_Hdr H
	WHERE SalesCode = @SALESCODE
	 
END





GO

