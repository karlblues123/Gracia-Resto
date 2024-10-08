USE [GRDB]
GO
/****** Object:  Table [Trans].[PO_Trail]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Trans].[PO_Trail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[POCode] [nvarchar](15) NOT NULL,
	[Notes] [nvarchar](150) NULL,
	[ActionMade] [nvarchar](50) NOT NULL,
	[DI] [datetime] NOT NULL CONSTRAINT [DF_PO_Trail_DI]  DEFAULT (getdate()),
	[UserID] [int] NOT NULL
) ON [PRIMARY]

GO
ALTER TABLE [Trans].[PO_Trail]  WITH CHECK ADD  CONSTRAINT [FK_PO_Trail_Item_PO_Hdr] FOREIGN KEY([POCode])
REFERENCES [Trans].[Item_PO_Hdr] ([POCode])
GO
ALTER TABLE [Trans].[PO_Trail] CHECK CONSTRAINT [FK_PO_Trail_Item_PO_Hdr]
GO
