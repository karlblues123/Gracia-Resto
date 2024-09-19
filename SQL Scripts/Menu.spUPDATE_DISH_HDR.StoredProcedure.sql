USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spUPDATE_DISH_HDR]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Menu].[spUPDATE_DISH_HDR] 
	-- Add the parameters for the stored procedure here
	@DISHCODE nvarchar(15),
	@DISHNAME nvarchar(50),
	@DISHSERVING int,
	@DISHTYPE int,
	@DISHDESCRIPTION nvarchar(250),
	@ISACTIVE bit,
	@NOTES nvarchar(150),
	@USERNAME nvarchar(15)

AS
BEGIN
	
	BEGIN TRY

	BEGIN TRANSACTION

	UPDATE [Menu].Dish_Hdr
	SET Name = @DISHNAME, Serving = @DISHSERVING,
	Type = @DISHTYPE, Description = @DISHDESCRIPTION, IsActive = @ISACTIVE
	WHERE DishCode = @DISHCODE

	EXEC Menu.spINSERT_DISH_LOG @DISHCODE,@NOTES,'UPDATE - HDR',@USERNAME

	COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

	ROLLBACK TRANSACTION

	END CATCH

END



GO
