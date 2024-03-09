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
INSERT INTO Location (Location) VALUES ('Off Site');

/****** Object:  Table [dbo].[PurgeType]  ******/
INSERT INTO PurgeType (PurgeType) VALUES ('End Of Participation'); 
INSERT INTO PurgeType (PurgeType) VALUES ('Denial/Withdrawal');
INSERT INTO PurgeType (PurgeType) VALUES ('Port Out');

/****** Object:  Table [dbo].[Roles]  ******/
INSERT INTO Roles (Role, Description, Access) VALUES ('Admin', 'Admin', 'Admin'); 
INSERT INTO Roles (Role, Description, Access) VALUES ('Project Specialist', 'Project Specialist', 'Project Specialist'); 
INSERT INTO Roles (Role, Description, Access) VALUES ('Housing Specialist', 'Housing Specialist', 'Housing Specialist');
INSERT INTO Roles (Role, Description, Access) VALUES ('File Room Clerk', 'File Room Clerk', 'File Room Clerk');
INSERT INTO Roles (Role, Description, Access) VALUES ('Viewer', 'Viewer', 'Viewer');
