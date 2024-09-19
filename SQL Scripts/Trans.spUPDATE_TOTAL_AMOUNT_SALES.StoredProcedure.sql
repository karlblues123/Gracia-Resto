USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spUPDATE_TOTAL_AMOUNT_SALES]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Update the Total Amount of a specified Sale
-- =============================================
CREATE PROCEDURE [Trans].[spUPDATE_TOTAL_AMOUNT_SALES] 
	-- Add the parameters for the stored procedure here
	@SALESCODE nvarchar(15), 
	@TOTALAMOUNT decimal(18,2)
AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION

			UPDATE Trans.Sales_Hdr WITH (UPDLOCK, SERIALIZABLE)
			SET TotalAmount = @TOTALAMOUNT
			WHERE SalesCode = @SALESCODE

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH

END

GO
