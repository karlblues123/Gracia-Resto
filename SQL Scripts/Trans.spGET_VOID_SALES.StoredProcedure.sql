USE [GRDB]
GO

/****** Object:  StoredProcedure [Trans].[spGET_VOID_SALES]    Script Date: 9/10/2024 11:17:06 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get a specified void sales
-- =============================================
CREATE PROCEDURE [Trans].[spGET_VOID_SALES] 
	-- Add the parameters for the stored procedure here
	@SALESCODE nvarchar(15)

AS
BEGIN
	
	SELECT V.*, S.Customer
	FROM Trans.Void_Sales V
	INNER JOIN Trans.Sales_Hdr S
	ON V.SalesCode = S.SalesCode
	WHERE V.SalesCode = @SALESCODE

END


GO

