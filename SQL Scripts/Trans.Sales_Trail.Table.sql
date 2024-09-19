USE [GRDB]
GO
/****** Object:  Table [Trans].[Sales_Trail]    Script Date: 8/28/2024 8:46:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Trans].[Sales_Trail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SalesCode] [nvarchar](15) NOT NULL,
	[Notes] [nvarchar](150) NULL,
	[ActionMade] [nvarchar](50) NOT NULL,
	[DI] [datetime] NOT NULL CONSTRAINT [DF_Sales_Trail_DI]  DEFAULT (getdate()),
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_Sales_Trail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [Trans].[Sales_Trail]  WITH CHECK ADD  CONSTRAINT [FK_Sales_Trail_Sales_Hdr] FOREIGN KEY([SalesCode])
REFERENCES [Trans].[Sales_Hdr] ([SalesCode])
GO
ALTER TABLE [Trans].[Sales_Trail] CHECK CONSTRAINT [FK_Sales_Trail_Sales_Hdr]
GO
