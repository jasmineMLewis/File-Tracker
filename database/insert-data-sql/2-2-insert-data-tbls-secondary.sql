USE FileTracker;
GO

/****** 
Tables: 3
- Location
- PurgeType
- Roles
******/

/****** Object:  Table [dbo].[Location]  ******/
INSERT INTO Location (Location) VALUES ('At Warehouse'); 
INSERT INTO Location (Location) VALUES ('On Site');
INSERT INTO Location (Location) VALUES ('Unknown');

/****** Object:  Table [dbo].[PurgeType]  ******/
INSERT INTO PurgeType (PurgeType) VALUES ('End Of Participation'); 
INSERT INTO PurgeType (PurgeType) VALUES ('Denial/Withdrawal');
INSERT INTO PurgeType (PurgeType) VALUES ('Port Out');

/****** Object:  Table [dbo].[Roles]  ******/
INSERT INTO Roles (Role, Description, Access) VALUES ('Admin', '', '1) All Project Specialists, Housing Specialists, & File Room Clerks Features 2) Create & Edit Users'); 
INSERT INTO Roles (Role, Description, Access) VALUES ('Project Specialist', '', '1) Create Files to Purge 2) Create Boxes of Files to Purge 3) Create a File Request 4) Check Out, Request Pick Up and Check In for File Requests'); 
INSERT INTO Roles (Role, Description, Access) VALUES ('Housing Specialist', '', '1) Create a File Request 2) Check Out, Request Pick Up and Check In for File Requests');
INSERT INTO Roles (Role, Description, Access) VALUES ('File Room Clerk', '', '1) View File Requests from all Users 2) Export File Requests to Excel');
INSERT INTO Roles (Role, Description, Access) VALUES ('Viewer', '', '');
