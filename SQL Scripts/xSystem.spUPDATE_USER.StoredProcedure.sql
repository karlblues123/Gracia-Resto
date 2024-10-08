USE [GRDB]
GO
/****** Object:  StoredProcedure [xSystem].[spUPDATE_USER]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Update Type and IsActive fields of a user
-- =============================================
CREATE PROCEDURE [xSystem].[spUPDATE_USER] 
	-- Add the parameters for the stored procedure here
	@TYPEID int, 
	@ISACTIVE bit,
	@USERID int
AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION

			UPDATE xSystem.User_Data WITH (UPDLOCK,SERIALIZABLE)
			SET UserType = @TYPEID, IsActive = @ISACTIVE
			WHERE ID = @USERID

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH

END


GO
