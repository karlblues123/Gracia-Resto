USE [GRDB]
GO
/****** Object:  Table [Menu].[Stock_Adjustment]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Menu].[Stock_Adjustment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DishCode] [nvarchar](15) NOT NULL,
	[AdjustedStock] [int] NOT NULL,
	[Reason] [nvarchar](250) NOT NULL,
	[DI] [datetime] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_Stock_Adjustment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [Menu].[Stock_Adjustment]  WITH CHECK ADD  CONSTRAINT [FK_Stock_Adjustment_Dish_Hdr] FOREIGN KEY([DishCode])
REFERENCES [Menu].[Dish_Hdr] ([DishCode])
GO
ALTER TABLE [Menu].[Stock_Adjustment] CHECK CONSTRAINT [FK_Stock_Adjustment_Dish_Hdr]
GO
ALTER TABLE [Menu].[Stock_Adjustment]  WITH CHECK ADD  CONSTRAINT [FK_Stock_Adjustment_User_Data] FOREIGN KEY([UserID])
REFERENCES [xSystem].[User_Data] ([ID])
GO
ALTER TABLE [Menu].[Stock_Adjustment] CHECK CONSTRAINT [FK_Stock_Adjustment_User_Data]
GO
