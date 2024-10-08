USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spGET_LIST_DISH_WITH_TYPE]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the Dishes with the specified Type
-- =============================================
CREATE PROCEDURE [Menu].[spGET_LIST_DISH_WITH_TYPE] 
	-- Add the parameters for the stored procedure here
	@DISHTYPE int

AS
BEGIN
	
	SELECT *
	FROM Menu.Dish_Hdr
	WHERE Menu.Dish_Hdr.Type = @DISHTYPE
	AND IsActive = 1

END



GO
