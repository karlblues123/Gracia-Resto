USE [GRDB]
GO

/****** Object:  StoredProcedure [Trans].[spINSERT_SALES]    Script Date: 9/7/2024 10:39:42 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Insert a new Sales transaction
-- =============================================
CREATE PROCEDURE [Trans].[spINSERT_SALES]
	@SALESCODE nvarchar(15),
	@CUSTOMER nvarchar(15),
	@TOTALAMOUNT decimal(18,2),
	@AMOUNTTENDERED decimal(18,2),
	@DATE date,
	@WAITERNAME nvarchar(20),
	@ROOM nvarchar(20),
	@LINETABLE Trans.SALES_LINE readonly,
	@USERNAME nvarchar(15)
	
AS
BEGIN
	BEGIN TRY

	BEGIN TRANSACTION

	INSERT INTO Trans.Sales_Hdr
	(SalesCode,Customer,TotalAmount,AmountTendered,Date,WaiterName,Room)
	VALUES
	(@SALESCODE,@CUSTOMER,@TOTALAMOUNT,@AMOUNTTENDERED,@DATE,@WAITERNAME,@ROOM)

	--ADDED RUSSEL 02.17.2024
	INSERT INTO [Kitchen].[Kitchen_Orders_TF]
	(SalesCode,TrailHistory,LastUpdate)
	VALUES
	(@SALESCODE,'Order Request ' + @USERNAME,GETDATE())

	INSERT INTO Trans.Sales_Line(SalesCode,DishCode,Price,Quantity,Discount)
	SELECT T.SalesCode, T.DishCode, T.Price, T.Quantity, T.Discount
	FROM @LINETABLE AS T

	UPDATE Menu.Dish_Hdr WITH (UPDLOCK, SERIALIZABLE)
	SET Stock = Stock - T.Quantity
	FROM @LINETABLE AS T
	WHERE Menu.Dish_Hdr.DishCode = T.DishCode

	EXEC xSystem.UPDATE_SERIES_NUMBER 'S'

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH
END





GO

