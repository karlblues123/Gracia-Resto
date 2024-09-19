USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spGET_PO_HDR]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Trans].[spGET_PO_HDR] 
	-- Add the parameters for the stored procedure here
	@POCODE nvarchar(15)
AS
BEGIN
	
	SELECT *, B.Username
	FROM Trans.Item_PO_Hdr A
	INNER JOIN xSystem.User_Data B
	ON A.UserID = B.ID
	WHERE POCode = @POCODE

END



GO
