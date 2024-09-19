USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spUPDATE_SINGLE_PO_LINE]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Update a specified PO Line
-- =============================================
CREATE PROCEDURE [Trans].[spUPDATE_SINGLE_PO_LINE] 

	@POCODE nvarchar(15), 
	@ITEMCODE nvarchar(15),
	@ITEMQUANTITY real,
	@RECEIVEDQUANTITY real,
	@NOTES nvarchar(150),
	@USERNAME nvarchar(15)
AS
BEGIN
	
	BEGIN TRY

	BEGIN TRANSACTION

	UPDATE Trans.Item_PO_Line
	SET Quantity = @ITEMQUANTITY, ReceivedQuantity = @RECEIVEDQUANTITY
	WHERE POCode = @POCODE AND ItemCode = @ITEMCODE

	EXEC Trans.spINSERT_PO_LOG @POCODE,@NOTES,'UPDATE - LINE',@USERNAME

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH

END

GO
