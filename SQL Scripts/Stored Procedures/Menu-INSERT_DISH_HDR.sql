USE [CGDB]
GO

/****** Object:  StoredProcedure [Menu].[INSERT_DISH_HDR]    Script Date: 2/3/2024 10:49:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Menu].[INSERT_DISH_HDR] 
	-- Add the parameters for the stored procedure here
	@DISHCODE nvarchar(15), 
	@DISHPRICE decimal(18,2),
	@DISHNAME nvarchar(50)
AS
BEGIN
	BEGIN TRY

	BEGIN TRANSACTION

		INSERT INTO [Menu].Dish_Hdr
		(DishCode,DishName,DishPrice)

		VALUES
		(@DISHCODE,@DISHNAME,@DISHPRICE)

		EXEC xSystem.UPDATE_SERIES_NUMBER 'DISH'

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH
END

GO

