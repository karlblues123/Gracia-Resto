USE [GRDB]
GO

/****** Object:  StoredProcedure [Master].[spUPDATE_TABLE_STATUS]    Script Date: 9/7/2024 2:02:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Russel Vasquez
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Master].[spUPDATE_TABLE_STATUS] 
@CUSTOMER nvarchar(30),
@NOTES NVARCHAR(150),
@TABLENUMBER int,
@ISDINING bit,
@USERNAME nvarchar(15) --Added 3/19/2024 Karl Unabia
AS
BEGIN
	BEGIN TRY

	BEGIN TRANSACTION

		DECLARE @TABLE_STATUS_CODE nvarchar(1)
		DECLARE @AUDIT_TYPE nvarchar(10)
		DECLARE @USERID int = (SELECT ID FROM [xSystem].[User_Data] WHERE Username = @USERNAME)
	
		IF @ISDINING = 1 
			BEGIN
				SET @TABLE_STATUS_CODE = 'O'  -- Occupied
				SET @AUDIT_TYPE = 'DINE'
			END
			ELSE
				BEGIN
				SET @TABLE_STATUS_CODE = 'R' -- Reserved
				SET @AUDIT_TYPE = 'RESERVE'
				END

		
		UPDATE [Master].[Table_Status_RF]
		SET Customer = @CUSTOMER, tableStatusCode = @TABLE_STATUS_CODE,  LastUpdate = Getdate()
		WHERE TableNumber = @TABLENUMBER


		--TRAIL
		INSERT INTO [Master].[Table_Audit_Trail]
		(TableNumber,Customer,TYPE,UserID)
		VALUES
		(@TABLENUMBER,@CUSTOMER,@AUDIT_TYPE,@USERID)

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH
END





GO

