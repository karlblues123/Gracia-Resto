USE [CGDB]
GO

/****** Object:  StoredProcedure [Menu].[GET_LIST_DISH]    Script Date: 2/3/2024 10:48:16 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Menu].[GET_LIST_DISH] 
	-- Add the parameters for the stored procedure here
	 
AS
BEGIN
	
	SELECT *
	FROM Menu.Dish_Hdr

END

GO

