USE [CGDB]
GO

/****** Object:  StoredProcedure [Trans].[INSERT_PO]    Script Date: 2/3/2024 10:52:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Insert a New Purchase Order
-- =============================================
CREATE PROCEDURE [Trans].[INSERT_PO] 
	@POCODE nvarchar(15), 
	@PODATE date,
	@POINCHARGE nvarchar(50),
	@LINETABLE [Trans].PO_LINE READONLY

AS
BEGIN
	BEGIN TRY

	BEGIN TRANSACTION

	INSERT INTO [Trans].Item_PO_Hdr
	(POCode,PODate,POInCharge)

	VALUES
	(@POCODE,@PODATE,@POINCHARGE)

	INSERT INTO [Trans].Item_PO_Line (POCode, ItemCode, ItemQuantity, ItemPrice, ReceivedQuantity)
	SELECT T.POCode, T.ItemCode, T.ItemQuantity, Menu.Item_Data.ItemPrice, T.ReceivedQuantity
	FROM @LINETABLE AS T
	INNER JOIN Menu.Item_Data ON T.ItemCode = Menu.Item_Data.ItemCode
	WHERE NOT EXISTS(SELECT 1 FROM [Trans].Item_PO_Line WHERE ItemCode = T.ItemCode AND POCode = T.POCode)

	EXEC xSystem.UPDATE_SERIES_NUMBER 'PO'

	COMMIT TRANSACTION

	END TRY
	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH

END

GO

