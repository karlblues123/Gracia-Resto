USE [GRDB]
GO
/****** Object:  Table [Master].[Table_Info_Trail]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Master].[Table_Info_Trail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TableNumber] [int] NOT NULL,
	[Notes] [nvarchar](150) NULL,
	[ActionMade] [nvarchar](50) NULL,
	[DI] [datetime] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_Table_Info_Trail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [Master].[Table_Info_Trail] ADD  CONSTRAINT [DF_Table_Info_Trail_DI]  DEFAULT (getdate()) FOR [DI]
GO
