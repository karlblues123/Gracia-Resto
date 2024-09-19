USE [GRDB]
GO
/****** Object:  Table [Menu].[Dish_Trail]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Menu].[Dish_Trail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DishCode] [nvarchar](15) NOT NULL,
	[Notes] [nvarchar](150) NULL,
	[ActionMade] [nvarchar](50) NULL,
	[DI] [datetime] NOT NULL CONSTRAINT [DF_Dish_Trail_DI]  DEFAULT (getdate()),
	[UserID] [int] NULL
) ON [PRIMARY]

GO
ALTER TABLE [Menu].[Dish_Trail]  WITH CHECK ADD  CONSTRAINT [FK_Dish_Trail_Dish_Hdr] FOREIGN KEY([DishCode])
REFERENCES [Menu].[Dish_Hdr] ([DishCode])
GO
ALTER TABLE [Menu].[Dish_Trail] CHECK CONSTRAINT [FK_Dish_Trail_Dish_Hdr]
GO
