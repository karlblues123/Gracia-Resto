USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spDELETE_SINGLE_PO_LINE]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Delete a specified PO Line
-- =============================================
CREATE PROCEDURE [Trans].[spDELETE_SINGLE_PO_LINE] 
	-- Add the parameters for the stored procedure here
	@POCODE nvarchar(15), 
	@ITEMCODE nvarchar(15),
	@NOTES nvarchar(150),
	@USERNAME nvarchar(15)

AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION

			DELETE FROM Trans.Item_PO_Line
			WHERE POCode = @POCODE AND ItemCode = @ITEMCODE

			EXEC Trans.spINSERT_PO_LOG @POCODE,@NOTES,'DELETE - LINE',@USERNAME

		COMMIT TRANSACTION

	END TRY
	
	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH

END

GO
