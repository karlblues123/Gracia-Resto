USE [GRDB]
GO

/****** Object:  StoredProcedure [Master].[spUPDATE_OPEN_TABLE]    Script Date: 9/9/2024 3:36:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Russel Vasquez
-- Create date: 
-- Description:	Clear or Open Table
-- =============================================
CREATE PROCEDURE [Master].[spUPDATE_OPEN_TABLE] 
@TABLENUMBER int,
@USERNAME nvarchar(15)

AS
BEGIN
	BEGIN TRY

	BEGIN TRANSACTION
		
		DECLARE @CUSTOMER NVARCHAR(6) = (SELECT Customer FROM [Master].[Table_Status_RF] WHERE tablenumber=@TABLENUMBER)
		DECLARE @USERID int = (SELECT ID FROM [xSystem].[User_Data] WHERE Username=@USERNAME) --Added 3/19/24 Karl Unabia
		
		UPDATE [Master].[Table_Status_RF]
		SET TableStatusCode = 'A',  LastUpdate = Getdate(), Customer = NULL
		WHERE TableNumber = @TABLENUMBER


		--TRAIL
		INSERT INTO [Master].[Table_Audit_Trail]
		(TableNumber,Customer,TYPE,UserID)
		VALUES
		(@TABLENUMBER,@CUSTOMER,'OPEN',@USERID)

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH
END




GO

