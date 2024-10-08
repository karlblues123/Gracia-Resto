USE [GRDB]
GO
/****** Object:  UserDefinedTableType [Trans].[SALES_LINE]    Script Date: 8/28/2024 8:46:45 AM ******/
CREATE TYPE [Trans].[SALES_LINE] AS TABLE(
	[SalesCode] [nvarchar](15) NULL,
	[DishCode] [nvarchar](15) NULL,
	[Price] [decimal](18, 2) NULL,
	[Quantity] [int] NULL,
	[Discount] [real] NULL
)
GO
