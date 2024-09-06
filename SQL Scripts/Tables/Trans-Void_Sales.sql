USE [CGDB]
GO

/****** Object:  Table [Trans].[Void_Sales]    Script Date: 2/8/2024 4:41:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Trans].[Void_Sales](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[VoidCode] [nvarchar](15) NOT NULL,
	[SalesCode] [nvarchar](15) NOT NULL,
	[Date] [date] NOT NULL,
	[Reason] [nvarchar](250) NULL,
 CONSTRAINT [PK_Void_Sales] PRIMARY KEY CLUSTERED 
(
	[VoidCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [Trans].[Void_Sales]  WITH CHECK ADD  CONSTRAINT [FK_Void_Sales_Sales_Hdr] FOREIGN KEY([SalesCode])
REFERENCES [Trans].[Sales_Hdr] ([SalesCode])
GO

ALTER TABLE [Trans].[Void_Sales] CHECK CONSTRAINT [FK_Void_Sales_Sales_Hdr]
GO


