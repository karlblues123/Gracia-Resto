USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spUPSERT_DELETE_DISH_LINE]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Karl Unabia>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Menu].[spUPSERT_DELETE_DISH_LINE] 
	
	@LINETABLE [Menu].DISH_LINE READONLY,
	@NOTES nvarchar(150),
	@USERNAME nvarchar(15)
AS
BEGIN

	BEGIN TRY

	BEGIN TRANSACTION

	UPDATE Menu.Dish_Line WITH (UPDLOCK, SERIALIZABLE)
	SET Quantity = T.ItemQuantity
	FROM @LINETABLE AS T
	WHERE Menu.Dish_Line.ItemCode = T.ItemCode AND Menu.Dish_Line.DishCode = T.DishCode

	INSERT INTO [Menu].Dish_Line (DishCode,ItemCode,Quantity,Price)
	SELECT Menu.Dish_Hdr.DishCode, T.ItemCode, T.ItemQuantity, Menu.Item_Data.Price
	FROM @LINETABLE AS T
	INNER JOIN Menu.Item_Data ON T.ItemCode = Menu.Item_Data.ItemCode
	INNER JOIN Menu.Dish_Hdr ON T.DishCode = Menu.Dish_Hdr.DishCode
	WHERE NOT EXISTS(SELECT 1 FROM [Menu].Dish_Line WHERE DishCode = T.DishCode AND ItemCode = T.ItemCode)

	DELETE FROM [Menu].Dish_Line
	WHERE ItemCode NOT IN (SELECT ItemCode FROM @LINETABLE)
	AND DishCode IN (SELECT DishCode FROM @LINETABLE)

	DECLARE @DISHCODE nvarchar(15) = (SELECT TOP 1 DishCode FROM @LINETABLE)

	EXEC Menu.spINSERT_DISH_LOG @DISHCODE,@NOTES,'UPDATE',@USERNAME

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH

END




GO
