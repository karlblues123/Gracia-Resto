USE [GRDB]
GO

/****** Object:  StoredProcedure [Kitchen].[spGET_KITCHEN_LOGS]    Script Date: 9/10/2024 11:09:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get Kitchen logs
-- =============================================
CREATE PROCEDURE [Kitchen].[spGET_KITCHEN_LOGS] 

AS
BEGIN
	
	SELECT A.ID, A.ActionMade, A.DI, C.Username
	FROM Kitchen.Audit_Trail A
	INNER JOIN Trans.Sales_Hdr B
	ON A.SalesCode = B.SalesCode
	INNER JOIN xSystem.User_Data C
	ON A.UserID = C.ID

END


GO

