USE [GRDB]
GO
/****** Object:  Table [Menu].[Item_Trail]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Menu].[Item_Trail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ItemCode] [nvarchar](20) NOT NULL,
	[Notes] [nvarchar](150) NULL,
	[ActionMade] [nvarchar](50) NULL,
	[DI] [datetime] NOT NULL CONSTRAINT [DF_Item_trail_DI]  DEFAULT (getdate()),
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_Item_trail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [Menu].[Item_Trail]  WITH CHECK ADD  CONSTRAINT [FK_Item_trail_Item_Data] FOREIGN KEY([ItemCode])
REFERENCES [Menu].[Item_Data] ([ItemCode])
GO
ALTER TABLE [Menu].[Item_Trail] CHECK CONSTRAINT [FK_Item_trail_Item_Data]
GO
