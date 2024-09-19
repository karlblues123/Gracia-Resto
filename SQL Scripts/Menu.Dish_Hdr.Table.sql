USE [GRDB]
GO
/****** Object:  Table [Menu].[Dish_Hdr]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Menu].[Dish_Hdr](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DishCode] [nvarchar](15) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Dish_Hdr_DishPrice]  DEFAULT ((0.00)),
	[Stock] [int] NOT NULL CONSTRAINT [DF_Dish_Hdr_DishStock]  DEFAULT ((0)),
	[Serving] [int] NOT NULL CONSTRAINT [DF_Dish_Hdr_DishServing]  DEFAULT ((0)),
	[Type] [int] NOT NULL CONSTRAINT [DF_Dish_Hdr_DishType]  DEFAULT ((1)),
	[Description] [nvarchar](250) NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_Dish_Hdr_IsActive]  DEFAULT ((1)),
 CONSTRAINT [PK_Dish_Hdr] PRIMARY KEY CLUSTERED 
(
	[DishCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [Menu].[Dish_Hdr]  WITH CHECK ADD  CONSTRAINT [FK_Dish_Hdr_Dish_Type_RF] FOREIGN KEY([Type])
REFERENCES [Menu].[Dish_Type_RF] ([TypeID])
GO
ALTER TABLE [Menu].[Dish_Hdr] CHECK CONSTRAINT [FK_Dish_Hdr_Dish_Type_RF]
GO
