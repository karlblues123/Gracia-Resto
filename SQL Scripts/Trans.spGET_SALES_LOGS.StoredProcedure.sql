USE [GRDB]
GO

/****** Object:  StoredProcedure [Trans].[spGET_SALES_LOGS]    Script Date: 9/10/2024 11:13:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the Sales log
-- =============================================
CREATE PROCEDURE [Trans].[spGET_SALES_LOGS] 
	
AS
BEGIN
	SELECT L.*, H.Customer, U.Username
	FROM Trans.Sales_Trail L
	INNER JOIN Trans.Sales_Hdr H
	ON L.SalesCode = H.SalesCode
	INNER JOIN xSystem.User_Data U
	ON L.UserID = U.ID
END


GO

