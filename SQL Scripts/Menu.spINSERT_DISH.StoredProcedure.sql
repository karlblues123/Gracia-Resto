USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spINSERT_DISH]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Insert a new Dish
-- =============================================
CREATE PROCEDURE [Menu].[spINSERT_DISH] 
	@DISHCODE nvarchar(15), 
	@DISHPRICE decimal(18,2),
	@DISHNAME nvarchar(50),
	@DISHSERVING int,
	@DISHTYPE int,
	@DISHDESC nvarchar(250),
	@LINETABLE [Menu].DISH_LINE READONLY
AS
BEGIN
	BEGIN TRY

	BEGIN TRANSACTION

		INSERT INTO [Menu].Dish_Hdr
		(DishCode,Name,Price,Stock,Serving,Type,Description)

		VALUES
		(@DISHCODE,@DISHNAME,@DISHPRICE,0,@DISHSERVING,@DISHTYPE,@DISHDESC)

		INSERT INTO [Menu].Dish_Line (DishCode,ItemCode,Quantity,Price)
		SELECT @DISHCODE, T.ItemCode, T.ItemQuantity, Menu.Item_Data.Price
		FROM @LINETABLE AS T
		INNER JOIN Menu.Item_Data ON T.ItemCode = Menu.Item_Data.ItemCode
		INNER JOIN Menu.Dish_Hdr ON T.DishCode = Menu.Dish_Hdr.DishCode

		EXEC xSystem.UPDATE_SERIES_NUMBER 'DISH'

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH
	

END




GO
