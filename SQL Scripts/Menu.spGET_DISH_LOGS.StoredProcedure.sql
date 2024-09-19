USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spGET_DISH_LOGS]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the Dish Logs
-- =============================================
CREATE PROCEDURE [Menu].[spGET_DISH_LOGS] 
	
AS
BEGIN
	
	SELECT L.*, H.Name, U.Username
	FROM Menu.Dish_Trail L
	INNER JOIN Menu.Dish_Hdr H
	ON L.DishCode = H.DishCode
	INNER JOIN xSystem.User_Data U
	ON L.UserID = U.ID
	ORDER BY DI

END

GO
