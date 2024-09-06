USE [CGDB]
GO

/****** Object:  StoredProcedure [Trans].[UPSERT_PO_LINE]    Script Date: 2/3/2024 10:53:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Update PO Line
-- =============================================
CREATE PROCEDURE [Trans].[UPSERT_PO_LINE] 
	-- Add the parameters for the stored procedure here
	@LINETABLE [Trans].PO_LINE READONLY
AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION

		UPDATE Trans.Item_PO_Line WITH (UPDLOCK, SERIALIZABLE)
		SET ItemQuantity = T.ItemQuantity, ReceivedQuantity = T.ReceivedQuantity
		FROM @LINETABLE AS T
		WHERE Trans.Item_PO_Line.ItemCode = T.ItemCode AND Trans.Item_PO_Line.POCode = T.POCode

		INSERT INTO [Trans].Item_PO_Line (POCode, ItemCode, ItemQuantity, ItemPrice, ReceivedQuantity)
		SELECT T.POCode, T.ItemCode, T.ItemQuantity, Menu.Item_Data.ItemPrice, T.ReceivedQuantity
		FROM @LINETABLE AS T
		INNER JOIN Menu.Item_Data ON T.ItemCode = Menu.Item_Data.ItemCode
		WHERE NOT EXISTS(SELECT 1 FROM [Trans].Item_PO_Line WHERE ItemCode = T.ItemCode AND POCode = T.POCode)

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH

END


GO

