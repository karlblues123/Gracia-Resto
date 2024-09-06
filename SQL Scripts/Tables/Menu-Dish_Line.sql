USE [CGDB]
GO

/****** Object:  Table [Menu].[Dish_Line]    Script Date: 2/3/2024 10:42:39 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Menu].[Dish_Line](
	[DishCode] [nvarchar](15) NOT NULL,
	[ItemCode] [nvarchar](20) NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ItemQuantity] [real] NOT NULL,
	[ItemPrice] [decimal](18, 2) NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [Menu].[Dish_Line]  WITH CHECK ADD  CONSTRAINT [FK_Dish_Hdr_Dish_Line] FOREIGN KEY([DishCode])
REFERENCES [Menu].[Dish_Hdr] ([DishCode])
GO

ALTER TABLE [Menu].[Dish_Line] CHECK CONSTRAINT [FK_Dish_Hdr_Dish_Line]
GO

ALTER TABLE [Menu].[Dish_Line]  WITH CHECK ADD  CONSTRAINT [FK_Dish_Line_Item_Data] FOREIGN KEY([ItemCode])
REFERENCES [Menu].[Item_Data] ([ItemCode])
GO

ALTER TABLE [Menu].[Dish_Line] CHECK CONSTRAINT [FK_Dish_Line_Item_Data]
GO

