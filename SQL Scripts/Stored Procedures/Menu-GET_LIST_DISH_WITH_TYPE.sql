USE [CGDB]
GO

/****** Object:  StoredProcedure [Menu].[GET_LIST_DISH_WITH_TYPE]    Script Date: 2/3/2024 10:48:31 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the Dishes with the specified Type
-- =============================================
CREATE PROCEDURE [Menu].[GET_LIST_DISH_WITH_TYPE] 
	-- Add the parameters for the stored procedure here
	@DISHTYPE int

AS
BEGIN
	
	SELECT *
	FROM Menu.Dish_Hdr
	WHERE Menu.Dish_Hdr.DishType = @DISHTYPE

END

GO

