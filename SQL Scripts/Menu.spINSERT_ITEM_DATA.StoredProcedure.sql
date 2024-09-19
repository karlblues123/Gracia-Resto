USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spINSERT_ITEM_DATA]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	INSERT new item to Item_Data table
-- =============================================
CREATE PROCEDURE [Menu].[spINSERT_ITEM_DATA] 
	-- Add the parameters for the stored procedure here
	@ITEMCODE nvarchar(20), 
	@ITEMNAME nvarchar(50),
	@ITEMPRICE decimal(18,2),
	@ITEMUM nvarchar(10),
	@NOTES nvarchar(150),
	@USERNAME nvarchar(15)
AS
BEGIN
	BEGIN TRY

		BEGIN TRANSACTION

		INSERT INTO [Menu].Item_Data
		(ItemCode,Name,Price,UM)

		VALUES
		(@ITEMCODE,@ITEMNAME,@ITEMPRICE,@ITEMUM)

		EXEC xSystem.UPDATE_SERIES_NUMBER 'ING'

		EXEC Menu.spINSERT_ITEM_LOG @ITEMCODE,@NOTES,'INSERT',@USERNAME

		COMMIT TRANSACTION

	END TRY
	
	BEGIN CATCH
	
		ROLLBACK TRANSACTION

	END CATCH 
END



GO
