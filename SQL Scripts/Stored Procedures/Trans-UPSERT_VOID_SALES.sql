USE [CGDB]
GO

/****** Object:  StoredProcedure [Trans].[UPSERT_VOID_SALES]    Script Date: 2/13/2024 11:25:07 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Update a Sales to Void and Insert a Void entry
-- =============================================
CREATE PROCEDURE [Trans].[UPSERT_VOID_SALES] 
	-- Add the parameters for the stored procedure here
	@SALESCODE nvarchar(15),
	@VOIDCODE nvarchar(15),
	@DATE date,
	@REASON nvarchar(250)
	  
AS
BEGIN
	
	BEGIN TRY

	BEGIN TRANSACTION

	UPDATE Trans.Sales_Hdr
	SET Status = 3
	WHERE SalesCode = @SALESCODE

	INSERT INTO Trans.Void_Sales
	(VoidCode,SalesCode,Date,Reason)

	VALUES
	(@VOIDCODE,@SALESCODE,@DATE,@REASON)

	EXEC xSystem.UPDATE_SERIES_NUMBER 'V'

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH

END

GO


