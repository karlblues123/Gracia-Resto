USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spINSERT_PO_LINE]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Create a Purchase Order Line
-- =============================================
CREATE PROCEDURE [Trans].[spINSERT_PO_LINE] 
	@POCODE nvarchar(15),
	@ITEMCODE nvarchar(20),
	@QUANTITY real,
	@ITEMPRICE decimal(18,2)

AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION
			INSERT INTO [Trans].Item_PO_Line
			(POCode,ItemCode,Quantity,Price)

			VALUES
			(@POCODE,@ITEMCODE,@QUANTITY,@ITEMPRICE)

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH

			

		
END



GO
