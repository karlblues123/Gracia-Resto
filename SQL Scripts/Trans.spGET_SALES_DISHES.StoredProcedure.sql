USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spGET_SALES_DISHES]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the dish data of the selected Sales Transaction
-- =============================================
CREATE PROCEDURE [Trans].[spGET_SALES_DISHES] 
	-- Add the parameters for the stored procedure here
	@SALESCODE nvarchar(15)
AS
BEGIN
	
	SELECT L.ID ,L.DishCode, H.Name, L.Quantity, L.Price, L.Discount
	FROM Trans.Sales_Line L
	INNER JOIN Menu.Dish_Hdr H
	ON L.DishCode = H.DishCode
	WHERE SalesCode = @SALESCODE

END



GO
