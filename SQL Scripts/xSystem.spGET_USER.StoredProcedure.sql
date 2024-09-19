USE [GRDB]
GO
/****** Object:  StoredProcedure [xSystem].[spGET_USER]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get User credentials
-- =============================================
CREATE PROCEDURE [xSystem].[spGET_USER] 
	-- Add the parameters for the stored procedure here
	@USERNAME  nvarchar(15)
AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION

		SELECT Password, UserType,IsActive
		FROM xSystem.User_Data
		WHERE Username = @USERNAME

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH

END

GO
