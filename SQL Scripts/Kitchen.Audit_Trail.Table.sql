USE [GRDB]
GO
/****** Object:  Table [Kitchen].[Audit_Trail]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Kitchen].[Audit_Trail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SalesCode] [nvarchar](10) NOT NULL,
	[Notes] [nvarchar](150) NULL,
	[ActionMade] [nvarchar](50) NULL,
	[DI] [datetime] NOT NULL CONSTRAINT [DF_Audit_Trail_DI]  DEFAULT (getdate()),
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_Audit_Trail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
