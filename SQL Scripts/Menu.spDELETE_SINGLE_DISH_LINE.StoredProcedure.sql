USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spDELETE_SINGLE_DISH_LINE]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Delete a specified line in Dish_Line
-- =============================================
CREATE PROCEDURE [Menu].[spDELETE_SINGLE_DISH_LINE] 
	-- Add the parameters for the stored procedure here
	@ID int,
	@DISHCODE nvarchar(15),
	@ITEMCODE nvarchar(15),
	@NOTES nvarchar(150),
	@USERNAME nvarchar(15)
AS
BEGIN
	
	BEGIN TRY

	BEGIN TRANSACTION

	DELETE FROM Menu.Dish_Line
	WHERE DishCode = @DISHCODE AND ItemCode = @ITEMCODE AND ID = @ID

	EXEC Menu.spINSERT_DISH_LOG @DISHCODE,@NOTES,'DELETE',@USERNAME

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH

END

GO
