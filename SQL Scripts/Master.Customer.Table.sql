USE [GRDB]
GO
/****** Object:  Table [Master].[Customer]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Master].[Customer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GuestCode] [nvarchar](6) NOT NULL,
	[LastName] [nvarchar](15) NOT NULL,
	[FirstName] [nvarchar](15) NOT NULL,
	[Birthdate] [datetime] NOT NULL,
	[Gender] [char](1) NOT NULL,
	[DI] [datetime] NOT NULL CONSTRAINT [DF_Customer_DI]  DEFAULT (getdate()),
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[GuestCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
