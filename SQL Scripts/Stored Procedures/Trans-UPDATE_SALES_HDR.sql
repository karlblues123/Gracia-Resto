USE [CGDB]
GO

/****** Object:  StoredProcedure [Trans].[UPDATE_SALES_HDR]    Script Date: 2/13/2024 11:28:20 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Update Sales Hdr
-- =============================================
CREATE PROCEDURE [Trans].[UPDATE_SALES_HDR] 
	-- Add the parameters for the stored procedure here
	@SALESCODE nvarchar(15),
	@AMOUNTTENDERED decimal(18,2),
	@WAITERNAME nvarchar(20),
	@ROOM nvarchar(20),
	@TIPAMOUNT decimal(12,2),
	@RECEIVERNAME nvarchar(30),
	@STATUS int

AS
BEGIN
	BEGIN TRY

	BEGIN TRANSACTION

	UPDATE Trans.Sales_Hdr
	SET AmountTendered = @AMOUNTTENDERED, WaiterName = @WAITERNAME, Room = @ROOM, TipAmount = @TIPAMOUNT,
	ReceiverName = @RECEIVERNAME, Status = @STATUS
	WHERE SalesCode = @SALESCODE

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH

    
	
END

GO


