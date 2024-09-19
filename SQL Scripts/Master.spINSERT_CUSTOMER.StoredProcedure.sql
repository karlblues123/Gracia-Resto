USE [GRDB]
GO
/****** Object:  StoredProcedure [Master].[spINSERT_CUSTOMER]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Karl Unabia
-- Create date: 
-- Description:	Insert a new Customer
-- =============================================
CREATE PROCEDURE [Master].[spINSERT_CUSTOMER] 
	@GUESTCODE nvarchar(6),
	@LASTNAME nvarchar(15),
	@FIRSTNAME nvarchar(15),
	@BIRTHDATE datetime,
	@GENDER char(1)
AS
BEGIN
	
	BEGIN TRY

		BEGIN TRANSACTION

			INSERT INTO Master.Customer
			(GuestCode,LastName,FirstName,Birthdate,Gender,DI)
			VALUES
			(@GUESTCODE,@LASTNAME,@FIRSTNAME,@BIRTHDATE,@GENDER,GETDATE())

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION

	END CATCH

END

GO
