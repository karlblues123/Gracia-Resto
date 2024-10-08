USE [GRDB]
GO
/****** Object:  StoredProcedure [Kitchen].[spGET_ORDER_REQUESTING]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Russel Vasquez
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Kitchen].[spGET_ORDER_REQUESTING]
@SALESCODE nvarchar(10)
AS
BEGIN
	
	SELECT *
	FROM [Kitchen].Kitchen_Orders_TF A
	INNER JOIN  Trans.Sales_Line B
	ON A.SalesCode = B.SalesCode
	INNER JOIN Menu.Dish_Hdr C
	ON B.DishCode = C.DishCode
	WHERE A.KitchenStatusID = 1 AND A.SalesCode = @SALESCODE

END



GO
