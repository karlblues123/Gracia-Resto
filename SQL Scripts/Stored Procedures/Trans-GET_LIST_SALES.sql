USE [CGDB]
GO

/****** Object:  StoredProcedure [Trans].[GET_LIST_SALES]    Script Date: 2/8/2024 4:45:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Trans].[GET_LIST_SALES] 
	
AS
BEGIN
	
	SELECT *
	FROM Trans.Sales_Hdr

END

GO


