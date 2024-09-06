USE [CGDB]
GO

/****** Object:  StoredProcedure [Trans].[INSERT_SALES]    Script Date: 2/8/2024 4:44:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Insert a new Sales transaction
-- =============================================
CREATE PROCEDURE [Trans].[INSERT_SALES]
	@SALESCODE nvarchar(15),
	@CUSTOMERNAME nvarchar(30),
	@TOTALAMOUNT decimal(18,2),
	@AMOUNTTENDERED decimal(18,2),
	@DATE date,
	@WAITERNAME nvarchar(20),
	@ROOM nvarchar(20),
	@LINETABLE Trans.SALES_LINE readonly
	
AS
BEGIN
	BEGIN TRY

	BEGIN TRANSACTION

	INSERT INTO Trans.Sales_Hdr
	(SalesCode,CustomerName,TotalAmount,AmountTendered,Date,WaiterName,Room)

	VALUES
	(@SALESCODE,@CUSTOMERNAME,@TOTALAMOUNT,@AMOUNTTENDERED,@DATE,@WAITERNAME,@ROOM)

	INSERT INTO Trans.Sales_Line(SalesCode,DishCode,Price,Quantity,Discount)
	SELECT T.SalesCode, T.DishCode, T.Price, T.Quantity, T.Discount
	FROM @LINETABLE AS T

	EXEC xSystem.UPDATE_SERIES_NUMBER 'S'

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH
END


GO


