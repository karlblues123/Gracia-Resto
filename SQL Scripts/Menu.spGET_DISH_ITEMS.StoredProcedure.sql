USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spGET_DISH_ITEMS]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Menu].[spGET_DISH_ITEMS] 
	-- Add the parameters for the stored procedure here
	@DISHCODE nvarchar(15)
AS
BEGIN
	
	SELECT L.DishCode, D.ItemCode, D.Name, D.UM, D.Price, L.Quantity
	FROM Menu.Item_Data D
	INNER JOIN Menu.Dish_Line L
	ON D.ItemCode = L.ItemCode
	WHERE
	L.DishCode = @DISHCODE
END



GO
