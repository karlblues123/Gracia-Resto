USE [GRDB]
GO
/****** Object:  StoredProcedure [Master].[spGET_CUSTOMER_BY_CODE]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get CODE via Code
-- =============================================
CREATE PROCEDURE [Master].[spGET_CUSTOMER_BY_CODE] 
	-- Add the parameters for the stored procedure here
	@GUESTCODE nvarchar(6)
AS
BEGIN


	SELECT C.*
	FROM Master.Customer C
	WHERE C.GuestCode = @GUESTCODE

END

GO
