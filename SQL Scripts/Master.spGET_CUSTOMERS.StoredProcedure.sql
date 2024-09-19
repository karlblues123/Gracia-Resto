USE [GRDB]
GO
/****** Object:  StoredProcedure [Master].[spGET_CUSTOMERS]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get all Customers
-- =============================================
CREATE PROCEDURE [Master].[spGET_CUSTOMERS] 

AS
BEGIN
	
	SELECT *
	FROM Master.Customer
	ORDER BY DI DESC

END

GO
