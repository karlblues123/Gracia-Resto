USE [GRDB]
GO
/****** Object:  UserDefinedTableType [Menu].[ITEM_DATA]    Script Date: 8/28/2024 8:46:45 AM ******/
CREATE TYPE [Menu].[ITEM_DATA] AS TABLE(
	[ItemCode] [nvarchar](20) NOT NULL,
	[ItemName] [nvarchar](50) NOT NULL,
	[ItemPrice] [decimal](18, 2) NOT NULL,
	[ItemUM] [nvarchar](10) NOT NULL
)
GO
