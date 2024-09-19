USE [GRDB]
GO

/****** Object:  Table [Trans].[Sales_Hdr]    Script Date: 9/7/2024 10:55:34 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Trans].[Sales_Hdr](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SalesCode] [nvarchar](15) NOT NULL,
	[Customer] [nvarchar](30) NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
	[AmountTendered] [decimal](18, 2) NOT NULL,
	[Date] [date] NOT NULL,
	[WaiterName] [nvarchar](20) NULL,
	[Room] [nvarchar](20) NULL,
	[TipAmount] [decimal](12, 2) NULL,
	[ReceiverName] [nvarchar](30) NULL,
	[Status] [int] NOT NULL,
	[NumOfGuest] [int] NULL,
 CONSTRAINT [PK_Sales_Hdr] PRIMARY KEY CLUSTERED 
(
	[SalesCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [Trans].[Sales_Hdr] ADD  CONSTRAINT [DF_Sales_Hdr_AmountTendered]  DEFAULT ((0.00)) FOR [AmountTendered]
GO

ALTER TABLE [Trans].[Sales_Hdr] ADD  CONSTRAINT [DF__Sales_Hdr__Statu__7AF13DF7]  DEFAULT ((1)) FOR [Status]
GO

