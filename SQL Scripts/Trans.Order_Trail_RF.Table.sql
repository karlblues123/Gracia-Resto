USE [CGDB]
GO
/****** Object:  Table [Trans].[Order_Trail_RF]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Trans].[Order_Trail_RF](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[GUC] [nvarchar](5) NOT NULL,
	[TrailCode] [nvarchar](1) NOT NULL,
	[DI] [datetime] NOT NULL,
	[DU] [datetime] NOT NULL,
 CONSTRAINT [PK_Order_Trail_RF] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [Trans].[Order_Trail_RF] ADD  CONSTRAINT [DF_Order_Trail_RF_DI]  DEFAULT (getdate()) FOR [DI]
GO
ALTER TABLE [Trans].[Order_Trail_RF] ADD  CONSTRAINT [DF_Order_Trail_RF_DU]  DEFAULT (getdate()) FOR [DU]
GO
