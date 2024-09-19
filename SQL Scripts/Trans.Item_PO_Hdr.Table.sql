USE [GRDB]
GO
/****** Object:  Table [Trans].[Item_PO_Hdr]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Trans].[Item_PO_Hdr](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[POCode] [nvarchar](15) NOT NULL,
	[Date] [date] NOT NULL,
	[InCharge] [nvarchar](50) NOT NULL,
	[CashGiven] [real] NULL,
	[UserID] [int] NOT NULL,
	[Receiver] [nvarchar](20) NULL,
	[Remarks] [nvarchar](150) NULL,
 CONSTRAINT [PK_Item_PO_Hdr] PRIMARY KEY CLUSTERED 
(
	[POCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
