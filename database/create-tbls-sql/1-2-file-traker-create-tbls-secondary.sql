USE FileTracker;
GO

/****** 
Tables: 3
- Location
- PurgeType
- Roles
******/


/****** Object:  Table [dbo].[Location]  ******/
DROP TABLE  IF EXISTS [dbo].[Location]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Location](
	[LocationID] [int] IDENTITY(1,1) NOT NULL,
	[Location] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Location_LocationID] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
))
GO


/****** Object:  Table [dbo].[PurgeType]    ******/
DROP TABLE  IF EXISTS [dbo].[PurgeType]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PurgeType](
	[PurgeTypeID] [int] IDENTITY(1,1) NOT NULL,
	[PurgeType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_PurgeType_PurgeTypeID] PRIMARY KEY CLUSTERED 
(
	[PurgeTypeID] ASC
))
GO

/****** Object:  Table [dbo].[Roles] ******/
DROP TABLE  IF EXISTS [dbo].[Roles]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[Role] [varchar](50) NOT NULL,
	[Description] [varchar](50) NULL,
	[Access] [varchar](500) NULL,
 CONSTRAINT [PK_Roles_RoleID] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
))
GO
