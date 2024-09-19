USE [GRDB]
GO

/****** Object:  StoredProcedure [Master].[spGET_TABLE_LISTS]    Script Date: 9/7/2024 1:02:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Russel Vasquez
-- Create date: 
-- Description: Display List of Table with Status information	
-- =============================================
CREATE PROCEDURE [Master].[spGET_TABLE_LISTS] 
	
AS
BEGIN
	
	SELECT *
	FROM [Master].[Tables_MF] A
	INNER JOIN [Master].[Table_Status_RF] B
	ON A.TableNumber = B.TableNumber

	ORDER BY B.TableStatusCode, B.TableNumber 

END




GO

