USE [GRDB]
GO
/****** Object:  StoredProcedure [Master].[spUPDATE_TABLE_RESERVE_TO_DINE]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Russel Vasquez
-- Create date: 
-- Description:	Convert Reserve to Dine
-- =============================================
CREATE PROCEDURE [Master].[spUPDATE_TABLE_RESERVE_TO_DINE] 
@TABLENUMBER int,
@USERNAME nvarchar(15)

AS
BEGIN
	BEGIN TRY

	BEGIN TRANSACTION

		DECLARE @GUC NVARCHAR(6) = (SELECT GUC FROM [Master].[Table_Status_RF] WHERE tablenumber=@TABLENUMBER)
		DECLARE @USERID int = (SELECT ID FROM [xSystem].[User_Data] WHERE Username=@USERNAME) --Added 3/19/24 Karl Unabia

		UPDATE [Master].[Table_Status_RF]
		SET TableStatusCode = 'O', LastUpdate = Getdate()
		WHERE TableNumber = @TABLENUMBER AND TableStatusCode = 'R'


		--TRAIL
		INSERT INTO [Master].[Table_Audit_Trail]
		(TableNumber,GUC,TYPE,UserID)
		VALUES
		(@TABLENUMBER,@GUC,'DINE',@USERID)

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH
END



GO
