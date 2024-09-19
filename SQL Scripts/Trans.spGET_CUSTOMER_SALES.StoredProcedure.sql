USE [GRDB]
GO
/****** Object:  StoredProcedure [Trans].[spGET_CUSTOMER_SALES]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get Sales by Customer
-- =============================================
CREATE PROCEDURE [Trans].[spGET_CUSTOMER_SALES] 
	-- Add the parameters for the stored procedure here
	@GUESTCODE nvarchar(15) 
AS
BEGIN
	
	SELECT H.*, L.*, D.Name
	FROM Trans.Sales_Hdr H
	INNER JOIN Trans.Sales_Line L
	ON H.SalesCode = L.SalesCode
	INNER JOIN Menu.Dish_Hdr D
	ON L.DishCode = D.DishCode
	WHERE H.CustomerCode = @GUESTCODE

END

GO
