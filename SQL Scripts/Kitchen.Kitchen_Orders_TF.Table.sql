USE [GRDB]
GO
/****** Object:  Table [Kitchen].[Kitchen_Orders_TF]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Kitchen].[Kitchen_Orders_TF](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SalesCode] [nvarchar](15) NOT NULL,
	[KitchenStatusID] [int] NULL CONSTRAINT [DF_Kitchen_Orders_TF_KitchenStatusID]  DEFAULT ((1)),
	[TrailHistory] [nvarchar](max) NULL CONSTRAINT [DF_Kitchen_Orders_TF_TrailHistory]  DEFAULT (''),
	[LastUpdate] [datetime] NULL,
	[DI] [datetime] NOT NULL CONSTRAINT [DF_Kitchen_Orders_TF_DI]  DEFAULT (getdate()),
 CONSTRAINT [PK_Kitchen_Orders_TF] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
