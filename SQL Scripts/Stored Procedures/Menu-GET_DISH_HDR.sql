USE [CGDB]
GO

/****** Object:  StoredProcedure [Menu].[GET_DISH_HDR]    Script Date: 2/3/2024 10:46:47 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Menu].[GET_DISH_HDR] 
	-- Add the parameters for the stored procedure here
	@DISHCODE nvarchar(15)

AS
BEGIN
	
	SELECT *
	FROM [Menu].Dish_Hdr
	WHERE [Menu].Dish_Hdr.DishCode = @DISHCODE

END

GO

