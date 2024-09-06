USE [CGDB]
GO

/****** Object:  StoredProcedure [Trans].[GET_LIST_PO]    Script Date: 2/3/2024 10:52:02 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get a list of Purchase Order
-- =============================================
CREATE PROCEDURE [Trans].[GET_LIST_PO] 
	
AS
BEGIN
	
	SELECT *
	FROM [Trans].[Item_PO_Hdr]

END

GO

