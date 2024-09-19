USE [GRDB]
GO
/****** Object:  Table [Menu].[Dish_Type_RF]    Script Date: 8/29/2024 3:06:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Menu].[Dish_Type_RF](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Dish_Type_RF] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [Menu].[Dish_Type_RF] ON 

INSERT [Menu].[Dish_Type_RF] ([ID], [Description]) VALUES (1, N'Appetizer')
INSERT [Menu].[Dish_Type_RF] ([ID], [Description]) VALUES (2, N'Soup')
INSERT [Menu].[Dish_Type_RF] ([ID], [Description]) VALUES (3, N'Main Course')
INSERT [Menu].[Dish_Type_RF] ([ID], [Description]) VALUES (4, N'Rice')
INSERT [Menu].[Dish_Type_RF] ([ID], [Description]) VALUES (5, N'Dessert')
INSERT [Menu].[Dish_Type_RF] ([ID], [Description]) VALUES (6, N'Beverage')
SET IDENTITY_INSERT [Menu].[Dish_Type_RF] OFF
