USE [CGDB]
GO

/****** Object:  StoredProcedure [Menu].[UPDATE_SINGLE_ITEM_DATA]    Script Date: 2/3/2024 10:51:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Menu].[UPDATE_SINGLE_ITEM_DATA] 
	-- Add the parameters for the stored procedure here
	@ItemCode nvarchar(20), 
	@ItemName nvarchar(50),
	@ItemPrice decimal(18,2),
	@ItemUM nvarchar(10),
	@ItemStock real

AS
BEGIN

BEGIN TRY
	
	BEGIN TRANSACTION

	UPDATE [Menu].[Item_Data]
	SET ItemName = @ItemName, ItemPrice = @ItemPrice, ItemUM = @ItemUM, ItemStock = @ItemStock
	WHERE ItemCode = @ItemCode

	COMMIT TRANSACTION

END TRY

BEGIN CATCH

	ROLLBACK TRANSACTION

END CATCH

END

GO

