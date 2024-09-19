USE [GRDB]
GO
/****** Object:  Table [xSystem].[User_Type_RF]    Script Date: 8/29/2024 2:34:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [xSystem].[User_Type_RF](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_User_Type_RF] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [xSystem].[User_Type_RF] ON 

INSERT [xSystem].[User_Type_RF] ([ID], [TypeName]) VALUES (1, N'Admin')
INSERT [xSystem].[User_Type_RF] ([ID], [TypeName]) VALUES (2, N'User')
SET IDENTITY_INSERT [xSystem].[User_Type_RF] OFF
