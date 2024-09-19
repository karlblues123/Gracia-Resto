USE [GRDB]
GO
/****** Object:  StoredProcedure [xSystem].[spGET_LIST_USER_TYPES]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the list of user types
-- =============================================
CREATE PROCEDURE [xSystem].[spGET_LIST_USER_TYPES] 
	
AS
BEGIN
	
	SELECT *
	FROM xSystem.User_Type_RF

END

GO
