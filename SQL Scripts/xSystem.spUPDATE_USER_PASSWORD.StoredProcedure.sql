USE [GRDB]
GO
/****** Object:  StoredProcedure [xSystem].[spUPDATE_USER_PASSWORD]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Update the User's Password
-- =============================================
CREATE PROCEDURE [xSystem].[spUPDATE_USER_PASSWORD] 
	-- Add the parameters for the stored procedure here
	@USERNAME nvarchar(15),
	@PASSWORD nvarchar(max)
AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION

			DECLARE @USERID int = (SELECT ID FROM xSystem.User_Data WHERE Username=@USERNAME)

			UPDATE xSystem.User_Data
			SET Password = @PASSWORD
			WHERE ID = @USERID

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH

END

GO
