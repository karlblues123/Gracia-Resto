USE [GRDB]
GO
/****** Object:  StoredProcedure [Master].[spINSERT_TABLE]    Script Date: 8/29/2024 8:10:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Insert a new Table
-- =============================================
ALTER PROCEDURE [Master].[spINSERT_TABLE] 
	-- Add the parameters for the stored procedure here
	@TABLEID int,
	@TABLENAME nvarchar(30), 
	@CAPACITY int,
	@LOCATION nvarchar(50),
	@USERNAME nvarchar(15)
AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION

			DECLARE @USERID INT = (SELECT ID FROM xSystem.User_Data WHERE Username = @USERNAME)

			INSERT INTO Master.Tables_MF
			(TableNumber,TableName,Capacity,Location,IsAvailable)
			VALUES
			(@TABLEID,@TABLENAME,@CAPACITY,@LOCATION,1)

			INSERT INTO Master.Table_Status_RF
			(TableNumber,TableStatusCode,LastUpdate)
			VALUES
			(@TABLEID,'U',GETDATE())

			INSERT INTO Master.Table_Info_Trail
			(TableNumber,ActionMade,DI,UserID)
			VALUES
			(@TABLEID,'INSERT',GETDATE(),@USERID)

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH

END

