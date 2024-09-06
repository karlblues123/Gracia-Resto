USE [CGDB]
GO

/****** Object:  Table [Trans].[Item_PO_Line]    Script Date: 2/3/2024 10:43:37 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Trans].[Item_PO_Line](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[POCode] [nvarchar](15) NOT NULL,
	[ItemCode] [nvarchar](20) NOT NULL,
	[ItemQuantity] [real] NULL,
	[ItemPrice] [decimal](18, 2) NULL,
	[ReceivedQuantity] [real] NULL,
 CONSTRAINT [PK_Item_PO_Line] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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

