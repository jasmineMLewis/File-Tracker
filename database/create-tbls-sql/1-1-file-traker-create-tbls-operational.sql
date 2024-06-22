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
	[BoxYear] char(4) NOT NULL,
	[BoxNumber] char(4) NOT NULL,
	[AnticipatedDeliveryToWarehouseDate] [date] NULL,
	[DeliveryToWarehouseDate] [date] NULL,
	[ActualDestructionDate] [date] NULL,
	[DateSubmitted] [date] NOT NULL,
	[LocationID] [int] NULL,
	[SubmittedByUserID] [int] NOT NULL,
 CONSTRAINT [PK_Boxes_BoxID] PRIMARY KEY CLUSTERED 
(
	[BoxID] ASC
))
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
	[ClientFirstName] [varchar](50) NOT NULL,
	[ClientLastName] [varchar](50) NOT NULL,
	[LastFourSSN] [char](4) NOT NULL,
	[PurgeTypeDate] [date] NULL,
	[Notes] [varchar](1000) NULL,
	[IsDestroyed] [tinyint] NULL,
	[DateSubmitted] [datetime] NOT NULL,
	[PurgeTypeID] [int] NULL,
	[BoxID] [int] NOT NULL,
	[LocationID] [int] NULL,
	[SubmittedByUserID] [int] NOT NULL
 CONSTRAINT [PK_Files_FileID] PRIMARY KEY CLUSTERED 
(
	[FileID] ASC
))
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
	[ClientFirstName] [varchar](50) NOT NULL,
	[ClientLastName] [varchar](50) NOT NULL,
	[ClientLastFourSSN] [char](4) NOT NULL,
	[Comment] [text] NULL,
	[CommentLastUpdatedDate] [datetime] NULL,
	[IsCancelled] [tinyint] NULL,
	[CancelledDate] [datetime] NULL,
	[RequestDate] [datetime] NULL,
	[CheckOutDate] [datetime] NULL,
	[IsPickUpRequested] [bit] NULL,
	[PickUpRequestDate] [datetime] NULL,
	[CheckedInDate] [datetime] NULL,
	[RequestedByUserID] [int] NULL,
	[CheckedOutByUserID] [int] NULL,
	[CheckedInByUserID] [int] NULL,
	[PriorityID] [int] NOT NULL,
	[PurposeID] [int] NOT NULL,
 CONSTRAINT [PK_Requests_RequestID] PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
))
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
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[IsEnabled] [bit] NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_Users_UserID] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
))
GO
