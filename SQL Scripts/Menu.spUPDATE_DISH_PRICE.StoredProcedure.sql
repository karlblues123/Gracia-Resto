USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spUPDATE_DISH_PRICE]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Update the price of the selected Dish_Hdr
-- =============================================
CREATE PROCEDURE [Menu].[spUPDATE_DISH_PRICE] 
	-- Add the parameters for the stored procedure here
	@DISHCODE nvarchar(15),
	@DISHPRICE decimal(18,2),
	@NOTES nvarchar(150),
	@USERNAME nvarchar(15)
AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION

		UPDATE Menu.Dish_Hdr WITH (UPDLOCK,SERIALIZABLE)
		SET Price = @DISHPRICE
		WHERE DishCode = @DISHCODE

		EXEC Menu.spINSERT_DISH_LOG @DISHCODE,@NOTES,'UPDATE - PRICE',@USERNAME

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH

END

GO
