USE [GRDB]
GO

/****** Object:  StoredProcedure [Trans].[spUPDATE_SALES_HDR]    Script Date: 9/7/2024 10:40:03 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Update Sales Hdr
-- =============================================
CREATE PROCEDURE [Trans].[spUPDATE_SALES_HDR] 
	-- Add the parameters for the stored procedure here
	@SALESCODE nvarchar(15),
	@CUSTOMER nvarchar(30),
	@AMOUNTTENDERED decimal(18,2),
	@WAITERNAME nvarchar(20),
	@ROOM nvarchar(20),
	@TIPAMOUNT decimal(12,2),
	@RECEIVERNAME nvarchar(30),
	@STATUS int,
	@REMARKS nvarchar(150),
	@USERNAME nvarchar(15)

AS
BEGIN
	BEGIN TRY

	BEGIN TRANSACTION

	UPDATE Trans.Sales_Hdr
	SET Customer = @CUSTOMER, AmountTendered = @AMOUNTTENDERED, WaiterName = @WAITERNAME, Room = @ROOM, 
	TipAmount = @TIPAMOUNT, ReceiverName = @RECEIVERNAME, Status = @STATUS
	WHERE SalesCode = @SALESCODE

	UPDATE Kitchen.Kitchen_Orders_TF
	SET KitchenStatusID = CASE WHEN @STATUS = 0 THEN 1 WHEN @STATUS > 0 AND @STATUS < 3 THEN 3 ELSE KitchenStatusID END,
	TrailHistory += ' Order Updated by ' + @USERNAME,
	LastUpdate = GETDATE()
	WHERE SalesCode = @SALESCODE

	EXEC Trans.spINSERT_SALES_LOG @SALESCODE,@REMARKS,'UPDATE - HDR',@USERNAME

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH

    
	
END




GO

