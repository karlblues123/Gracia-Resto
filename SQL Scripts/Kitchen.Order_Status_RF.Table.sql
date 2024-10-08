USE [GRDB]
GO
/****** Object:  Table [Kitchen].[Order_Status_RF]    Script Date: 8/29/2024 2:29:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Kitchen].[Order_Status_RF](
	[KitchenStatusID] [int] NOT NULL,
	[Description] [nvarchar](50) NULL,
 CONSTRAINT [PK_Order_Status_RF] PRIMARY KEY CLUSTERED 
(
	[KitchenStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [Kitchen].[Order_Status_RF] ([KitchenStatusID], [Description]) VALUES (1, N'Preparing')
INSERT [Kitchen].[Order_Status_RF] ([KitchenStatusID], [Description]) VALUES (2, N'Accept Order')
INSERT [Kitchen].[Order_Status_RF] ([KitchenStatusID], [Description]) VALUES (3, N'Orders Complete')
INSERT [Kitchen].[Order_Status_RF] ([KitchenStatusID], [Description]) VALUES (4, N'Void Orders')
