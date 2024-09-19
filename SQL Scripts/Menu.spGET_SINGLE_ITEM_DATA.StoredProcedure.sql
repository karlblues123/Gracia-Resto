USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spGET_SINGLE_ITEM_DATA]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Menu].[spGET_SINGLE_ITEM_DATA] 
	-- Add the parameters for the stored procedure here
	@ITEMCODE nvarchar(20)
AS
BEGIN
	
	SELECT ItemCode, Name, Price, UM
	FROM [Menu].[Item_Data]
	WHERE ItemCode = @ITEMCODE

END



GO
