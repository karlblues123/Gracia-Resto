USE [CGDB]
GO

/****** Object:  UserDefinedTableType [Trans].[PO_LINE]    Script Date: 2/3/2024 10:46:15 AM ******/
CREATE TYPE [Trans].[PO_LINE] AS TABLE(
	[POCode] [nvarchar](15) NOT NULL,
	[ItemCode] [nvarchar](20) NOT NULL,
	[ItemQuantity] [real] NOT NULL,
	[ReceivedQuantity] [real] NULL
)
GO

