USE [GRDB]
GO
/****** Object:  Table [xSystem].[User_Data]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [xSystem].[User_Data](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](15) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[UserType] [int] NOT NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_User_Data_IsActive]  DEFAULT ((0)),
 CONSTRAINT [PK_User_Data] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [xSystem].[User_Data]  WITH CHECK ADD  CONSTRAINT [FK_User_Data_User_Type_RF] FOREIGN KEY([UserType])
REFERENCES [xSystem].[User_Type_RF] ([ID])
GO
ALTER TABLE [xSystem].[User_Data] CHECK CONSTRAINT [FK_User_Data_User_Type_RF]
GO
