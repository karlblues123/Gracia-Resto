USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spUPDATE_SINGLE_SALES_LINE]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Update a specified line in Sales_Line
-- =============================================
CREATE PROCEDURE [Trans].[spUPDATE_SINGLE_SALES_LINE]
	@ID int,
	@SALESCODE nvarchar(15),
	@DISHCODE nvarchar(15),
	@QUANTITY int,
	@DISCOUNT real,
	@NOTES nvarchar(150),
	@USERNAME nvarchar(15)

AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION

		DECLARE @DIFFERENCE real = @QUANTITY - (SELECT Quantity FROM Trans.Sales_Line WHERE SalesCode = @SALESCODE AND DishCode = @DISHCODE AND ID = @ID)

		UPDATE Trans.Sales_Line
		SET Quantity = @QUANTITY, Discount = @DISCOUNT
		WHERE SalesCode = @SALESCODE AND DishCode = @DISHCODE AND ID = @ID

		UPDATE Menu.Dish_Hdr
		SET Stock -= @DIFFERENCE
		WHERE DishCode = @DISHCODE

		EXEC Trans.spINSERT_SALES_LOG @SALESCODE,@NOTES,'UPDATE - LINE',@USERNAME

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH


END

GO
