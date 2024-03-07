IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'FileTracker')
BEGIN
  CREATE DATABASE FileTracker;
END;
GO

/****** 
Tables: 2
Tables:
- Requests
- Users
******/

/****** Object:  Table [dbo].[Requests]  ******/
DROP TABLE  IF EXISTS [dbo].[Requests]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Requests](
	[RequestID] [int] IDENTITY(1,1) NOT NULL,
	[ClientFirstName] [varchar](50) NULL,
	[ClientLastName] [varchar](50) NULL,
	[ClientLastFourSSN] [char](4) NULL,
	[Comment] [text] NULL,
	[CommentLastUpdatedDate] [datetime] NULL,
	[IsCancelled] [bit] NULL,
	[CancelledDate] [datetime] NULL,
	[RequestDate] [datetime] NULL,
	[CheckOutDate] [datetime] NULL,
	[IsPickUpRequested] [bit] NULL,
	[PickUpRequestDate] [datetime] NULL,
	[CheckedInDate] [datetime] NULL,
	[RequestedByUserID] [int] NULL,
	[CheckedOutByUserID] [int] NULL,
	[CheckedInByUserID] [int] NULL,
	[PriorityID] [int] NULL,
	[PurposeID] [int] NULL,
 CONSTRAINT [PK_Requests] PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



/****** Object:  Table [dbo].[Users]   ******/

DROP TABLE IF EXISTS [dbo].[Users]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Email] [varchar](100) NULL,
	[Password] [varchar](50) NULL,
	[IsEnabled] [bit] NULL,
	[RoleID] [int] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
