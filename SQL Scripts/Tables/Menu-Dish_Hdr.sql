USE [CGDB]
GO

/****** Object:  Table [Menu].[Dish_Hdr]    Script Date: 2/3/2024 10:42:25 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [Menu].[Dish_Hdr](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DishCode] [nvarchar](15) NOT NULL,
	[DishName] [nvarchar](50) NOT NULL,
	[DishPrice] [decimal](18, 2) NOT NULL CONSTRAINT [DF_Dish_Hdr_DishPrice]  DEFAULT ((0.00)),
	[DishStock] [int] NOT NULL CONSTRAINT [DF_Dish_Hdr_DishStock]  DEFAULT ((0)),
	[DishServing] [int] NOT NULL CONSTRAINT [DF_Dish_Hdr_DishServing]  DEFAULT ((0)),
	[DishPhoto] [varbinary](max) NULL,
	[DishType] [int] NOT NULL CONSTRAINT [DF_Dish_Hdr_DishType]  DEFAULT ((1)),
	[DishDescription] [nvarchar](250) NULL,
 CONSTRAINT [PK_Dish_Hdr] PRIMARY KEY CLUSTERED 
(
	[DishCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [Menu].[Dish_Hdr]  WITH CHECK ADD  CONSTRAINT [FK_Dish_Hdr_Dish_Type_RF] FOREIGN KEY([DishType])
REFERENCES [Menu].[Dish_Type_RF] ([TypeID])
GO

ALTER TABLE [Menu].[Dish_Hdr] CHECK CONSTRAINT [FK_Dish_Hdr_Dish_Type_RF]
GO

