USE [GRDB]
GO
/****** Object:  StoredProcedure [Kitchen].[spGET_ORDER_STATUS]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the status of the specified Order
-- =============================================
CREATE PROCEDURE [Kitchen].[spGET_ORDER_STATUS] 
	-- Add the parameters for the stored procedure here
	@SALESCODE nvarchar(15)
	
AS
BEGIN
	
	SELECT A.KitchenStatusID, B.Description
	FROM Kitchen.Kitchen_Orders_TF A
	INNER JOIN Kitchen.Order_Status_RF B
	ON A.KitchenStatusID = B.KitchenStatusID
	WHERE A.SalesCode = @SALESCODE

END

GO
