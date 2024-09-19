USE [GRDB]
GO

/****** Object:  StoredProcedure [Menu].[spGET_DISH_TYPES]    Script Date: 8/29/2024 4:04:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the Dish Types
-- =============================================
CREATE PROCEDURE [Menu].[spGET_DISH_TYPES] 
	
AS
BEGIN
	
	SELECT *
	FROM Menu.Dish_Type_RF

END




GO

