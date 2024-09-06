USE [CGDB]
GO

/****** Object:  UserDefinedTableType [Menu].[ITEM_DATA]    Script Date: 2/3/2024 10:45:58 AM ******/
CREATE TYPE [Menu].[ITEM_DATA] AS TABLE(
	[ItemCode] [nvarchar](20) NOT NULL,
	[ItemName] [nvarchar](50) NOT NULL,
	[ItemPrice] [decimal](18, 2) NOT NULL,
	[ItemUM] [nvarchar](10) NOT NULL,
	[ItemStock] [real] NOT NULL
)
GO

