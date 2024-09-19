USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spINSERT_DISH_LINE]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Menu.INSERT_DISH_LINE
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Menu].[spINSERT_DISH_LINE] 
	-- Add the parameters for the stored procedure here
	@DISHCODE nvarchar(15),
	@ITEMCODE nvarchar(20),
	@QUANTITY real,
	@ITEMPRICE decimal(18,2)

AS
BEGIN
	
	BEGIN TRY

	BEGIN TRANSACTION

	INSERT INTO [Menu].Dish_Line
	(DishCode,ItemCode,Quantity,Price)

	VALUES
	(@DISHCODE,@ITEMCODE,@QUANTITY,@ITEMPRICE)

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH

END



GO
