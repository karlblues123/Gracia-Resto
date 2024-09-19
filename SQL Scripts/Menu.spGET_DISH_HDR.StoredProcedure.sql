USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spGET_DISH_HDR]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Menu].[spGET_DISH_HDR] 
	-- Add the parameters for the stored procedure here
	@DISHCODE nvarchar(15)

AS
BEGIN
	
	SELECT *
	FROM [Menu].Dish_Hdr
	WHERE [Menu].Dish_Hdr.DishCode = @DISHCODE

END



GO
