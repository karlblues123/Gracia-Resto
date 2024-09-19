USE [CGDB]
GO
/****** Object:  StoredProcedure [Trans].[INSERT_PO_HDR]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Create a new Purchase Order Header
-- =============================================
CREATE PROCEDURE [Trans].[INSERT_PO_HDR] 
	-- Add the parameters for the stored procedure here
	@POCODE nvarchar(15), 
	@PODATE date,
	@POINCHARGE nvarchar(50) 
AS
BEGIN
	
	BEGIN TRY

	BEGIN TRANSACTION

	INSERT INTO [Trans].Item_PO_Hdr
	(POCode,Date,InCharge)

	VALUES
	(@POCODE,@PODATE,@POINCHARGE)

	EXEC xSystem.UPDATE_SERIES_NUMBER 'PO'

	COMMIT TRANSACTION

	END TRY
	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH

END


GO
