USE [CGDB]
GO

/****** Object:  StoredProcedure [Trans].[GET_PO_ITEMS]    Script Date: 2/3/2024 10:52:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Trans].[GET_PO_ITEMS] 
	-- Add the parameters for the stored procedure here
	@POCODE nvarchar(15)

AS
BEGIN
	
	SELECT Menu.Item_Data.ItemCode, Menu.Item_Data.ItemName, Menu.Item_Data.ItemUM, Trans.Item_PO_Line.ItemPrice, Trans.Item_PO_Line.ItemQuantity, Trans.Item_PO_Line.ReceivedQuantity
	FROM Menu.Item_Data
	INNER JOIN Trans.Item_PO_Line ON Menu.Item_Data.ItemCode = Trans.Item_PO_Line.ItemCode
	WHERE Trans.Item_PO_Line.POCode = @POCODE

END

GO

