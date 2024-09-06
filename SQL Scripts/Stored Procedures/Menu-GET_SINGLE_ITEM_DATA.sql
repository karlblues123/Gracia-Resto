USE [CGDB]
GO

/****** Object:  StoredProcedure [Menu].[GET_SINGLE_ITEM_DATA]    Script Date: 2/3/2024 10:48:47 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Menu].[GET_SINGLE_ITEM_DATA] 
	-- Add the parameters for the stored procedure here
	@ITEMCODE nvarchar(20)
AS
BEGIN
	
	SELECT ItemCode, ItemName, ItemPrice, ItemUM
	FROM [Menu].[Item_Data]
	WHERE ItemCode = @ITEMCODE

END

GO

