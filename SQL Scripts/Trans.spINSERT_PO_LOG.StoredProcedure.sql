USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spINSERT_PO_LOG]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Insert a new PO Log
-- =============================================
CREATE PROCEDURE [Trans].[spINSERT_PO_LOG] 
	@POCODE nvarchar(15),
	@NOTES nvarchar(150),
	@ACTIONMADE nvarchar(50),
	@USERNAME nvarchar(15)

AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION

			DECLARE @USERID INT = (SELECT ID FROM xSystem.User_Data WHERE Username = @USERNAME)

			INSERT INTO Trans.PO_Trail
			(POCode,Notes,ActionMade,UserID)
			VALUES
			(@POCODE,@NOTES,@ACTIONMADE,@USERID)

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		COMMIT TRANSACTION

	END CATCH

END

GO
