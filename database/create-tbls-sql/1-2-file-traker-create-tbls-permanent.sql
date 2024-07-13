IF EXISTS (SELECT * FROM sys.databases WHERE name = 'FileTracker')
BEGIN
  DROP DATABASE FileTracker;
END; 
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'FileTracker')
BEGIN
  CREATE DATABASE FileTracker;
END;
GO

USE FileTracker;
GO

/****** 
Tables: 4
Tables:
- Boxe
- File
- Request
- User
******/

/****** Object:  Table [dbo].[Box] ******/
DROP TABLE  IF EXISTS [dbo].[Box]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Box](
	[BoxID] [int] IDENTITY(1,1) NOT NULL,
	[BoxYear] char(4) NOT NULL,
	[BoxNumber] char(4) NOT NULL,
	[AnticipatedDeliveryToWarehouseDate] [date] NULL,
	[DeliveryToWarehouseDate] [date] NULL,
	[ActualDestructionDate] [date] NULL,
	[DateSubmitted] [date] NOT NULL,
	[LocationID] [int] NULL,
	[SubmittedByUserID] [int] NOT NULL,
 CONSTRAINT [PK_Box_BoxID] PRIMARY KEY CLUSTERED 
(
	[BoxID] ASC
))
GO

/****** Object:  Table [dbo].[File]  ******/
DROP TABLE  IF EXISTS [dbo].[File]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[File](
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
 CONSTRAINT [PK_File_FileID] PRIMARY KEY CLUSTERED 
(
	[FileID] ASC
))
GO

/****** Object:  Table [dbo].[Request]  ******/
DROP TABLE  IF EXISTS [dbo].[Request]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Request](
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
 CONSTRAINT [PK_Request_RequestID] PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
))
GO

/****** Object:  Table [dbo].[User]   ******/
DROP TABLE IF EXISTS [dbo].[User]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[IsEnabled] [bit] NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_User_UserID] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
))
GO
