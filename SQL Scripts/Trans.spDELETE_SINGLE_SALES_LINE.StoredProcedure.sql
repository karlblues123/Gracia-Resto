USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spDELETE_SINGLE_SALES_LINE]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Delete a specified line in Sales_Line
-- =============================================
CREATE PROCEDURE [Trans].[spDELETE_SINGLE_SALES_LINE]
	@ID int,
	@SALESCODE nvarchar(15),
	@DISHCODE nvarchar(15),
	@NOTES nvarchar(15),
	@USERNAME nvarchar(15)

AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION

		DECLARE @QUANTITY INT
		SET @QUANTITY = (SELECT Quantity FROM Trans.Sales_Line WHERE SalesCode = @SALESCODE AND DishCode = @DISHCODE AND ID = @ID);

		UPDATE Menu.Dish_Hdr
		SET Stock = Stock + @QUANTITY
		WHERE DishCode = @DISHCODE

		DELETE FROM Trans.Sales_Line
		WHERE SalesCode = @SALESCODE AND DishCode = @DISHCODE AND ID = @ID

		EXEC Trans.spINSERT_SALES_LOG @SALESCODE,@NOTES,'DELETE - LINE',@USERNAME

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH

END


GO
