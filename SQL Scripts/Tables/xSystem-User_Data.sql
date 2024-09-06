USE [CGDB]
GO

/****** Object:  Table [xSystem].[User_Data]    Script Date: 2/3/2024 10:44:34 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [xSystem].[User_Data](
	[ID] [int] NOT NULL,
	[UserCode] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](150) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_User_Data] PRIMARY KEY CLUSTERED 
(
	[UserCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [xSystem].[User_Data] ADD  CONSTRAINT [DF_User_Data_ID]  DEFAULT ((0)) FOR [ID]
GO

