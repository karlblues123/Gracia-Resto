USE [CGDB]
GO

/****** Object:  StoredProcedure [Trans].[GET_SALES_HDR]    Script Date: 2/8/2024 4:44:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the Hdr of the selected Sales Transaction
-- =============================================
CREATE PROCEDURE [Trans].[GET_SALES_HDR] 
	-- Add the parameters for the stored procedure here
	@SALESCODE nvarchar(15)
AS
BEGIN
	
	SELECT *
	FROM Trans.Sales_Hdr
	WHERE SalesCode = @SALESCODE
	 
END


GO


