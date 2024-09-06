USE [CGDB]
GO

/****** Object:  StoredProcedure [Trans].[GET_PO_HDR]    Script Date: 2/3/2024 10:52:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Trans].[GET_PO_HDR] 
	-- Add the parameters for the stored procedure here
	@POCODE nvarchar(15)
AS
BEGIN
	
	SELECT *
	FROM Trans.Item_PO_Hdr
	WHERE POCode = @POCODE

END

GO

