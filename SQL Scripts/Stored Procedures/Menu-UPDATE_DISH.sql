USE [CGDB]
GO

/****** Object:  StoredProcedure [Menu].[UPDATE_DISH]    Script Date: 2/3/2024 10:50:16 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Update a Dish
-- =============================================
CREATE PROCEDURE [Menu].[UPDATE_DISH] 
	-- Add the parameters for the stored procedure here
	@DISHCODE nvarchar(15),
	@DISHNAME nvarchar(50),
	@DISHPRICE decimal(18,2),
	@DISHSTOCK int,
	@DISHSERVING int,
	@DISHIMAGE varbinary(max),
	@DISHTYPE int,
	@DISHDESC nvarchar(250),
	@LINETABLE [Menu].DISH_LINE READONLY

AS
BEGIN
	BEGIN TRY

	BEGIN TRANSACTION

	UPDATE [Menu].Dish_Hdr
	SET DishName = @DISHNAME, DishPrice = @DISHPRICE, DishStock = @DISHSTOCK, DishServing = @DISHSERVING, DishPhoto = @DISHIMAGE, DishType = @DISHTYPE,
	DishDescription = @DISHDESC
	WHERE DishCode = @DISHCODE

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

