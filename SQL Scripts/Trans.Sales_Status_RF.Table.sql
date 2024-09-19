USE [GRDB]
GO
/****** Object:  Table [Trans].[Sales_Status_RF]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Trans].[Sales_Status_RF](
	[ID] [int] NOT NULL,
	[TypeID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Sales_Status_RF] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
