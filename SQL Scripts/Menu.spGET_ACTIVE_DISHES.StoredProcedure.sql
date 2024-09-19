USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spGET_ACTIVE_DISHES]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the list of active dishes
-- =============================================
CREATE PROCEDURE [Menu].[spGET_ACTIVE_DISHES] 
	
AS
BEGIN
	
	SELECT *
	FROM Menu.Dish_Hdr
	WHERE IsActive = 1

END

GO
