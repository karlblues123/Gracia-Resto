USE [CGDB]
GO

/****** Object:  StoredProcedure [Menu].[GET_ITEM_DATA]    Script Date: 2/3/2024 10:48:01 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Menu].[GET_ITEM_DATA] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	SELECT *
	FROM Menu.Item_Data
END

GO

