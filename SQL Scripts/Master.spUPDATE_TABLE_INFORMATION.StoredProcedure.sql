USE [GRDB]
GO
/****** Object:  StoredProcedure [Master].[spUPDATE_TABLE_INFORMATION]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Update the selected Table
-- =============================================
CREATE PROCEDURE [Master].[spUPDATE_TABLE_INFORMATION] 
	@TABLENUMBER int,
	@TABLENAME nvarchar(30),
	@CAPACITY int,
	@LOCATION nvarchar(50),
	@AVAILABLE bit,
	@NOTES nvarchar(150),
	@USERNAME nvarchar(15)
AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION

			DECLARE @USERID int = (SELECT ID FROM xSystem.User_Data WHERE Username = @USERNAME)
			
			UPDATE Master.Tables_MF
			SET TableName = @TABLENAME, Capacity = @CAPACITY, Location = @LOCATION
			WHERE TableNumber = @TABLENUMBER

			INSERT INTO Master.Table_Info_Trail
			(TableNumber,Notes,ActionMade,DI,UserID)
			VALUES
			(@TABLENUMBER,@NOTES,'UPDATE',GETDATE(),@USERID)

			IF(@AVAILABLE = 0)
			BEGIN
				UPDATE [Master].[Table_Status_RF]
				SET TableStatusCode = 'U',  LastUpdate = Getdate()
				WHERE TableNumber = @TABLENUMBER
			END
			ELSE
			BEGIN
				UPDATE [Master].[Table_Status_RF]
				SET TableStatusCode = 'A',  LastUpdate = Getdate()
				WHERE TableNumber = @TABLENUMBER
			END

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH

END

GO
