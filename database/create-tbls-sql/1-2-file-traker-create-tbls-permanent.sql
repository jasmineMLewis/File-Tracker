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
- User
- Box
- File
- Request
******/


/****** Object:  Table dbo.User   ******/
DROP TABLE IF EXISTS dbo.[User]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.[User](
	UserID int IDENTITY(1,1) NOT NULL,
	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	Email varchar(100) NOT NULL,
	Password varchar(50) NOT NULL,
	IsEnabled bit NOT NULL,
	RoleID int NOT NULL,
 CONSTRAINT PK_User_UserID PRIMARY KEY CLUSTERED (UserID ASC),
 CONSTRAINT FK_User_RoleID_Role_RoleID FOREIGN KEY (RoleID) REFERENCES [Role](RoleID) ON DELETE CASCADE,
 INDEX IX_User_RoleID NONCLUSTERED (RoleID),
 INDEX IX_User_FirstName NONCLUSTERED (FirstName),
 INDEX IX_User_LastName NONCLUSTERED (LastName),
 INDEX IX_User_Email NONCLUSTERED (Email)
)
GO

/****** Object:  Table dbo.Box ******/
DROP TABLE  IF EXISTS dbo.Box
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Box(
	BoxID int IDENTITY(1,1) NOT NULL,
	BoxYear char(4) NOT NULL,
	BoxNumber char(4) NOT NULL,
	AnticipatedDeliveryToWarehouseDate date NULL,
	DeliveryToWarehouseDate date NULL,
	ActualDestructionDate date NULL,
	DateSubmitted date NOT NULL,
	LocationID int NOT NULL,
	SubmittedByUserID int NOT NULL,
 CONSTRAINT PK_Box_BoxID PRIMARY KEY CLUSTERED (BoxID ASC),
 CONSTRAINT FK_Box_LocationID_Location_LocationID FOREIGN KEY (LocationID) REFERENCES [Location](LocationID) ON DELETE CASCADE,
 INDEX IX_Box_LocationID NONCLUSTERED (LocationID),
 CONSTRAINT FK_Box_SubmittedByUserID_User_UserID FOREIGN KEY (SubmittedByUserID) REFERENCES [User](UserID)  ON DELETE CASCADE,
 INDEX IX_Box_SubmittedByUserID NONCLUSTERED (SubmittedByUserID),
 INDEX IX_Box_AnticipatedDeliveryToWarehouseDate NONCLUSTERED (AnticipatedDeliveryToWarehouseDate),
 INDEX IX_Box_DeliveryToWarehouseDate NONCLUSTERED (DeliveryToWarehouseDate),
 INDEX IX_Box_ActualDestructionDate NONCLUSTERED (ActualDestructionDate)
)
GO


/****** Object:  Table dbo.File  ******/
DROP TABLE  IF EXISTS dbo.[File]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.[File](
	FileID int IDENTITY(1,1) NOT NULL,
	ClientFirstName varchar(50) NOT NULL,
	ClientLastName varchar(50) NOT NULL,
	ClientLastFourSSN char(4) NOT NULL,
	PurgeTypeDate date NULL,
	Notes varchar(1000) NULL,
	IsDestroyed tinyint NOT NULL,
	DateSubmitted datetime NOT NULL,
	PurgeTypeID int NOT NULL,
	BoxID int NOT NULL,
	LocationID int NOT NULL,
	SubmittedByUserID int NOT NULL,
 CONSTRAINT PK_File_FileID PRIMARY KEY CLUSTERED (FileID ASC),
 CONSTRAINT FK_File_PurgeTypeID_PurgeType_PurgeTypeID FOREIGN KEY (PurgeTypeID) REFERENCES [PurgeType](PurgeTypeID) ON DELETE CASCADE,
 INDEX IX_File_PurgeTypeID NONCLUSTERED (PurgeTypeID),
 CONSTRAINT FK_File_BoxID_Box_BoxID FOREIGN KEY (BoxID) REFERENCES [Box](BoxID) ON DELETE CASCADE,
 INDEX IX_File_BoxID NONCLUSTERED (BoxID),
 CONSTRAINT FK_File_LocationID_Location_LocationID FOREIGN KEY (LocationID) REFERENCES [Location](LocationID),
 INDEX IX_File_LocationID NONCLUSTERED (LocationID),
 CONSTRAINT FK_File_SubmittedByUserID_User_UserID FOREIGN KEY (SubmittedByUserID) REFERENCES [User](UserID),
 INDEX IX_File_SubmittedByUserID NONCLUSTERED (SubmittedByUserID),
 INDEX IX_File_ClientFirstName NONCLUSTERED (ClientFirstName),
 INDEX IX_File_ClientLastName NONCLUSTERED (ClientLastName),
 INDEX IX_File_ClientLastFourSSN NONCLUSTERED (ClientLastFourSSN)
)
GO

/****** Object:  Table dbo.Request  ******/
DROP TABLE  IF EXISTS dbo.Request
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Request(
	RequestID int IDENTITY(1,1) NOT NULL,
	ClientFirstName varchar(50) NOT NULL,
	ClientLastName varchar(50) NOT NULL,
	ClientLastFourSSN char(4) NOT NULL,
	Comment text NULL,
	CommentLastUpdatedDate datetime NULL,
	IsCancelled tinyint NULL,
	CancelledDate datetime NULL,
	RequestDate datetime NULL,
	CheckOutDate datetime NULL,
	IsPickUpRequested bit NULL,
	PickUpRequestDate datetime NULL,
	CheckedInDate datetime NULL,
	RequestedByUserID int NULL,
	CheckedOutByUserID int NULL,
	CheckedInByUserID int NULL,
	PriorityID int NOT NULL,
	PurposeID int NOT NULL,
 CONSTRAINT PK_Request_RequestID PRIMARY KEY CLUSTERED (RequestID ASC),
 CONSTRAINT FK_Request_PriorityID_Priority_PriorityID FOREIGN KEY (PriorityID) REFERENCES [Priority](PriorityID) ON DELETE CASCADE,
 INDEX IX_Request_PriorityID NONCLUSTERED (PriorityID),
 CONSTRAINT FK_Request_PurposeID_Purpose_PurposeID FOREIGN KEY (PurposeID) REFERENCES [Purpose](PurposeID) ON DELETE CASCADE,
 INDEX IX_Request_PurposeID NONCLUSTERED (PurposeID),
 INDEX IX_Request_ClientFirstName NONCLUSTERED (ClientFirstName),
 INDEX IX_Request_ClientLastName NONCLUSTERED (ClientLastName),
 INDEX IX_Request_ClientLastFourSSN NONCLUSTERED (ClientLastFourSSN),
 INDEX IX_Request_RequestDate NONCLUSTERED (RequestDate)
)
GO
