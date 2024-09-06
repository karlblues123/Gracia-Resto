USE [CGDB]
GO

/****** Object:  StoredProcedure [Menu].[UPDATE_DISH_HDR]    Script Date: 2/3/2024 10:50:34 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Menu].[UPDATE_DISH_HDR] 
	-- Add the parameters for the stored procedure here
	@DISHCODE nvarchar(15),
	@DISHNAME nvarchar(50),
	@DISHPRICE decimal(18,2) 

AS
BEGIN
	
	BEGIN TRY

	BEGIN TRANSACTION

	UPDATE [Menu].Dish_Hdr
	SET DishName = @DISHNAME, DishPrice = @DISHPRICE
	WHERE DishCode = @DISHCODE

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH

END

GO

