USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spGET_LIST_DISH]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Menu].[spGET_LIST_DISH] 
	-- Add the parameters for the stored procedure here
	 
AS
BEGIN
	
	SELECT H.DishCode, H.Name, H.Price, H.Stock, H.IsActive, SUM( L.Price * L.Quantity ) AS ActualPrice
	FROM Menu.Dish_Hdr H
	LEFT JOIN Menu.Dish_Line L
	ON H.DishCode = L.DishCode
	GROUP BY H.DishCode, H.Name, H.Price, H.Stock, H.IsActive

END



GO
