USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spGET_ITEM_DATA]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Menu].[spGET_ITEM_DATA] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	SELECT *
	FROM Menu.Item_Data
END



GO
