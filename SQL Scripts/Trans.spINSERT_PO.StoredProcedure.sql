USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spINSERT_PO]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Insert a New Purchase Order
-- =============================================
CREATE PROCEDURE [Trans].[spINSERT_PO] 
	@POCODE nvarchar(15), 
	@PODATE date,
	@POINCHARGE nvarchar(50),
	@REMARKS nvarchar(150),
	@LINETABLE [Trans].PO_LINE READONLY,
	@USERNAME nvarchar(15)

AS
BEGIN
	BEGIN TRY

	BEGIN TRANSACTION

	DECLARE @USERID int = (SELECT ID FROM xSystem.User_Data WHERE Username = @USERNAME)

	INSERT INTO [Trans].Item_PO_Hdr
	(POCode,Date,InCharge,Remarks,UserID)
	VALUES
	(@POCODE,@PODATE,@POINCHARGE,@REMARKS,@USERID)

	INSERT INTO [Trans].Item_PO_Line (POCode, ItemCode, Quantity, Price, ReceivedQuantity)
	SELECT T.POCode, T.ItemCode, T.ItemQuantity, T.Price, T.ReceivedQuantity
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
