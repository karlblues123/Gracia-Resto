USE [GRDB]
GO
/****** Object:  StoredProcedure [Kitchen].[spGET_ORDER_LISTS]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Russel Vasquez
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Kitchen].[spGET_ORDER_LISTS]

AS
BEGIN
	
	SELECT *
	FROM [Kitchen].Kitchen_Orders_TF A
	INNER JOIN [Trans].Sales_Hdr B
	ON A.SalesCode = B.SalesCode
	ORDER BY DI
	

END



GO
