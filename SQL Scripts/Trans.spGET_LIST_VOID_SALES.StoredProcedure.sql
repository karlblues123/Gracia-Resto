USE [GRDB]
GO

/****** Object:  StoredProcedure [Trans].[spGET_LIST_VOID_SALES]    Script Date: 9/10/2024 11:16:47 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the list of of Void Sales
-- =============================================
CREATE PROCEDURE [Trans].[spGET_LIST_VOID_SALES] 

AS
BEGIN
	
	SELECT V.*, S.Customer,  U.Username
	FROM Trans.Void_Sales V
	INNER JOIN Trans.Sales_Hdr S
	ON V.SalesCode = S.SalesCode
	LEFT JOIN xSystem.User_Data U
	ON V.UserID = U.ID

END


GO

