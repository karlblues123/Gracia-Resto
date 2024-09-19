USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spGET_STOCK_ADJUSTMENT_LOGS]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the Stock Adjustment logs
-- =============================================
CREATE PROCEDURE [Menu].[spGET_STOCK_ADJUSTMENT_LOGS] 

AS
BEGIN
	
	SELECT A.*, B.Name, C.Username
	FROM Menu.Stock_Adjustment A
	INNER JOIN Menu.Dish_Hdr B
	ON A.DishCode = B.DishCode
	INNER JOIN xSystem.User_Data C
	ON A.UserID = C.ID

END

GO
