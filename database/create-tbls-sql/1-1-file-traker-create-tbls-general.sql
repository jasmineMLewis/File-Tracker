IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'FileTracker')
BEGIN
  CREATE DATABASE FileTracker;
END;
GO

/****** 
Tables: 4
Tables:
- Boxes
- Files
- Requests
- Users
******/

/****** Object:  Table [dbo].[Boxes] ******/
DROP TABLE  IF EXISTS [dbo].[Boxes]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Boxes](
	[BoxID] [int] IDENTITY(1,1) NOT NULL,
	[BoxNumber] char(4) NULL,
	[Year] char(4) NULL,
	[AnticipatedDeliveryToWarehouseDate] [date] NULL,
	[DeliveryToWarehouseDate] [date] NULL,
	[ActualDestructionDate] [date] NULL,
	[DateSubmitted] [date] NULL,
	[LocationID] [int] NULL,
	[SubmittedByUserID] [int] NULL,
 CONSTRAINT [PK_Boxes] PRIMARY KEY CLUSTERED 
(
	[BoxID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Files]  ******/
DROP TABLE  IF EXISTS [dbo].[Files]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Files](
	[FileID] [int] IDENTITY(1,1) NOT NULL,
	[ClientFirstName] [varchar](50) NULL,
	[ClientLastName] [varchar](50) NULL,
	[LastFourSSN] [char](4) NULL,
	[PurgeTypeDate] [date] NULL,
	[Notes] [varchar](1000) NULL,
	[IsDestroyed] [bit] NULL,
	[DateSubmitted] [date] NULL,
	[PurgeTypeID] [int] NULL,
	[BoxID] [int] NULL,
	[LocationID] [int] NULL,
	[SubmittedByUserID] [int] NULL
 CONSTRAINT [PK_Files] PRIMARY KEY CLUSTERED 
(
	[FileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

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
