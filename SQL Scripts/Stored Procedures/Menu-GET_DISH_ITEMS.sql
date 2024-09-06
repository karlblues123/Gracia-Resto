USE [CGDB]
GO

/****** Object:  StoredProcedure [Menu].[GET_DISH_ITEMS]    Script Date: 2/3/2024 10:47:05 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Menu].[GET_DISH_ITEMS] 
	-- Add the parameters for the stored procedure here
	@DISHCODE nvarchar(15)
AS
BEGIN
	
	SELECT Menu.Item_Data.ItemCode, Menu.Item_Data.ItemName, Menu.Item_Data.ItemUM, Menu.Item_Data.ItemPrice, Menu.Dish_Line.ItemQuantity
	FROM Menu.Item_Data
	INNER JOIN Menu.Dish_Line ON Menu.Dish_Line.ItemCode = Menu.Item_Data.ItemCode
	WHERE
	Menu.Dish_Line.DishCode = @DISHCODE
END

GO

