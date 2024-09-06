USE [CGDB]
GO

/****** Object:  Table [Menu].[Item_Data]    Script Date: 2/3/2024 10:43:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Menu].[Item_Data](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ItemCode] [nvarchar](20) NOT NULL,
	[ItemName] [nvarchar](50) NOT NULL,
	[ItemPrice] [decimal](18, 2) NOT NULL,
	[ItemUM] [nvarchar](10) NOT NULL,
	[ItemStock] [real] NOT NULL CONSTRAINT [DF_Item_Data_ItemStock]  DEFAULT ((0)),
 CONSTRAINT [PK_Item_Data] PRIMARY KEY CLUSTERED 
(
	[ItemCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

