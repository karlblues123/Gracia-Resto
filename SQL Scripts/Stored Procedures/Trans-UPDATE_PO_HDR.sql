USE [CGDB]
GO

/****** Object:  StoredProcedure [Trans].[UPDATE_PO_HDR]    Script Date: 2/3/2024 10:53:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Trans].[UPDATE_PO_HDR] 
	-- Add the parameters for the stored procedure here
	@POCODE nvarchar(15),
	@PODATE date, 
	@POINCHARGE nvarchar(5)
AS
BEGIN
	
	BEGIN TRY

	BEGIN TRANSACTION

		UPDATE [Trans].Item_PO_Hdr WITH (UPDLOCK, SERIALIZABLE)
		SET PODate =  @PODATE, POInCharge = @POINCHARGE
		WHERE POCode = @POCODE

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH

END

GO

