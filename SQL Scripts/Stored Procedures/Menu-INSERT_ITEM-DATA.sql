USE [CGDB]
GO

/****** Object:  StoredProcedure [Menu].[INSERT_ITEM_DATA]    Script Date: 2/3/2024 10:49:45 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	INSERT new item to Item_Data table
-- =============================================
CREATE PROCEDURE [Menu].[INSERT_ITEM_DATA] 
	-- Add the parameters for the stored procedure here
	@ITEMCODE nvarchar(20), 
	@ITEMNAME nvarchar(50),
	@ITEMPRICE decimal(18,2),
	@ITEMUM nvarchar(10)
AS
BEGIN
	BEGIN TRY

		BEGIN TRANSACTION

		INSERT INTO [Menu].Item_Data
		(ItemCode,ItemName,ItemPrice,ItemUM)

		VALUES
		(@ITEMCODE,@ITEMNAME,@ITEMPRICE,@ITEMUM)

		EXEC xSystem.UPDATE_SERIES_NUMBER 'ING'

		COMMIT TRANSACTION

	END TRY
	
	BEGIN CATCH
	
		ROLLBACK TRANSACTION

	END CATCH 
END

GO

