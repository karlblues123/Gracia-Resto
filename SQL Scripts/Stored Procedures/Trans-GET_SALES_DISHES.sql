USE [CGDB]
GO

/****** Object:  StoredProcedure [Trans].[GET_SALES_DISHES]    Script Date: 2/8/2024 4:44:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the dish data of the selected Sales Transaction
-- =============================================
CREATE PROCEDURE [Trans].[GET_SALES_DISHES] 
	-- Add the parameters for the stored procedure here
	@SALESCODE nvarchar(15)
AS
BEGIN
	
	SELECT Trans.Sales_Line.DishCode, Menu.Dish_Hdr.DishName, Trans.Sales_Line.Quantity, Trans.Sales_Line.Price, Trans.Sales_Line.Discount
	FROM Trans.Sales_Line
	INNER JOIN Menu.Dish_Hdr
	ON Trans.Sales_Line.DishCode = Menu.Dish_Hdr.DishCode
	WHERE SalesCode = @SALESCODE

END

GO


