USE [GRDB]
GO
/****** Object:  StoredProcedure [Kitchen].[spGET_ORDER_COMPLETED_TODAY]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Russel Vasquez
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Kitchen].[spGET_ORDER_COMPLETED_TODAY] 
AS
BEGIN
	
	SELECT C.Name,B.Quantity, SUM(B.Quantity) as TotalOrdersQty
	FROM [Kitchen].Kitchen_Orders_TF A
	INNER JOIN  Trans.Sales_Line B
	ON A.SalesCode = B.SalesCode
	INNER JOIN Menu.Dish_Hdr C
	ON B.DishCode = C.DishCode
	WHERE A.KitchenStatusID = 3
	AND Convert(date,A.LastUpdate,101) = Convert(date,GETDATE(),101)
	GROUP BY C.Name,B.Quantity
END



GO
