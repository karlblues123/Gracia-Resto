USE [CGDB]
GO

/****** Object:  Table [Trans].[Sales_Hdr]    Script Date: 2/8/2024 4:41:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Trans].[Sales_Hdr](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SalesCode] [nvarchar](15) NOT NULL,
	[CustomerName] [nvarchar](30) NOT NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
	[AmountTendered] [decimal](18, 2) NOT NULL,
	[Date] [date] NOT NULL,
	[WaiterName] [nvarchar](20) NULL,
	[Room] [nvarchar](20) NULL,
	[TipAmount] [decimal](12, 2) NULL,
	[ReceiverName] [nvarchar](30) NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Sales_Hdr] PRIMARY KEY CLUSTERED 
(
	[SalesCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [Trans].[Sales_Hdr] ADD  CONSTRAINT [DF__Sales_Hdr__Statu__7AF13DF7]  DEFAULT ((0)) FOR [Status]
GO


