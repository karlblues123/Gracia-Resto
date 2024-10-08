USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spGET_PO_LOGS]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get Purchase Order Logs
-- =============================================
CREATE PROCEDURE [Trans].[spGET_PO_LOGS] 

AS
BEGIN
	
	SELECT L.*, H.InCharge, U.Username
	FROM Trans.PO_Trail L
	INNER JOIN Trans.Item_PO_Hdr H
	ON L.POCode = H.POCode
	INNER JOIN xSystem.User_Data U
	ON L.UserID = U.ID

END

GO
