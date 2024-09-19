USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spINSERT_ITEM_LOG]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Insert a new Item Log
-- =============================================
CREATE PROCEDURE [Menu].[spINSERT_ITEM_LOG] 
	@ITEMCODE nvarchar(20),
	@NOTES nvarchar(150),
	@ACTIONMADE nvarchar(50),
	@USERNAME nvarchar(15)
AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION

			DECLARE @USERID INT = (SELECT ID FROM xSystem.User_Data WHERE Username = @USERNAME)
			
			INSERT INTO Menu.Item_Trail
			(ItemCode,Notes,ActionMade,DI,UserID)
			VALUES
			(@ITEMCODE,@NOTES,@ACTIONMADE,GETDATE(),@USERID)

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH

END

GO
