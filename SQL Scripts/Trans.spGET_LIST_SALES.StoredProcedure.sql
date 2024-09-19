USE [GRDB]
GO

/****** Object:  StoredProcedure [Trans].[spGET_LIST_SALES]    Script Date: 9/7/2024 11:35:05 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Trans].[spGET_LIST_SALES] 
	
AS
BEGIN
	
	SELECT H.*
	FROM Trans.Sales_Hdr H


END




GO

