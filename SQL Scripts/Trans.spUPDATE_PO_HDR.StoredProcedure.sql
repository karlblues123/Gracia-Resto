USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spUPDATE_PO_HDR]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Trans].[spUPDATE_PO_HDR] 
	-- Add the parameters for the stored procedure here
	@POCODE nvarchar(15),
	@PODATE date, 
	@POINCHARGE nvarchar(50),
	@PORECEIVER nvarchar(20),
	@POCASHGIVEN real,
	@NOTES nvarchar(150),
	@USERNAME nvarchar(15)
AS
BEGIN
	
	BEGIN TRY

	BEGIN TRANSACTION

		UPDATE [Trans].Item_PO_Hdr WITH (UPDLOCK, SERIALIZABLE)
		SET Date =  @PODATE, InCharge = @POINCHARGE, Receiver = @PORECEIVER, CashGiven = @POCASHGIVEN, Remarks = @NOTES
		WHERE POCode = @POCODE

		EXEC Trans.spINSERT_PO_LOG @POCODE,@NOTES,'UPDATE - HDR',@USERNAME

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH

END



GO
