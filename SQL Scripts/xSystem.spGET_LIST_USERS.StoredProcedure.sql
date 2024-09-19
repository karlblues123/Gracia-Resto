USE [GRDB]
GO
/****** Object:  StoredProcedure [xSystem].[spGET_LIST_USERS]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Get the list of users
-- =============================================
CREATE PROCEDURE [xSystem].[spGET_LIST_USERS] 
	
AS
BEGIN
	
	SELECT A.ID, A.Username, B.TypeName, A.IsActive
	FROM xSystem.User_Data A
	INNER JOIN xSystem.User_Type_RF B
	ON A.UserType = B.ID

END

GO
