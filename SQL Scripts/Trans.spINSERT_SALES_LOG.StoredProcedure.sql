USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spINSERT_SALES_LOG]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Insert a new Sales Log
-- =============================================
CREATE PROCEDURE [Trans].[spINSERT_SALES_LOG] 
	@SALESCODE nvarchar(15),
	@NOTES nvarchar(150),
	@ACTION nvarchar(50),
	@USERNAME nvarchar(15)
AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION

			DECLARE @USERID INT = (SELECT ID FROM xSystem.User_Data WHERE Username = @USERNAME)

			INSERT INTO Trans.Sales_Trail
			(SalesCode,Notes,ActionMade,DI,UserID)
			VALUES
			(@SALESCODE,@NOTES,@ACTION,GETDATE(),@USERID)

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH
	 
END

GO
