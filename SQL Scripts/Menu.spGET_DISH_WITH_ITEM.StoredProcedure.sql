USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spGET_DISH_WITH_ITEM]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get Dishes with specified Item
-- =============================================
CREATE PROCEDURE [Menu].[spGET_DISH_WITH_ITEM] 
	-- Add the parameters for the stored procedure here
	@ITEMCODE nvarchar(15) 

AS
BEGIN
	
	SELECT H.*
	FROM Menu.Dish_Line L
	INNER JOIN Menu.Dish_Hdr H
	ON L.DishCode = H.DishCode
	WHERE L.ItemCode = @ITEMCODE

END

GO
