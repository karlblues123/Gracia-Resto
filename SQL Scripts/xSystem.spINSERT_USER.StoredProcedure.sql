USE [GRDB]
GO
/****** Object:  StoredProcedure [xSystem].[spINSERT_USER]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Insert a new user of the system
-- =============================================
CREATE PROCEDURE [xSystem].[spINSERT_USER] 
	@USERNAME nvarchar(15),
	@PASSWORD nvarchar(MAX)

AS
BEGIN
	
	

			INSERT INTO xSystem.User_Data
			(Username,Password,UserType)

			VALUES
			(@USERNAME,@PASSWORD,2)

		


END

GO
