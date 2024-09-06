USE [CGDB]
GO

/****** Object:  StoredProcedure [Menu].[UPSERT_DELETE_DISH_LINE]    Script Date: 2/3/2024 10:51:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Karl Unabia>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Menu].[UPSERT_DELETE_DISH_LINE] 
	
	@LINETABLE [Menu].DISH_LINE READONLY
AS
BEGIN

	BEGIN TRY

	BEGIN TRANSACTION

	UPDATE Menu.Dish_Line WITH (UPDLOCK, SERIALIZABLE)
	SET ItemQuantity = T.ItemQuantity
	FROM @LINETABLE AS T
	WHERE Menu.Dish_Line.ItemCode = T.ItemCode AND Menu.Dish_Line.DishCode = T.DishCode

	INSERT INTO [Menu].Dish_Line (DishCode,ItemCode,ItemQuantity,ItemPrice)
	SELECT Menu.Dish_Hdr.DishCode, T.ItemCode, T.ItemQuantity, Menu.Item_Data.ItemPrice
	FROM @LINETABLE AS T
	INNER JOIN Menu.Item_Data ON T.ItemCode = Menu.Item_Data.ItemCode
	INNER JOIN Menu.Dish_Hdr ON T.DishCode = Menu.Dish_Hdr.DishCode
	WHERE NOT EXISTS(SELECT 1 FROM [Menu].Dish_Line WHERE DishCode = T.DishCode AND ItemCode = T.ItemCode)

	DELETE FROM [Menu].Dish_Line
	WHERE ItemCode NOT IN (SELECT ItemCode FROM @LINETABLE)
	AND DishCode IN (SELECT DishCode FROM @LINETABLE)

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH

END


GO

