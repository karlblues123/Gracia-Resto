USE [CGDB]
GO

/****** Object:  StoredProcedure [Menu].[GET_DISH_TYPES]    Script Date: 2/3/2024 10:47:45 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the Dish Types
-- =============================================
CREATE PROCEDURE [Menu].[GET_DISH_TYPES] 
	
AS
BEGIN
	
	SELECT TypeID, DishType
	FROM Menu.Dish_Type_RF

END

GO

