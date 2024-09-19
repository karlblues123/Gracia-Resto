USE [GRDB]
GO

/****** Object:  StoredProcedure [Kitchen].[spGET_ORDER_REQUEST_LISTS]    Script Date: 9/9/2024 2:38:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Russel Vasquez
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Kitchen].[spGET_ORDER_REQUEST_LISTS]

AS
BEGIN
	
	SELECT *
	FROM [Kitchen].Kitchen_Orders_TF A
	INNER JOIN [Trans].Sales_Hdr B
	ON A.SalesCode = B.SalesCode
	WHERE KitchenStatusID = 1
	ORDER BY A.DI
	

END




GO

