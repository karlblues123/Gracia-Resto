USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spGET_PO_ITEMS]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Trans].[spGET_PO_ITEMS] 
	-- Add the parameters for the stored procedure here
	@POCODE nvarchar(15)

AS
BEGIN
	
	SELECT D.ItemCode, D.Name, D.UM, L.Price, L.Quantity, L.ReceivedQuantity, L.ActualPrice
	FROM Menu.Item_Data D
	INNER JOIN Trans.Item_PO_Line L
	ON D.ItemCode = L.ItemCode
	WHERE L.POCode = @POCODE

END



GO
