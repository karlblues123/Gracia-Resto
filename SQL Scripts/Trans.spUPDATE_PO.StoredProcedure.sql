USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spUPDATE_PO]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Update PO
-- =============================================
CREATE PROCEDURE [Trans].[spUPDATE_PO] 
	@POCODE nvarchar(15),
	@PODATE date, 
	@POINCHARGE nvarchar(5),
	@POCASHGIVEN real,
	@LINETABLE [Trans].PO_LINE READONLY,
	@NOTES nvarchar(150),
	@USERNAME nvarchar(15)
AS
BEGIN
	BEGIN TRY

	BEGIN TRANSACTION

		UPDATE [Trans].Item_PO_Hdr WITH (UPDLOCK, SERIALIZABLE)
		SET Date =  @PODATE, InCharge = @POINCHARGE, CashGiven = @POCASHGIVEN
		WHERE POCode = @POCODE
		
		UPDATE Trans.Item_PO_Line WITH (UPDLOCK, SERIALIZABLE)
		SET Quantity = T.ItemQuantity, ActualPrice = T.ActualPrice, ReceivedQuantity = T.ReceivedQuantity
		FROM @LINETABLE AS T
		WHERE Trans.Item_PO_Line.ItemCode = T.ItemCode AND Trans.Item_PO_Line.POCode = T.POCode

		INSERT INTO [Trans].Item_PO_Line (POCode, ItemCode, Quantity, Price, ReceivedQuantity, ActualPrice)
		SELECT T.POCode, T.ItemCode, T.ItemQuantity, T.Price, T.ReceivedQuantity, T.ActualPrice
		FROM @LINETABLE AS T
		INNER JOIN Menu.Item_Data ON T.ItemCode = Menu.Item_Data.ItemCode
		WHERE NOT EXISTS(SELECT 1 FROM [Trans].Item_PO_Line WHERE ItemCode = T.ItemCode AND POCode = T.POCode)

		DELETE FROM [Trans].Item_PO_Line
		WHERE ItemCode NOT IN(SELECT T.ItemCode FROM @LINETABLE T)

		EXEC Trans.spINSERT_PO_LOG @POCODE,@NOTES,'UPDATE',@USERNAME

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH
END


GO
