USE [GRDB]
GO

/****** Object:  StoredProcedure [Master].[spGET_TABLE_LOGS]    Script Date: 9/10/2024 10:55:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the Table Audit logs with Customer Name
-- =============================================
CREATE PROCEDURE [Master].[spGET_TABLE_LOGS] 
	
AS
BEGIN
	 
	 SELECT A.*, C.Username
	 FROM Master.Table_Audit_Trail A
	 INNER JOIN xSystem.User_Data C
	 ON A.UserID = C.ID

END


GO

