USE [GRDB]
GO
/****** Object:  Table [Master].[Tables_MF]    Script Date: 9/19/2024 10:25:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Master].[Tables_MF](
	[TableID] [int] IDENTITY(1,1) NOT NULL,
	[TableNumber] [int] NULL,
	[TableName] [nvarchar](30) NOT NULL,
	[Capacity] [int] NOT NULL,
	[Location] [nvarchar](50) NULL,
	[IsAvailable] [bit] NOT NULL CONSTRAINT [DF_Tables_MF_IsAvailable]  DEFAULT ((1)),
	[TableCode] [nvarchar](6) NULL,
 CONSTRAINT [PK_Tables_MF] PRIMARY KEY CLUSTERED 
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [Master].[Tables_MF] ON 

INSERT [Master].[Tables_MF] ([TableID], [TableNumber], [TableName], [Capacity], [Location], [IsAvailable], [TableCode]) VALUES (1, 1, N'Table 1', 6, N'Front', 1, N'84618')
INSERT [Master].[Tables_MF] ([TableID], [TableNumber], [TableName], [Capacity], [Location], [IsAvailable], [TableCode]) VALUES (2, 2, N'Table 2', 4, N'2nd', 1, N'94022')
INSERT [Master].[Tables_MF] ([TableID], [TableNumber], [TableName], [Capacity], [Location], [IsAvailable], [TableCode]) VALUES (3, 3, N'Table 3', 4, N'Edit this', 1, N'135898')
INSERT [Master].[Tables_MF] ([TableID], [TableNumber], [TableName], [Capacity], [Location], [IsAvailable], [TableCode]) VALUES (4, 4, N'Table 4', 4, N'Edit this', 1, N'678033')
INSERT [Master].[Tables_MF] ([TableID], [TableNumber], [TableName], [Capacity], [Location], [IsAvailable], [TableCode]) VALUES (5, 5, N'Table 5', 4, N'edit', 1, N'522807')
INSERT [Master].[Tables_MF] ([TableID], [TableNumber], [TableName], [Capacity], [Location], [IsAvailable], [TableCode]) VALUES (6, 6, N'Table 6', 4, N'Edit this', 1, N'988606')
INSERT [Master].[Tables_MF] ([TableID], [TableNumber], [TableName], [Capacity], [Location], [IsAvailable], [TableCode]) VALUES (7, 7, N'Table 7', 4, N'Edit this', 1, N'534044')
INSERT [Master].[Tables_MF] ([TableID], [TableNumber], [TableName], [Capacity], [Location], [IsAvailable], [TableCode]) VALUES (8, 8, N'Table 8', 4, N'Edit this', 1, N'667080')
INSERT [Master].[Tables_MF] ([TableID], [TableNumber], [TableName], [Capacity], [Location], [IsAvailable], [TableCode]) VALUES (9, 9, N'Table 9', 4, N'Edit this', 1, N'275726')
INSERT [Master].[Tables_MF] ([TableID], [TableNumber], [TableName], [Capacity], [Location], [IsAvailable], [TableCode]) VALUES (10, 10, N'Table 10', 4, N'Edit this', 1, N'741524')
SET IDENTITY_INSERT [Master].[Tables_MF] OFF
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This will put in table to be encoded by the customer' , @level0type=N'SCHEMA',@level0name=N'Master', @level1type=N'TABLE',@level1name=N'Tables_MF', @level2type=N'COLUMN',@level2name=N'TableCode'
GO
