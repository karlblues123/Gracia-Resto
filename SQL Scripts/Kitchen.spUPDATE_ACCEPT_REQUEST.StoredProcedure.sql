USE [GRDB]
GO
/****** Object:  StoredProcedure [Kitchen].[spUPDATE_ACCEPT_REQUEST]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Russel Vasquez
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Kitchen].[spUPDATE_ACCEPT_REQUEST] 
@SALESCODE nvarchar(10),
@USERNAME nvarchar(15)

AS
BEGIN
	BEGIN TRY

	BEGIN TRANSACTION

		DECLARE @USERID int = (SELECT ID FROM xSystem.User_Data WHERE  Username = @USERNAME)

		UPDATE [Kitchen].[Kitchen_Orders_TF]
		SET KitchenStatusID = 2, TrailHistory += ': Accept and for preparing',
		   LastUpdate=getdate() 
		 -- preparing stage
		WHERE SalesCode=@SALESCODE


		--INSERT INTO TRAIL
		INSERT INTO [Kitchen].[Audit_Trail]
		(SalesCode, ActionMade, UserID)
		VALUES
		(@SALESCODE, 'ACCEPT ORDER', @USERID)

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH
END




GO
