USE [CGDB]
GO

/****** Object:  Table [xSystem].[SeriesNumber_RF]    Script Date: 2/3/2024 10:44:22 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [xSystem].[SeriesNumber_RF](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Prefix] [nchar](5) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[Series] [int] NOT NULL CONSTRAINT [DF_SeriesNumber_RF_Series]  DEFAULT ((0)),
 CONSTRAINT [PK_SeriesNumber_RF] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

