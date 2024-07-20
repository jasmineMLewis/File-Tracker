IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'FileTracker')
BEGIN
  CREATE DATABASE FileTracker;
END;
GO

USE FileTracker;
GO

/****** 
Tables: 5
- Location
- Priority
- PurgeType
- Purpose
- Role
******/


/****** Object:  Table dbo.Location  ******/
DROP TABLE  IF EXISTS dbo.Location
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Location(
	LocationID int IDENTITY(1,1) NOT NULL,
	Location varchar(50) NOT NULL,
 CONSTRAINT PK_Location_LocationID PRIMARY KEY CLUSTERED (LocationID ASC)
)
GO


/****** Object:  Table dbo.Priority    ******/
DROP TABLE  IF EXISTS dbo.Priority
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Priority(
	PriorityID int IDENTITY(1,1) NOT NULL,
	Priority varchar(50) NOT NULL,
 CONSTRAINT PK_Priority_PriorityID PRIMARY KEY CLUSTERED (PriorityID ASC)
)
GO


/****** Object:  Table dbo.PurgeType    ******/
DROP TABLE  IF EXISTS dbo.PurgeType
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.PurgeType(
	PurgeTypeID int IDENTITY(1,1) NOT NULL,
	PurgeType varchar(50) NOT NULL,
 CONSTRAINT PK_PurgeType_PurgeTypeID PRIMARY KEY CLUSTERED (PurgeTypeID ASC)
)
GO


/****** Object:  Table dbo.Purpose    ******/
DROP TABLE  IF EXISTS dbo.Purpose
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Purpose(
	PurposeID int IDENTITY(1,1) NOT NULL,
	Purpose varchar(50) NOT NULL,
 CONSTRAINT PK_Purpose_PurposeID PRIMARY KEY CLUSTERED (PurposeID ASC)
)
GO


/****** Object:  Table dbo.Role ******/
DROP TABLE  IF EXISTS dbo.Role
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Role(
	RoleID int IDENTITY(1,1) NOT NULL,
	Role varchar(50) NOT NULL,
	Description varchar(200) NULL,
	Access varchar(500) NULL,
 CONSTRAINT PK_Role_RoleID PRIMARY KEY CLUSTERED (RoleID ASC)
)
GO
