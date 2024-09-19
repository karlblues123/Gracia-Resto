USE [CGDB]
GO
/****** Object:  StoredProcedure [Menu].[UPDATE_ITEM_DATA]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Bulk Update Menu.Item_Data table
-- =============================================
CREATE PROCEDURE [Menu].[UPDATE_ITEM_DATA] 
	
	@ITEMDATA [Menu].ITEM_DATA Readonly
AS
BEGIN
	
	BEGIN TRY

	BEGIN TRANSACTION

	UPDATE Menu.Item_Data WITH (UPDLOCK, SERIALIZABLE)
	SET Menu.Item_Data.Name = T.ItemName, Menu.Item_Data.Price = T.ItemPrice, 
	Menu.Item_Data.UM = T.ItemUM
	FROM @ITEMDATA AS T
	WHERE Menu.Item_Data.ItemCode = T.ItemCode

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH

END




GO
