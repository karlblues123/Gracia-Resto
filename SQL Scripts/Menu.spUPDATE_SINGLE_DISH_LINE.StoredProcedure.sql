USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spUPDATE_SINGLE_DISH_LINE]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Update the specified line in Dish_Line
-- =============================================
CREATE PROCEDURE [Menu].[spUPDATE_SINGLE_DISH_LINE] 
	@DISHCODE nvarchar(15),
	@ITEMCODE nvarchar(15),
	@ITEMQUANTITY real,
	@NOTES nvarchar(150),
	@USERNAME nvarchar(15)

AS
BEGIN
	
	BEGIN TRY

	BEGIN TRANSACTION

	UPDATE Menu.Dish_Line
	SET Quantity = @ITEMQUANTITY
	WHERE DishCode = @DISHCODE AND ItemCode = @ITEMCODE

	EXEC Menu.spINSERT_DISH_LOG @DISHCODE,@NOTES,'UPDATE - LINE',@USERNAME

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH

END

GO
