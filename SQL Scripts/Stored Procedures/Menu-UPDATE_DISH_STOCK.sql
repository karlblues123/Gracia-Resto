USE [CGDB]
GO

/****** Object:  StoredProcedure [Menu].[UPDATE_DISH_STOCK]    Script Date: 2/3/2024 10:50:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Update the Stock of the selected Dish
-- =============================================
CREATE PROCEDURE [Menu].[UPDATE_DISH_STOCK] 
	@DISHCODE  nvarchar(15), 
	@DISHSTOCK int
AS
BEGIN
	BEGIN TRY

	BEGIN TRANSACTION

	UPDATE Menu.Dish_Hdr
	SET DishStock = @DISHSTOCK
	WHERE DishCode = @DISHCODE

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH
END

GO

