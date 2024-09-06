USE [CGDB]
GO

/****** Object:  UserDefinedTableType [Trans].[SALES_LINE]    Script Date: 2/8/2024 4:44:43 PM ******/
CREATE TYPE [Trans].[SALES_LINE] AS TABLE(
	[SalesCode] [nvarchar](15) NULL,
	[DishCode] [nvarchar](15) NULL,
	[Price] [decimal](18, 2) NULL,
	[Quantity] [int] NULL,
	[Discount] [real] NULL
)
GO


