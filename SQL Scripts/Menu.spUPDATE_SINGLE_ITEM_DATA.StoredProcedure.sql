USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spUPDATE_SINGLE_ITEM_DATA]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Menu].[spUPDATE_SINGLE_ITEM_DATA] 
	-- Add the parameters for the stored procedure here
	@ItemCode nvarchar(20), 
	@ItemName nvarchar(50),
	@ItemPrice decimal(18,2),
	@ItemUM nvarchar(10),
	@NOTES nvarchar(150),
	@USERNAME nvarchar(15)

AS
BEGIN

BEGIN TRY
	
	BEGIN TRANSACTION

	UPDATE [Menu].[Item_Data]
	SET Name = @ItemName, Price = @ItemPrice, UM = @ItemUM
	WHERE ItemCode = @ItemCode

	EXEC Menu.spINSERT_ITEM_LOG @ItemCode,@NOTES,'UPDATE',@USERNAME

	COMMIT TRANSACTION

END TRY

BEGIN CATCH

	ROLLBACK TRANSACTION

END CATCH

END



GO
