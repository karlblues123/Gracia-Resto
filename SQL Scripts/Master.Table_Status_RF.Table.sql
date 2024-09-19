USE [GRDB]
GO
/****** Object:  Table [Master].[Table_Status_RF]    Script Date: 9/19/2024 10:25:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Master].[Table_Status_RF](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TableNumber] [int] NOT NULL,
	[Customer] [nvarchar](30) NULL,
	[TableStatusCode] [nvarchar](1) NULL CONSTRAINT [DF_Table_Status_RF_TableStatusCode]  DEFAULT ('A'),
	[LastUpdate] [datetime] NULL,
 CONSTRAINT [PK_Table_Status_RF] PRIMARY KEY CLUSTERED 
(
	[TableNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [Master].[Table_Status_RF] ON 

INSERT [Master].[Table_Status_RF] ([ID], [TableNumber], [Customer], [TableStatusCode], [LastUpdate]) VALUES (1, 1, NULL, N'A', CAST(N'2024-09-09 15:31:03.643' AS DateTime))
INSERT [Master].[Table_Status_RF] ([ID], [TableNumber], [Customer], [TableStatusCode], [LastUpdate]) VALUES (2, 2, NULL, N'A', CAST(N'2024-09-09 15:35:14.073' AS DateTime))
INSERT [Master].[Table_Status_RF] ([ID], [TableNumber], [Customer], [TableStatusCode], [LastUpdate]) VALUES (3, 3, NULL, N'A', CAST(N'2024-09-19 10:20:02.227' AS DateTime))
INSERT [Master].[Table_Status_RF] ([ID], [TableNumber], [Customer], [TableStatusCode], [LastUpdate]) VALUES (4, 4, NULL, N'A', CAST(N'2024-09-19 10:20:08.793' AS DateTime))
INSERT [Master].[Table_Status_RF] ([ID], [TableNumber], [Customer], [TableStatusCode], [LastUpdate]) VALUES (5, 5, NULL, N'A', CAST(N'2024-09-19 10:20:17.410' AS DateTime))
INSERT [Master].[Table_Status_RF] ([ID], [TableNumber], [Customer], [TableStatusCode], [LastUpdate]) VALUES (6, 6, NULL, N'A', CAST(N'2024-09-19 10:20:34.007' AS DateTime))
INSERT [Master].[Table_Status_RF] ([ID], [TableNumber], [Customer], [TableStatusCode], [LastUpdate]) VALUES (7, 7, NULL, N'A', CAST(N'2024-09-19 10:20:45.423' AS DateTime))
INSERT [Master].[Table_Status_RF] ([ID], [TableNumber], [Customer], [TableStatusCode], [LastUpdate]) VALUES (8, 8, NULL, N'A', CAST(N'2024-09-19 10:20:50.403' AS DateTime))
INSERT [Master].[Table_Status_RF] ([ID], [TableNumber], [Customer], [TableStatusCode], [LastUpdate]) VALUES (9, 9, NULL, N'A', CAST(N'2024-09-19 10:20:58.270' AS DateTime))
INSERT [Master].[Table_Status_RF] ([ID], [TableNumber], [Customer], [TableStatusCode], [LastUpdate]) VALUES (10, 10, NULL, N'A', CAST(N'2024-09-19 10:21:04.207' AS DateTime))
SET IDENTITY_INSERT [Master].[Table_Status_RF] OFF
