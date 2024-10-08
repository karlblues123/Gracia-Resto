USE [GRDB]
GO
/****** Object:  Table [Trans].[Item_PO_Line]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Trans].[Item_PO_Line](
	[POCode] [nvarchar](15) NOT NULL,
	[ItemCode] [nvarchar](20) NOT NULL,
	[Quantity] [real] NULL,
	[Price] [decimal](18, 2) NULL,
	[ReceivedQuantity] [real] NULL,
	[ActualPrice] [decimal](18, 2) NULL
) ON [PRIMARY]

GO
ALTER TABLE [Trans].[Item_PO_Line]  WITH CHECK ADD  CONSTRAINT [FK_Item_PO_Line_Item_Data] FOREIGN KEY([ItemCode])
REFERENCES [Menu].[Item_Data] ([ItemCode])
GO
ALTER TABLE [Trans].[Item_PO_Line] CHECK CONSTRAINT [FK_Item_PO_Line_Item_Data]
GO
ALTER TABLE [Trans].[Item_PO_Line]  WITH CHECK ADD  CONSTRAINT [FK_Item_PO_Line_Item_PO_Hdr] FOREIGN KEY([POCode])
REFERENCES [Trans].[Item_PO_Hdr] ([POCode])
GO
ALTER TABLE [Trans].[Item_PO_Line] CHECK CONSTRAINT [FK_Item_PO_Line_Item_PO_Hdr]
GO
