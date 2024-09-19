USE [GRDB]
GO

/****** Object:  StoredProcedure [Trans].[spUPSERT_VOID_SALES]    Script Date: 8/29/2024 4:32:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Update a Sales to Void and Insert a Void entry
-- =============================================
CREATE PROCEDURE [Trans].[spUPSERT_VOID_SALES] 
	-- Add the parameters for the stored procedure here
	@SALESCODE nvarchar(15),
	@VOIDCODE nvarchar(15),
	@DATE date,
	@REASON nvarchar(250),
	@LINETABLE Trans.SALES_LINE readonly,
	@USERNAME nvarchar(15)
	  
AS
BEGIN
	
	BEGIN TRY

	BEGIN TRANSACTION
		
	DECLARE @USERID INT = (SELECT ID FROM xSystem.User_Data WHERE Username = @USERNAME)

	UPDATE Trans.Sales_Hdr
	SET Status = 4
	WHERE SalesCode = @SALESCODE

	UPDATE Menu.Dish_Hdr
	SET Stock = Stock + T.Quantity
	FROM @LINETABLE AS T
	WHERE Menu.Dish_Hdr.DishCode = T.DishCode

	INSERT INTO Trans.Void_Sales
	(VoidCode,SalesCode,Date,Reason,UserID)

	VALUES
	(@VOIDCODE,@SALESCODE,@DATE,@REASON,@USERID)


	--Added 03.12.2024 Russel
	UPDATE Kitchen.Kitchen_Orders_TF
	SET KitchenStatusID = 4, TrailHistory += ' Order Cancelled',
	LastUpdate = GETDATE() --4 MEANS CANCEL / VOID
	WHERE SalesCode = @SALESCODE

	EXEC xSystem.UPDATE_SERIES_NUMBER 'V'

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH

END




GO

