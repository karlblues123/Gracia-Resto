USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spINSERT_DISH_HDR]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Menu].[spINSERT_DISH_HDR] 
	-- Add the parameters for the stored procedure here
	@DISHCODE nvarchar(15), 
	@DISHPRICE decimal(18,2),
	@DISHNAME nvarchar(50),
	@DISHSERVING int,
	@DISHTYPE int,
	@DISHDESCRIPTION nvarchar(250)

AS
BEGIN
	BEGIN TRY

	BEGIN TRANSACTION

		INSERT INTO [Menu].Dish_Hdr
		(DishCode,Name,Price,Serving,Type,Description)

		VALUES
		(@DISHCODE,@DISHNAME,@DISHPRICE,@DISHSERVING,@DISHTYPE,@DISHDESCRIPTION)

		EXEC xSystem.UPDATE_SERIES_NUMBER 'DISH'

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH
END



GO
