USE [CGDB]
GO

/****** Object:  Table [Trans].[Item_PO_Hdr]    Script Date: 2/3/2024 10:43:24 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Trans].[Item_PO_Hdr](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[POCode] [nvarchar](15) NOT NULL,
	[PODate] [date] NOT NULL,
	[POInCharge] [nvarchar](50) NOT NULL,
	[POCashGiven] [real] NULL,
 CONSTRAINT [PK_Item_PO_Hdr] PRIMARY KEY CLUSTERED 
(
	[POCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

