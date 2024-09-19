USE [GRDB]
GO

/****** Object:  Table [Master].[Table_Audit_Trail]    Script Date: 9/7/2024 2:01:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Master].[Table_Audit_Trail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TableNumber] [int] NOT NULL,
	[Customer] [nvarchar](30) NULL,
	[TYPE] [nvarchar](10) NULL,
	[DI] [datetime] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_Table_Audit_Trail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [Master].[Table_Audit_Trail] ADD  CONSTRAINT [DF_Table_Audit_Trail_DI]  DEFAULT (getdate()) FOR [DI]
GO

