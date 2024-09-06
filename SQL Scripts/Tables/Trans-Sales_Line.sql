USE [CGDB]
GO

/****** Object:  Table [Trans].[Sales_Line]    Script Date: 2/8/2024 4:41:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Trans].[Sales_Line](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SalesCode] [nvarchar](15) NOT NULL,
	[DishCode] [nvarchar](15) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Discount] [real] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [Trans].[Sales_Line]  WITH CHECK ADD  CONSTRAINT [FK_Sales_Line_Dish_Hdr] FOREIGN KEY([DishCode])
REFERENCES [Menu].[Dish_Hdr] ([DishCode])
GO

ALTER TABLE [Trans].[Sales_Line] CHECK CONSTRAINT [FK_Sales_Line_Dish_Hdr]
GO

ALTER TABLE [Trans].[Sales_Line]  WITH CHECK ADD  CONSTRAINT [FK_Sales_Line_Sales_Hdr] FOREIGN KEY([SalesCode])
REFERENCES [Trans].[Sales_Hdr] ([SalesCode])
GO

ALTER TABLE [Trans].[Sales_Line] CHECK CONSTRAINT [FK_Sales_Line_Sales_Hdr]
GO


