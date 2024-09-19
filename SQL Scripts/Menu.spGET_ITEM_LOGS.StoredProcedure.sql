USE [GRDB]
GO
/****** Object:  StoredProcedure [Menu].[spGET_ITEM_LOGS]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get Item Logs
-- =============================================
CREATE PROCEDURE [Menu].[spGET_ITEM_LOGS] 

AS
BEGIN
	
	SELECT L.*, D.Name, U.Username
	FROM Menu.Item_Trail L
	INNER JOIN xSystem.User_Data U
	ON L.UserID = U.ID
	INNER JOIN Menu.Item_Data D
	ON L.ItemCode = D.ItemCode

END

GO
