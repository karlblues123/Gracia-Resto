USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spGET_LIST_PO]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get a list of Purchase Order
-- =============================================
CREATE PROCEDURE [Trans].[spGET_LIST_PO] 
	
AS
BEGIN
	
	SELECT *
	FROM [Trans].[Item_PO_Hdr]

END



GO
