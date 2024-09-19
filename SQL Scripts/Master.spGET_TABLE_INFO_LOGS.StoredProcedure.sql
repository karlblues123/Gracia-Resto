USE [GRDB]
GO
/****** Object:  StoredProcedure [Master].[spGET_TABLE_INFO_LOGS]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the Table Info Logs
-- =============================================
CREATE PROCEDURE [Master].[spGET_TABLE_INFO_LOGS] 
	
AS
BEGIN
	
	SELECT L.*, T.TableName, U.Username
	FROM Master.Table_Info_Trail L
	INNER JOIN Master.Tables_MF T
	ON L.TableNumber = T.TableNumber
	INNER JOIN xSystem.User_Data U
	ON L.UserID = U.ID

END

GO
