USE [GRDB]
GO
/****** Object:  UserDefinedTableType [Menu].[DISH_LINE]    Script Date: 8/28/2024 8:46:44 AM ******/
CREATE TYPE [Menu].[DISH_LINE] AS TABLE(
	[DishCode] [nvarchar](15) NOT NULL,
	[ItemCode] [nvarchar](20) NOT NULL,
	[ItemQuantity] [real] NULL,
	PRIMARY KEY CLUSTERED 
(
	[ItemCode] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
