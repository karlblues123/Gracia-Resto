USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spINSERT_SINGLE_SALES_LINE]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Insert a new single entry in Sales_Line
-- =============================================
CREATE PROCEDURE [Trans].[spINSERT_SINGLE_SALES_LINE] 
	-- Add the parameters for the stored procedure here
	@SALESCODE nvarchar(15),
	@DISHCODE nvarchar(15),
	@PRICE decimal (18,2),
	@QUANTITY int,
	@DISCOUNT real,
	@NOTES nvarchar(150),
	@USERNAME nvarchar(150)

AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION

		INSERT INTO Trans.Sales_Line
		(SalesCode,DishCode,Price,Quantity,Discount)

		VALUES
		(@SALESCODE,@DISHCODE,@PRICE,@QUANTITY,@DISCOUNT)

		UPDATE Menu.Dish_Hdr
		SET Stock = Stock - @QUANTITY
		WHERE DishCode = @DISHCODE

		EXEC Trans.spINSERT_SALES_LOG @SALESCODE,@NOTES,'INSERT',@USERNAME

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH

END

GO
