USE [GRDB]
GO

/****** Object:  StoredProcedure [Kitchen].[spUPDATE_ORDERS_COMPLETE]    Script Date: 8/29/2024 4:49:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Russel Vasquez
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Kitchen].[spUPDATE_ORDERS_COMPLETE] 
@SALESCODE nvarchar(10),
@USERNAME nvarchar(15) --Added 3/20/24 Karl Unabia
AS
BEGIN
	BEGIN TRY

	BEGIN TRANSACTION

		DECLARE @USERID int = (SELECT ID FROM xSystem.User_Data WHERE Username = @USERNAME)
		
		UPDATE [Kitchen].[Kitchen_Orders_TF]
		SET KitchenStatusID = 3, TrailHistory += ': Orders completed.',
		   LastUpdate=getdate() 
		 -- preparing stage
		WHERE SalesCode=@SALESCODE


		--WILL UPDATE THE STATUS IN TRANS SALES HDR
		UPDATE [Trans].[Sales_Hdr]
		SET Status=2  -- 2 Signify as Served
		WHERE SalesCode=@SALESCODE

		--INSERT INTO TRAIL
		INSERT INTO [Kitchen].[Audit_Trail]
		(SalesCode, ActionMade, UserID)
		VALUES
		(@SALESCODE, 'ORDER COMPLETE', @USERID)

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH
END





GO

