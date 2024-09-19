USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spUPSERT_DISH_STOCK_ADJUSTMENT]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Insert a dish Stock Adjustment
-- =============================================
CREATE PROCEDURE [Menu].[spUPSERT_DISH_STOCK_ADJUSTMENT] 
	-- Add the parameters for the stored procedure here
	@DISHCODE nvarchar(15),
	@DISHSTOCK int,
	@REASON nvarchar(250),
	@USERNAME nvarchar(15)
AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION

			DECLARE @USERID AS INT 
			SET @USERID = (SELECT ID FROM xSystem.User_Data WHERE Username = @USERNAME)
			
			UPDATE Dish_Hdr
			SET Stock = @DISHSTOCK
			WHERE DishCode = @DISHCODE

			INSERT Stock_Adjustment
			(DishCode,AdjustedStock,Reason,DI,UserID)

			VALUES
			(@DISHCODE,@DISHSTOCK,@REASON,GETDATE(),@USERID)

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH

END


GO
