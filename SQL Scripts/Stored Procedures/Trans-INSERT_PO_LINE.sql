USE [CGDB]
GO

/****** Object:  StoredProcedure [Trans].[INSERT_PO_LINE]    Script Date: 2/3/2024 10:53:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Create a Purchase Order Line
-- =============================================
CREATE PROCEDURE [Trans].[INSERT_PO_LINE] 
	-- Add the parameters for the stored procedure here
	@POCODE nvarchar(15),
	@ITEMCODE nvarchar(20),
	@QUANTITY real,
	@ITEMPRICE decimal(18,2)

AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION
			INSERT INTO [Trans].Item_PO_Line
			(POCode,ItemCode,ItemQuantity,ItemPrice)

			VALUES
			(@POCODE,@ITEMCODE,@QUANTITY,@ITEMPRICE)

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH

			

		
END

GO

