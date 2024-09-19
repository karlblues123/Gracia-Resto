USE [GRDB]
GO
/****** Object:  UserDefinedTableType [Trans].[PO_LINE]    Script Date: 8/28/2024 8:46:45 AM ******/
CREATE TYPE [Trans].[PO_LINE] AS TABLE(
	[POCode] [nvarchar](15) NOT NULL,
	[ItemCode] [nvarchar](20) NOT NULL,
	[ItemQuantity] [real] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[ReceivedQuantity] [real] NULL,
	[ActualPrice] [decimal](18, 2) NULL
)
GO
